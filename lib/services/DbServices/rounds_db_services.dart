import 'package:fantasy_football/helpers/db.dart';
import 'package:fantasy_football/helpers/random.dart';
import 'package:fantasy_football/models/round.dart';
import 'package:fantasy_football/models/squad.dart';
import 'package:fantasy_football/services/DbServices/shared_db_services.dart';
import 'package:fantasy_football/services/DbServices/squad_db_services.dart';
import 'package:fantasy_football/services/DbServices/users_db_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      futures.add(FirebaseDatabase.instance.ref("users/$userId/rounds").remove());
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

      if(rounds.last.played)
      {
        DatabaseEvent event = await FirebaseDatabase.instance
          .ref("users/${FirebaseAuth.instance.currentUser?.uid}/rounds/${rounds.last.roundId}").once();

        var value = event.snapshot.value as dynamic;

        print(i);
        print(value);
        //Rounds is played but user hasn't been registered
        if(value == null)
        {
          continue;
        }

        rounds.last.score = HelperDb.readDouble(value["score"]);
        rounds.last.squadThatRound = {
          SquadRole.goalkeeper: value["goalkeeperId"] as int,
          SquadRole.defender: value["defenderId"] as int,
          SquadRole.midfielder: value["midfielderId"] as int,
          SquadRole.attacker: value["attackerId"] as int,
        };
      }
    }

    return rounds;
  }

  static Future simulateRound() async
  {
    String nextRoundId = (await RoundsDbServices.loadRounds()).firstWhere((r) => !r.played).roundId;
    List<Future> futures = [];
    Map<String, double> playerRatings = {};

    for(var playerId in await SharedDbServices.getNodeKeys("players"))
    {
      playerRatings[playerId] = HelperRandom.randomDouble(1, 10);
      if(HelperRandom.randomBool())
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
      double scorethisRound = 0;
      for(var playerId in user.firstTeamPlayerIds)
      {
        scorethisRound += playerRatings[playerId.toString()] as double;
      }

      futures.add(FirebaseDatabase.instance.ref("users/${user.userId}").update(
        {"points": user.points + scorethisRound,
        "pointsPrevRound": user.points}
      ));

      futures.add(FirebaseDatabase.instance.ref("users/${user.userId}/rounds").update(
        {
          nextRoundId: {
          "score": scorethisRound,
          "goalkeeperId": int.parse(user.firstTeamPlayerIds[0]),
          "defenderId": int.parse(user.firstTeamPlayerIds[1]),
          "midfielderId": int.parse(user.firstTeamPlayerIds[2]),
          "attackerId": int.parse(user.firstTeamPlayerIds[3]),
        }}
      ));
    }

    Future.wait(futures);
    await FirebaseDatabase.instance.ref("rounds/$nextRoundId")
      .update({"played": true});
  }
}