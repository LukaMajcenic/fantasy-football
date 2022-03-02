import 'package:fantasy_football/const/colors.dart';
import 'package:fantasy_football/models/squad.dart';
import 'package:flutter/material.dart';

class Round
{
  String roundId;
  String shortName;
  String longName;
  bool played;
  Map<SquadRole, int>? squadThatRound;
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

  Color getColor()
  {
    if(score == null)
    {
      return C.dark_1;
    }

    if(score as double <= 15)
    {
      return Colors.red;
    }
    else if(score as double <= 35)
    {
      return Colors.yellow;
    }
    else
    {
      return Colors.green;
    }
  }

  static Round getNextRound(List<Round> rounds)
  {
    return rounds.where((r) => r.played).last;
  }
}