import 'package:fantasy_football/blocs/rounds/rounds_cubit.dart';
import 'package:fantasy_football/blocs/rounds/rounds_cubit_state.dart';
import 'package:fantasy_football/const/colors.dart';
import 'package:fantasy_football/dialogs/dialog_base.dart';
import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/models/round.dart';
import 'package:fantasy_football/models/squad.dart';
import 'package:fantasy_football/services/DbServices/squad_db_services.dart';
import 'package:fantasy_football/widgets/shared/image_future_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoundInfoDialog extends StatelessWidget {
  const RoundInfoDialog({required this.round, Key? key }) : super(key: key);

  final Round round;

  @override
  Widget build(BuildContext context) {
    return DialogBase(
      widget: FutureBuilder<Squad>(
        future: SquadDbServices.loadSquadByRound(round.roundId),
        builder: (_, snapshot) {
          if(!snapshot.hasData)
          {
            return Text("loading..");
          }

          return Column(
            children: [
              for(var player in (snapshot.data as Squad).firstTeamPlayers())
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    LinearProgressIndicator(
                      minHeight: 10,
                      backgroundColor: (player as Player).getRoundRating(round).color.withOpacity(0.2),
                      color: player.getRoundRating(round).color,
                      value: player.getRoundRating(round).rating/10
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ImageFutureBuilder(
                              future: Player.getUint8List(player.playerID.toString()),
                              height: 100,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                player.fullname(),
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            player.getRoundRating(round).rating.toString(),
                            style: TextStyle(
                              fontSize: 30,
                              color: player.getRoundRating(round).color,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          );
        },
      )
    );
  }
}