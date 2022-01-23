import 'squad.dart';

class User
{
  String userId;
  double points;
  Squad? squad;
  List<String> firstTeamPlayerIds;

  User({required this.userId, required this.points, required this.firstTeamPlayerIds, this.squad});

  static User fromJson(String userId, dynamic json)
  {
    return User(
      userId: userId, 
      points: (double.parse(json["points"].toString())),
      firstTeamPlayerIds: [
        json["goalkeeperId"].toString(),
        json["defenderId"].toString(),
        json["midfielderId"].toString(),
        json["attackerId"].toString()
      ]
    );
  }
}