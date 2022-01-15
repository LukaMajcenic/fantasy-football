import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/models/player_image.dart';
import 'package:fantasy_football/models/squad.dart';
import 'package:fantasy_football/services/api_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class DbServices
{
  static Future<List<String>> getNodeKeys(String node) async
  {
    DatabaseEvent event = await FirebaseDatabase.instance.ref(node).once();
    return event.snapshot.children.map((snapshot) => snapshot.key as String).toList();
  }

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

    for(var key in await getNodeKeys("players"))
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

    return Player.fromJson(
      playerId,
      databaseEvent.snapshot.value, 
      images.firstWhere((image) => image.playerID == playerId).uint8list
    );
  }

  static Future initSquad() async
  {
    await FirebaseDatabase.instance.ref("users/${FirebaseAuth.instance.currentUser?.uid}").set({
      "squadSelected": false
    });
  }

  static Future saveSquad(Squad squad) async
  {
    print(squad.toJson());
    await FirebaseDatabase.instance.ref("users/${FirebaseAuth.instance.currentUser?.uid}").update(squad.toJson());
    print("Squad updated");
  }

  static Future<Squad> loadSquad() async
  {
    DatabaseEvent event = await FirebaseDatabase.instance.ref("users/${FirebaseAuth.instance.currentUser?.uid}").once();
    dynamic values = event.snapshot.value as dynamic;

    List<Future<PlayerImage>> imagesFutures = [];
    List<int> playerIDs = [
      values['goalkeeperId'],
      values['defenderId'],
      values['midfielderId'],
      values['attackerId'],
      values['sub1Id'],
      values['sub2Id']
    ];

    for(var playerID in playerIDs){
      imagesFutures.add(Player.getUint8List(playerID));
    }
    List<PlayerImage> images = await Future.wait(imagesFutures);

    if(values["squadSelected"])
    {
      return Squad(
        goalkeeper: await DbServices.getPlayer(playerIDs[0], images),
        defender: await DbServices.getPlayer(playerIDs[1], images),
        midfielder: await DbServices.getPlayer(playerIDs[2], images),
        attacker: await DbServices.getPlayer(playerIDs[3], images),
        sub1: await DbServices.getPlayer(playerIDs[4], images),
        sub2: await DbServices.getPlayer(playerIDs[5], images),
        squadSelected: true
      );
    }

    
    return Squad(squadSelected: false);
  }

  static Future<bool> userNodeExists() async
  {
    DatabaseEvent event = await FirebaseDatabase.instance.ref("users/${FirebaseAuth.instance.currentUser?.uid}").once();
    return event.snapshot.exists;
  }
}