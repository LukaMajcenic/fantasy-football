import 'package:fantasy_football/models/user.dart';
import 'package:fantasy_football/services/DbServices/shared_db_services.dart';
import 'package:firebase_database/firebase_database.dart';

class UserDbServices
{
  static Future<DatabaseEvent> getUser(String userId) async
  {
    return FirebaseDatabase.instance.ref("users/$userId").once(); 
  }

  static Future<List<User>> getUsers() async
  {
    List<User> users = [];
    List<Future<DatabaseEvent>> futures = [];

    for(var userId in await SharedDbServices.getNodeKeys("users"))
    {
      futures.add(getUser(userId));
    }

    for(var snapshot in (await Future.wait(futures)).map((e) => e.snapshot))
    {
      if((snapshot.value as dynamic)["squadSelected"])
      {
        users.add(User.fromJson(snapshot.key as String, snapshot.value));
        users.last.firebaseUser = users.last.userId == SharedDbServices.getUserId();
      }
    }

    return users;
  }
}