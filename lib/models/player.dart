import 'dart:math';

import 'package:fantasy_football/models/position.dart';
import 'package:fantasy_football/models/rating.dart';
import 'package:fantasy_football/widgets/rating_container.dart';
import 'package:flutter/material.dart';

class Player {
  int playerID = 1;
  String firstName = "Firstname";
  String lastName = "Lastname";
  String photo = "https://cdn.sofifa.net/players/232/938/22_360.png";
  Position position;
  List<Rating> ratings = [];

  Player(this.position)
  {
    var rng = Random();
    for(int i = 0; i < 12; i++)
    {
      ratings.add(Rating(rng.nextDouble() * (10 - 1) + 1, "R" + (i+1).toString()));
    }
  }

  String fullname() => firstName + " " + lastName; 

  Color generateRatingColor(double rating)
  {
    if(rating <= 4) {return const Color(0xffff0000);}
    else if(rating <= 8) {return const Color(0xffffff00);}
    else {return const Color(0xff00ff00);}
  }

  List<Widget> ratingsWidget()
  {
    List<Widget> ratingWidgets = [];

    for(var rating in ratings.take(5))
    {
      ratingWidgets.add(RatingContainer(rating, generateRatingColor(rating.rating)));
    }

    return ratingWidgets;
  }
}