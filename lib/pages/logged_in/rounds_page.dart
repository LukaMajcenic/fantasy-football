import 'package:fantasy_football/blocs/rounds/rounds_cubit.dart';
import 'package:fantasy_football/blocs/rounds/rounds_cubit_state.dart';
import 'package:fantasy_football/blocs/squad/squad_cubit.dart';
import 'package:fantasy_football/const/colors.dart';
import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/models/position.dart';
import 'package:fantasy_football/models/squad.dart';
import 'package:fantasy_football/widgets/shared/player_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoundsPage extends StatelessWidget {
  const RoundsPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoundsCubit, RoundsCubitState>(
      builder: (_, state)
      {
        if(state.runtimeType == RoundsLoading)
        {
          return const Text("Rounds loading");
        }

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            columnSpacing: 30,
            columns: const [
              DataColumn(
                label: Text("Round")
              ),
              DataColumn(
                numeric: true,
                label: Text("Score")
              ),
              DataColumn(
                label: Text("")
              )
            ], 
            rows: [
              for(var round in state.rounds)
                DataRow(
                  cells: [
                    DataCell(
                      Text(round.shortName)
                    ),
                    DataCell(
                      Text(
                        round.played ? round.score.toString() : "TBD",
                        style: TextStyle(
                          color: round.played ? Colors.red : C.dark_3
                        ),
                      )
                    ),
                    DataCell(
                      round.played ? Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            PlayerImageWidget(
                              playerId: round.squadThatRound?[SquadRole.goalkeeper],
                              position: Position.goalkeeper(),
                              margin: const [0, 2],
                            ),
                            PlayerImageWidget(
                              playerId: round.squadThatRound?[SquadRole.defender],
                              position: Position.defender(),
                              margin: const [0, 2],
                            ),
                            PlayerImageWidget(
                              playerId: round.squadThatRound?[SquadRole.midfielder],
                              position: Position.midfielder(),
                              margin: const [0, 2],
                            ),
                            PlayerImageWidget(
                              playerId: round.squadThatRound?[SquadRole.attacker],
                              position: Position.attacker(),
                              margin: const [0, 2],
                            )
                          ],
                        ),
                      )
                      : Container()
                    )
                  ]
                )
            ]
          ),
        ); 
      }
    );
  }
}