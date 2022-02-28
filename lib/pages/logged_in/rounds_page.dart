import 'package:fantasy_football/blocs/rounds/rounds_cubit.dart';
import 'package:fantasy_football/blocs/rounds/rounds_cubit_state.dart';
import 'package:fantasy_football/blocs/squad/squad_cubit.dart';
import 'package:fantasy_football/const/colors.dart';
import 'package:fantasy_football/dialogs/round_info_dialog/round_info_dialog.dart';
import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/models/position.dart';
import 'package:fantasy_football/models/squad.dart';
import 'package:fantasy_football/widgets/shared/icon_button_v2.dart';
import 'package:fantasy_football/widgets/shared/loading.dart';
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
          return const Loading(text: "Loading rounds");
        }
        else if(state.runtimeType == SquadNotSelected)
        {
          return const Text("Squad not selected");
        }

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            showCheckboxColumn: false,
            columnSpacing: 10,
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
                  onSelectChanged: round.squadThatRound != null ? (_) {
                    showDialog(
                      context: context, 
                      builder: (_) => RoundInfoDialog(round: round)
                    );
                  } : null,
                  cells: [
                    DataCell(
                      Text(round.shortName)
                    ),
                    DataCell(
                      Text(
                        round.squadThatRound != null ? round.score?.toStringAsFixed(2) as String : "TBD",
                        style: TextStyle(
                          color: round.getColor()
                        ),
                      )
                    ),
                    DataCell(
                      round.squadThatRound != null ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          PlayerImageWidget(
                            playerId: round.squadThatRound?[SquadRole.goalkeeper].toString(),
                            position: Position.goalkeeper(),
                            margin: const [0, 2],
                          ),
                          PlayerImageWidget(
                            playerId: round.squadThatRound?[SquadRole.defender].toString(),
                            position: Position.defender(),
                            margin: const [0, 2],
                          ),
                          PlayerImageWidget(
                            playerId: round.squadThatRound?[SquadRole.midfielder].toString(),
                            position: Position.midfielder(),
                            margin: const [0, 2],
                          ),
                          PlayerImageWidget(
                            playerId: round.squadThatRound?[SquadRole.attacker].toString(),
                            position: Position.attacker(),
                            margin: const [0, 2],
                          )
                        ],
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