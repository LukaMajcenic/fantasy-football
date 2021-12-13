import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/widgets/player_in_list.dart';
import 'package:flutter/material.dart';

class Squad {
  Player goalkeeper;
  Player defender;
  Player midfielder;
  Player attacker;
  Player sub1;
  Player sub2;

  Squad(this.goalkeeper, this.defender, this.midfielder, this.attacker, this.sub1, this.sub2);

  List<Player> players() => [goalkeeper, defender, midfielder, attacker, sub1, sub2];
  List<Widget> playerWidgets()
  {
    List<Widget> widgets = [];

    players().asMap().forEach((index, player) 
    { 
      widgets.add(PlayerInList(player, index == 4 || index == 5));
    });

    return widgets;
  }
}