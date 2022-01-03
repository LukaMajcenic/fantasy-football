import 'package:flutter/material.dart';

class Rating
{
  double rating;
  String round;
  late Color color;

  Rating(this.rating, this.round)
  {
    if(rating <= 4) {color = const Color(0xffff0000);}
    else if(rating <= 8) {color = const Color(0xffffff00);}
    else {color = const Color(0xff00ff00);}
  }
}