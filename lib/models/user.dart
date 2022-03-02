import 'package:fantasy_football/services/DbServices/shared_db_services.dart';

import 'squad.dart';

class User
{
  String userId;
  double points;
  bool firebaseUser;
  Squad? squad;
  List<String> firstTeamPlayerIds;

  User({
    required this.userId, 
    required this.points, 
    required this.firebaseUser, 
    required this.firstTeamPlayerIds, 
    this.squad
  });

  static User fromJson(String userId, dynamic json)
  {
    return User(
      userId: userId, 
      points: (double.parse(json["points"].toString())),
      firebaseUser: false,
      firstTeamPlayerIds: [
        json["goalkeeperId"].toString(),
        json["defenderId"].toString(),
        json["midfielderId"].toString(),
        json["attackerId"].toString()
      ]
    );
  }

  static List<User> sortUsers(List<User> users)
  {
    users.sort((a, b) => a.points.compareTo(b.points));

    return users.reversed.toList();
  }

  static int getPosition(List<User> users)
  {
    users.sort((a, b) => a.points.compareTo(b.points));

    int i = 1;
    for(var user in users)
    {
      if(user.userId == SharedDbServices.getUserId())
      {
        return i;
      }
      i++;
    }

    return 0;
  }
}