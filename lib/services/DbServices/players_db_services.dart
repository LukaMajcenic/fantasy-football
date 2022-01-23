import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/models/player_image.dart';
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
    List<Future<PlayerImage>> imagesFutures = [];

    for(var key in await SharedDbServices.getNodeKeys("players"))
    {
      playersFutures.add(FirebaseDatabase.instance.ref("players/$key").once());
      imagesFutures.add(Player.getUint8List(int.parse(key)));
    }

  	var snapshots = (await Future.wait(playersFutures)).map((e) => e.snapshot);
    var images = await Future.wait(imagesFutures);

    for(var snapshot in snapshots)
    {
      players.add(Player.fromJson(
        int.parse(snapshot.key as String), 
        snapshot.value as dynamic,
        images.firstWhere((image) => image.playerID.toString() == snapshot.key).uint8list
      ));
    }

    return players;
  }

  static Future<Player> getPlayer(int playerId, List<PlayerImage> images) async
  {
    var databaseEvent = await FirebaseDatabase.instance.ref("players/$playerId").once();
    var rounds = await RoundsDbServices.loadRounds();
    var player = Player.fromJson(
      playerId,
      databaseEvent.snapshot.value, 
      images.firstWhere((image) => image.playerID == playerId).uint8list
    );

    for(var roundId in await SharedDbServices.getNodeKeys("players/$playerId/ratings"))
    {
      player.ratings.add(Rating(
        round: rounds.firstWhere((r) => r.roundId == roundId),
        rating: ((await FirebaseDatabase.instance.ref("players/$playerId/ratings/$roundId").once()).snapshot.value as dynamic)["value"]
      ));
    }

    return player; 
  }
}