import 'package:flutter/material.dart';

class Position {
  late int positionId;
  late String shortName;
  late String fullName;
  late Color color;

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
}