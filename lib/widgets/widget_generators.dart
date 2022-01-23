import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/models/position.dart';
import 'package:fantasy_football/models/rating.dart';
import 'package:fantasy_football/models/squad.dart';
import 'package:fantasy_football/widgets/player_in_list.dart';
import 'package:fantasy_football/widgets/rating_container.dart';
import 'package:flutter/material.dart';

class WidgetGenerators
{
  static List<Widget> getRatingWidgets(List<Rating> ratings)
  {
    List<Widget> widgets = [];

    for(var rating in ratings.reversed.take(5).toList().reversed)
    {
      widgets.add(RatingContainer(rating, rating.color));
    }

    return widgets;
  }

  static List<Widget> getFirstTeamPlayerWidgets(List<Player?> players)
  {
    List<Widget> widgets = [];

    players.asMap().forEach((index, player)
    {
      widgets.add(PlayerInList(
        player: player,
        squadRole: Squad.firstTeamRoles()[index],
        position: Position.positions()[index]
      ));
    });

    return widgets;
  }

  static List<Widget> getSubsPlayerWidgets(List<Player?> players)
  {
    List<Widget> widgets = [];

    players.asMap().forEach((index, player)
    {
      widgets.add(PlayerInList(
        player: player,
        squadRole: Squad.reserveRoles()[index]
      ));
    });

    return widgets;
  }
}