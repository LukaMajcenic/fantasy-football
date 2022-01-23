import 'package:firebase_database/firebase_database.dart';

class SharedDbServices
{
  static Future<List<String>> getNodeKeys(String node) async
  {
    DatabaseEvent event = await FirebaseDatabase.instance.ref(node).once();
    return event.snapshot.children.map((snapshot) => snapshot.key as String).toList();
  }

  static Future<bool> nodeExists(String node) async
  {
    DatabaseEvent event = await FirebaseDatabase.instance.ref(node).once();
    return event.snapshot.exists;
  }
}