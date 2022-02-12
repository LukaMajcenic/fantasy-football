import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/models/position.dart';
import 'package:fantasy_football/models/squad.dart';
import 'package:fantasy_football/services/DbServices/players_db_services.dart';
import 'package:fantasy_football/services/DbServices/shared_db_services.dart';
import 'package:fantasy_football/services/DbServices/users_db_services.dart';
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

  static Future<bool> squadSelected() async
  {
    DatabaseEvent event = await FirebaseDatabase.instance.ref("users/${FirebaseAuth.instance.currentUser?.uid}").once();
    dynamic values = event.snapshot.value as dynamic;

    return values["squadSelected"];
  }

  static Future saveSquad(Squad squad) async
  {
    print(squad.goalkeeper);
    //print(squad.toJson());
    await FirebaseDatabase.instance.ref("users/${FirebaseAuth.instance.currentUser?.uid}").update(squad.toJson());
    print("Squad updated");
  }

  static Future<List<String>> loadSquadPlayerIds() async
  {
    DatabaseEvent event = await FirebaseDatabase.instance.ref("users/${FirebaseAuth.instance.currentUser?.uid}").once();
    dynamic values = event.snapshot.value as dynamic;

    if(values["squadSelected"])
    {
      return <String>[
        values['goalkeeperId'].toString(),
        /* values['defenderId'].toString(), */
        values['midfielderId'].toString(),
        values['attackerId'].toString(),
        values['sub1Id'].toString(),
        values['sub2Id'].toString()
      ];
    }

      return <String>[];
  }

  static Future<Squad> loadSquad({String? roundId}) async
  {
    print("Squad started loading");
    DatabaseEvent event = roundId == null 
      ? await FirebaseDatabase.instance.ref("users/${FirebaseAuth.instance.currentUser?.uid}").once()
      : await FirebaseDatabase.instance.ref("users/${FirebaseAuth.instance.currentUser?.uid}/$roundId").once();
    dynamic values = event.snapshot.value as dynamic;

    if(await SquadDbServices.squadSelected())
    {
      Map<SquadRole, int> playerIds = {
        SquadRole.goalkeeper: values['goalkeeperId'],
        SquadRole.defender: values['defenderId'],
        SquadRole.midfielder: values['midfielderId'],
        SquadRole.attacker: values['attackerId'],
        SquadRole.sub1: values['sub1Id'],
        SquadRole.sub2: values['sub2Id']
      };

      var players = await Future.wait(
        playerIds.values.map((playerId) => PlayersDbServices.getPlayer(playerId))
      );

      return Squad(
        goalkeeper: players.firstWhere((p) => p.playerID == playerIds[SquadRole.goalkeeper]),
        defender: players.firstWhere((p) => p.playerID == playerIds[SquadRole.defender]),
        midfielder: players.firstWhere((p) => p.playerID == playerIds[SquadRole.midfielder]),
        attacker: players.firstWhere((p) => p.playerID == playerIds[SquadRole.attacker]),
        sub1: players.firstWhere((p) => p.playerID == playerIds[SquadRole.sub1]),
        sub2: players.firstWhere((p) => p.playerID == playerIds[SquadRole.sub2]),
        squadSelected: true
      );
    }
    
    return Squad(squadSelected: false);
  }
}