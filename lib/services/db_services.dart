import 'package:fantasy_football/models/squad.dart';
import 'package:fantasy_football/services/api_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class DbServices
{
  static DatabaseReference ref = FirebaseDatabase.instance.ref("users/${FirebaseAuth.instance.currentUser?.uid}");

  static Future initSquad() async
  {
    Map<String, Object> json = {};
    SquadRole.values.asMap().forEach((i, role) 
    { 
      json[role.toString().split(".")[1] + "Id"] = 0;
    });
    await ref.set(json);
  }

  static Future saveSquad(Squad squad) async
  {
    await ref.update(squad.toJson());
    print("Squad updated");
  }

  static Future<Squad> loadSquad() async
  {
    DatabaseEvent event = await ref.once();
    dynamic values = event.snapshot.value as dynamic;

    return Squad(
      goalkeeper: await ApiServices.getPlayer(values['goalkeeperId'].toString()),
      defender: await ApiServices.getPlayer(values['defenderId'].toString()),
      midfielder: await ApiServices.getPlayer(values['midfielderId'].toString()),
      attacker: await ApiServices.getPlayer(values['attackerId'].toString()),
      sub1: await ApiServices.getPlayer(values['sub1Id'].toString()),
      sub2: await ApiServices.getPlayer(values['sub2Id'].toString()),
      teamPicked: true
    );
  }

  static Future<bool> userNodeExists() async
  {
    DatabaseEvent event = await ref.once();
    return event.snapshot.exists;
  }
}