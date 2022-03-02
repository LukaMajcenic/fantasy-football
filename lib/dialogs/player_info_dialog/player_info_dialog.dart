import 'package:fantasy_football/const/colors.dart';
import 'package:fantasy_football/dialogs/player_info_dialog/player_info_dialog_table_cell.dart';
import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/widgets/shared/image_future_builder.dart';
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
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          RotatedBox(
            quarterTurns: 1,
            child: Text(
              player.position.fullName.toUpperCase(),
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 1.5
                  ..color = player.position.color.withOpacity(0.3)
              ),
            )
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ImageFutureBuilder(
                      future: Player.getUint8List(player.playerID.toString()),
                      width: 150,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.network(player.countryFlag, width: 30,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.network(player.clubLogo, width: 30,),
                        ),
                      ],
                    )
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
                  TableRow(
                    children: [
                      const PlayerInfoDialogTableCell(text: "AGE:"),
                      PlayerInfoDialogTableCell(text: player.age)
                    ]
                  ),
                  TableRow(
                    children: [
                      const PlayerInfoDialogTableCell(text: "DATE OF BIRTH:"),
                      PlayerInfoDialogTableCell(text: player.dateOfBirthText)
                    ]
                  ),
                  TableRow(
                    children: [
                      const PlayerInfoDialogTableCell(text: "NATIONAILTY:"),
                      PlayerInfoDialogTableCell(text: player.nationality)
                    ]
                  ),
                  TableRow(
                    children: [
                      const PlayerInfoDialogTableCell(text: "HEIGHT:"),
                      PlayerInfoDialogTableCell(text: player.heightText)
                    ]
                  ),
                  TableRow(
                    children: [
                      const PlayerInfoDialogTableCell(text: "WEIGHT:"),
                      PlayerInfoDialogTableCell(text: player.weightText)
                    ]
                  )
                ],
              ),
              Expanded(
                child: PlayerRatingsWidget(player.ratings)
              )
            ],
          ),
        ],
      ),
    );
  }
}