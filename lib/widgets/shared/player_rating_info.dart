import 'package:fantasy_football/const/colors.dart';
import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/models/round.dart';
import 'package:fantasy_football/widgets/shared/image_future_builder.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PlayerRatingInfo extends StatelessWidget {
  const PlayerRatingInfo({required this.player, required this.round, Key? key }) : super(key: key);

  final Player player;
  final Round round;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 80,
          width: 80,
          color: player.position.color.withOpacity(0.2),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              ImageFutureBuilder(
                future: Player.getUint8List(player.playerID.toString())
              ),
              Image.network(player.clubLogo, width: 25,)
            ],
          ),
        ),
        Container(
          height: 80,
          width: 80,
          color: C.dark_1,
          child: CircularPercentIndicator(
            radius: 60.0,
            percent: player.getRoundRating(round).rating/10,
            lineWidth: 3,
            animation: true,
            animationDuration: 2000,
            center: Text(player.getRoundRating(round).rating.toString()),
            progressColor: player.getRoundRating(round).color,
          ),
        )
      ],
    );
  }
}