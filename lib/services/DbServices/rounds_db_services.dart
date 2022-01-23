import 'package:fantasy_football/models/round.dart';
import 'package:fantasy_football/services/DbServices/shared_db_services.dart';
import 'package:fantasy_football/services/DbServices/users_db_services.dart';
import 'package:fantasy_football/services/random_services.dart';
import 'package:firebase_database/firebase_database.dart';

class RoundsDbServices
{
  static Future initRounds() async
  {
    List<Future<void>> futures = [];
    for(var playerId in await SharedDbServices.getNodeKeys("players"))
    {
      futures.add(FirebaseDatabase.instance.ref("players/$playerId/ratings").remove());
    }

    for(var userId in await SharedDbServices.getNodeKeys("users"))
    {
      futures.add(FirebaseDatabase.instance.ref("users/$userId").update({"points": 0.0}));
    }

    for(int i = 1; i <= 38; i++)
    {
      futures.add(FirebaseDatabase.instance.ref("rounds/$i").set(
        Round(roundId: i.toString(), shortName: "R$i", longName: "Round $i", played: false).toJson()
      ));
    }

    Future.wait(futures);
  }

  static Future<List<Round>> loadRounds() async
  {
    List<Round> rounds = [];

    for(int i = 1; i <= 38; i++)
    {
      DatabaseEvent event = await FirebaseDatabase.instance.ref("rounds/$i").once();
      rounds.add(Round.fromJson(i.toString(), event.snapshot.value));
    }

    return rounds;
  }

  static Future simulateRound(List<Round> rounds) async
  {
    List<Future> futures = [];
    String nextRoundId = rounds.firstWhere((r) => !r.played).roundId;

    Map<String, double> playerRatings = {};

    for(var playerId in await SharedDbServices.getNodeKeys("players"))
    {
      playerRatings[playerId] = RandomServices.randomDouble(1, 10);
      if(RandomServices.randomBool())
      {
        //80 percent chances that the player played this round
        futures.add(FirebaseDatabase.instance.ref("players/$playerId/ratings/$nextRoundId")
        .set({
          "value": playerRatings[playerId]
        }));
      }
      else
      {
        playerRatings[playerId] = 0;
      }
    }

    for(var user in await UserDbServices.getUsers())
    {
      double incrementValue = 0;
      for(var playerId in user.firstTeamPlayerIds)
      {
        incrementValue += playerRatings[playerId.toString()] as double;
      }

      futures.add(FirebaseDatabase.instance.ref("users/${user.userId}").update(
        {"points": user.points + incrementValue}
      ));
    }

    Future.wait(futures);
    await FirebaseDatabase.instance.ref("rounds/$nextRoundId")
      .update({"played": true});
  }
}