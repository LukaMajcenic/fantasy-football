import 'dart:typed_data';

import 'package:fantasy_football/const/colors.dart';
import 'package:fantasy_football/dialogs/player_info_dialog/player_info_dialog_table_cell.dart';
import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/widgets/shared/icon_button_v2.dart';
import 'package:fantasy_football/widgets/shared/player_ratings_widget.dart';
import 'package:flutter/material.dart';

class PlayerInfoDialog extends StatelessWidget {
  const PlayerInfoDialog({ required this.player, Key? key }) : super(key: key);

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<Uint8List>(
                  future: Player.getUint8List(player.playerID.toString()),
                  builder: (_, snapshot) {

                    if(snapshot.hasData)
                    {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Image.memory(snapshot.data as Uint8List, ),
                      );
                    }

                    return Container(
                      height: 70,
                      width: 70,
                      child: Icon(Icons.access_alarm),
                    );
                  },
                ),
                Text(
                  player.position.fullName.toUpperCase(),
                  style: TextStyle(
                    fontSize: 30,
                    color: player.position.color.withOpacity(0.2),
                    fontWeight: FontWeight.bold
                  )
                ),
              ],
            ),
          ),
          Table(
            defaultColumnWidth: const IntrinsicColumnWidth(),
            children: [
              TableRow(
                children: [
                  const PlayerInfoDialogTableCell(text: "FIRST NAME:"),
                  PlayerInfoDialogTableCell(text: player.firstName)
                ]
              ),
              TableRow(
                children: [
                  const PlayerInfoDialogTableCell(text: "LAST NAME:"),
                  PlayerInfoDialogTableCell(text: player.lastName)
                ]
              ),
              const TableRow(
                children: [
                  PlayerInfoDialogTableCell(text: "CLUB:"),
                  PlayerInfoDialogTableCell(text: "Club name")
                ]
              )
            ],
          ),
          Expanded(
            child: PlayerRatingsWidget(player.ratings)
          ),
          Container(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Zatvori"),
            )
          )
        ],
      ),
    );
  }
}