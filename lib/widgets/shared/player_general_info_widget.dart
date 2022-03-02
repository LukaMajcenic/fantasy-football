import 'package:fantasy_football/dialogs/player_info_dialog/player_info_dialog.dart';
import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/widgets/shared/player_image.dart';
import 'package:fantasy_football/widgets/shared/player_ratings_widget.dart';
import 'package:flutter/material.dart';

class PlayerGeneralInfoWidget extends StatelessWidget {
  const PlayerGeneralInfoWidget({required this.player, this.iconButtons, Key? key }) : super(key: key);

  final Player player;
  final List<Widget>? iconButtons;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          onPrimary: Colors.grey[200],
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            context: context, 
            builder: (_) => PlayerInfoDialog(player: player)
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: PlayerImageWidget(player: player),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(player.countryFlag,  height: 10,),
                    Text(player.fullname),
                  ],
                ),
                PlayerRatingsWidget(
                  player.ratings.reversed.take(5).toList().reversed
                )
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: iconButtons ?? [],
              )
            )
          ]
        )
      ),
    );
  }
}