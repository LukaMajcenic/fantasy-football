import 'package:fantasy_football/models/rating.dart';
import 'package:flutter/material.dart';

class RatingContainer extends StatelessWidget {
  const RatingContainer(this.rating, this.color, { Key? key }) : super(key: key);

  final Rating rating;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 5),
          alignment: Alignment.center,
          child: Text(
            "R" + rating.roundId,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          width: 35,
        ),
        Container(
          width: 35,
          alignment: Alignment.center,
          color: color.withOpacity(0.1),
          margin: const EdgeInsets.only(right: 5),
          padding: const EdgeInsets.all(0),
          child: Text(
            rating.rating.toStringAsFixed(2),
            style: TextStyle(
              fontSize: 13,
              color: color.withOpacity(0.8)
            ),
          ),
        )
      ]
    );
  }
}