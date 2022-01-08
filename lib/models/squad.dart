import 'package:fantasy_football/models/player.dart';

enum SquadRole { 
  goalkeeper, 
  defender,
  midfielder,
  attacker,
  sub1,
  sub2 }

class Squad {
  Player? goalkeeper;
  Player? defender;
  Player? midfielder;
  Player? attacker;
  Player? sub1;
  Player? sub2;
  bool teamPicked;

  Squad({
    this.goalkeeper, 
    this.defender, 
    this.midfielder, 
    this.attacker, 
    this.sub1, 
    this.sub2, 
    required this.teamPicked});

  List<Player?> allPlayers() => [goalkeeper, defender, midfielder, attacker, sub1, sub2];
  List<Player?> firstTeamPlayers() => [goalkeeper, defender, midfielder, attacker];
  List<Player?> reservePlayers() => [sub1, sub2];

  static List<SquadRole> firstTeamRoles() => [
    SquadRole.goalkeeper, 
    SquadRole.defender, 
    SquadRole.midfielder,
    SquadRole.attacker
  ];
  static List<SquadRole> reserveRoles() => [SquadRole.sub1, SquadRole.sub2];

  static Squad from(Squad s) => Squad(
    goalkeeper: s.goalkeeper,
    defender: s.defender,
    midfielder: s.midfielder,
    attacker: s.attacker,
    sub1: s.sub1,
    sub2: s.sub2,
    teamPicked: s.teamPicked
  );

  Map<String, Object> toJson()
  {
    Map<String, Object> json = {};
    SquadRole.values.asMap().forEach((i, role) 
    { 
      json[role.toString().split(".")[1] + "Id"] = allPlayers()[i]?.playerID as Object;
    });

    return json;
  }
}