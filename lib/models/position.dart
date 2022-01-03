import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Position extends Equatable {
  late int positionId;
  late String shortName;
  late String fullName;
  late Color color;

  static List<Position> positions() => [
    Position.goalkeeper(), 
    Position.defender(),
    Position.midfielder(),
    Position.attacker()];

  Position.goalkeeper()
  {
    positionId = 1;
    shortName = "GK";
    fullName = "Goalkeeper";
    color = Colors.brown[400] as Color;
  }

  Position.defender()
  {
    positionId = 2;
    shortName = "DF";
    fullName = "Defender";
    color = Colors.red;
  }

  Position.midfielder()
  {
    positionId = 3;
    shortName = "MF";
    fullName = "Midfileder";
    color = Colors.green;
  }

  Position.attacker()
  {
    positionId = 4;
    shortName = "AT";
    fullName = "Attacker";
    color = Colors.blue;
  }

  Position.undefined()
  {
    positionId = -1;
    shortName = "XX";
    fullName = "Undefined";
    color = Colors.black;
  }

  static Position generatePostition(String strPosition)
  {
    switch(strPosition)
    {
      case 'Goalkeeper':
        return Position.goalkeeper();
      case 'Defender':
        return Position.defender();
      case 'Midfielder':
        return Position.midfielder();
      case 'Attacker':
        return Position.attacker();
      default:
        return Position.undefined();
    }
  }

  @override
  List<Object?> get props => [positionId];
}