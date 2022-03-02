import 'package:flutter/material.dart';

class Rating
{
  double rating;
  String roundId;
  late Color color;

  Rating({required this.rating, required this.roundId})
  {
    if(rating <= 4) {color = const Color(0xffff0000);}
    else if(rating <= 8) {color = const Color(0xffffff00);}
    else {color = const Color(0xff00ff00);}
  }

  Map<String, Object> toJson()
  {
    return {
      "value": rating,
      "roundId": roundId
    };
  }
}