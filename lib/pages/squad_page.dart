import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/models/position.dart';
import 'package:fantasy_football/models/squad.dart';
import 'package:flutter/material.dart';

class SquadPage extends StatefulWidget {
  const SquadPage({ Key? key }) : super(key: key);

  @override
  _SquadPageState createState() => _SquadPageState();
}

class _SquadPageState extends State<SquadPage> {

  Squad currentSquad = Squad(
    Player(Position.goalkeeper()),
    Player(Position.defender()),
    Player(Position.midfielder()),
    Player(Position.attacker()),
    Player(Position.attacker()),
    Player(Position.goalkeeper()));

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: currentSquad.playerWidgets()
      )
    );
  }
}