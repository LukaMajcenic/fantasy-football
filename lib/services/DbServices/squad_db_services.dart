import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/models/player_image.dart';
import 'package:fantasy_football/models/squad.dart';
import 'package:fantasy_football/services/DbServices/players_db_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class SquadDbServices
{
  static Future initSquad() async
  {
    await FirebaseDatabase.instance.ref("users/${FirebaseAuth.instance.currentUser?.uid}").set({
      "squadSelected": false,
      "points": 0
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

    if(values["squadSelected"])
    {
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

      return Squad(
        goalkeeper: await PlayersDbServices.getPlayer(playerIDs[0], images),
        defender: await PlayersDbServices.getPlayer(playerIDs[1], images),
        midfielder: await PlayersDbServices.getPlayer(playerIDs[2], images),
        attacker: await PlayersDbServices.getPlayer(playerIDs[3], images),
        sub1: await PlayersDbServices.getPlayer(playerIDs[4], images),
        sub2: await PlayersDbServices.getPlayer(playerIDs[5], images),
        squadSelected: true
      );
    }
    
    return Squad(squadSelected: false);
  }
}