import 'package:fantasy_football/helpers/db.dart';
import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/models/rating.dart';
import 'package:fantasy_football/services/DbServices/rounds_db_services.dart';
import 'package:fantasy_football/services/DbServices/shared_db_services.dart';
import 'package:fantasy_football/services/api_services.dart';
import 'package:firebase_database/firebase_database.dart';

class PlayersDbServices
{
  static Future importPlayers() async
  {
    await FirebaseDatabase.instance.ref("players").remove();
    for(var player in await ApiServices.getPlayers())
    {
      await FirebaseDatabase.instance.ref("players/${player.playerID}").set(player.toJson());
    }
  }

  static Future<List<Player>> getPlayers() async
  {
    List<Player> players = [];
    List<Future<DatabaseEvent>> playersFutures = [];

    for(var key in await SharedDbServices.getNodeKeys("players"))
    {
      playersFutures.add(FirebaseDatabase.instance.ref("players/$key").once());
    }

  	var snapshots = (await Future.wait(playersFutures)).map((e) => e.snapshot);

    for(var snapshot in snapshots)
    {
      players.add(Player.fromJson(
        int.parse(snapshot.key as String), 
        snapshot.value as dynamic,
      ));
    }

    return players;
  }

  static Future<Player> getPlayer(int playerId) async
  {
    var databaseEvent = await FirebaseDatabase.instance.ref("players/$playerId").once();
    var rounds = await RoundsDbServices.loadRounds();
    var player = Player.fromJson(
      playerId,
      databaseEvent.snapshot.value
    );

    for(var roundId in await SharedDbServices.getNodeKeys("players/$playerId/ratings"))
    {
      player.ratings.add(Rating(
        round: rounds.firstWhere((r) => r.roundId == roundId),
        rating: HelperDb.readDouble(((await FirebaseDatabase.instance.ref("players/$playerId/ratings/$roundId").once()).snapshot.value as dynamic)["value"])
      ));
    }

    return player; 
  }
}