import 'dart:typed_data';

import 'package:fantasy_football/const/colors.dart';
import 'package:fantasy_football/dialogs/player_info_dialog/player_info_dialog_table_cell.dart';
import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/widgets/shared/image_future_builder.dart';
import 'package:fantasy_football/widgets/shared/player_ratings_widget.dart';
import 'package:flutter/material.dart';

class PlayerInfoDialogV2 extends StatelessWidget {
  const PlayerInfoDialogV2({ required this.player, Key? key }) : super(key: key);

  final Player player;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.05, 0.20, 0.80],
          colors: [
            player.position.color,
            C.dark_1,
            C.dark_2,
          ]
        )
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          RotatedBox(
            quarterTurns: 1,
            child: Text(
              player.position.fullName.toUpperCase(),
              style: TextStyle(
                color: player.position.color.withOpacity(0.3),
                fontSize: 40,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ImageFutureBuilder(
                    future: Player.getUint8List(player.playerID.toString())
                  ),
                ],
              ),
              Expanded(child: Text("ss"))
            ],
          ),
        ],
      ),
    );
  }
}