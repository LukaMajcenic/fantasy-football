import 'package:fantasy_football/const/colors.dart';
import 'package:fantasy_football/models/rating.dart';
import 'package:flutter/material.dart';

class PlayerRatingsWidget extends StatelessWidget {
  const PlayerRatingsWidget(this.ratings, { Key? key }) : super(key: key);

  final Iterable<Rating> ratings;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for(var rating in ratings)
        Padding(
          padding: const EdgeInsets.only(right: 6, top: 2),
          child: Column(
            children: [
              Text(
                "R" + rating.roundId,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.2),
                  fontSize: 13
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                color: rating.color.withOpacity(0.1),
                child: Text(
                  rating.rating.toString(),
                  style: TextStyle(
                    color: rating.color,
                    fontSize: 13
                  ),
                ),
              )
            ],
          ),
        )
      ]
    );
  }
}