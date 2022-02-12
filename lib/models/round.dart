import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/models/squad.dart';

class Round
{
  String roundId;
  String shortName;
  String longName;
  bool played;
  Map<SquadRole, String>? squadThatRound;
  double? score;
  Squad? squadThatRoundDetails;

  Round({
    required this.roundId, 
    required this.shortName, 
    required this.longName,
    required this.played,
    this.squadThatRound,
    this.score,
    this.squadThatRoundDetails
  });

  Map<String, Object> toJson()
  {
    return {
      "shortName": shortName,
      "longName": longName,
      "played": played
    };
  }

  static Round fromJson(String roundId, dynamic json)
  {
    return Round(
      roundId: roundId, 
      shortName: json['shortName'], 
      longName: json['longName'], 
      played: json['played']
    );
  }
}