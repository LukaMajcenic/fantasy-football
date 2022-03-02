import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/models/position.dart';

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
  bool squadSelected;

  Squad({
    this.goalkeeper, 
    this.defender, 
    this.midfielder, 
    this.attacker, 
    this.sub1, 
    this.sub2,
    required this.squadSelected});

  List<Player?> allPlayers() => [goalkeeper, defender, midfielder, attacker, sub1, sub2];
  List<Player?> firstTeamPlayers() => [goalkeeper, defender, midfielder, attacker];
  List<Player?> reservePlayers() => [sub1, sub2];
  List<String> firstTeamPlayersIds() => allPlayers().where((p) => p != null).map((p) => (p as Player).playerID.toString()).toList();

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
    squadSelected: s.squadSelected
  );

  Map<String, Object> toJson([
    bool addFirstTeamPlayers = true, 
    bool addReservePlayers = true, 
    bool addSquadSelected = true])
  {
    Map<String, Object> json = {};

    if(addFirstTeamPlayers)
    {
      json["goalkeeperId"] = goalkeeper?.playerID as Object;
      json["defenderId"] = defender?.playerID as Object;
      json["midfielderId"] = midfielder?.playerID as Object;
      json["attackerId"] = attacker?.playerID as Object;
    }

    if(addReservePlayers)
    {
      json["sub1Id"] = sub1?.playerID as Object;
      json["sub2Id"] = sub2?.playerID as Object;
    }

    if(addSquadSelected)
    {
      json["squadSelected"] = squadSelected;
    }

    return json;
  }

  static SquadRole getSquadRole(Position position)
  {
    switch(position.positionId)
    {
      case 1:
        return SquadRole.goalkeeper;
      case 2:
        return SquadRole.defender;
      case 3:
        return SquadRole.midfielder;
      case 4:
        return SquadRole.attacker;
      default:
        return SquadRole.goalkeeper;
    }
  }
}