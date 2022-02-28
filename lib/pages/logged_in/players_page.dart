import 'package:fantasy_football/blocs/players/players_cubit.dart';
import 'package:fantasy_football/blocs/players/players_cubit_state.dart';
import 'package:fantasy_football/blocs/squad/squad_cubit.dart';
import 'package:fantasy_football/blocs/squad/squad_cubit_state.dart';
import 'package:fantasy_football/const/colors.dart';
import 'package:fantasy_football/models/position.dart';
import 'package:fantasy_football/models/squad.dart';
import 'package:fantasy_football/widgets/shared/icon_button_v2.dart';
import 'package:fantasy_football/widgets/shared/player_general_info_widget.dart';
import 'package:fantasy_football/widgets/shared/player_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayersPage extends StatelessWidget {
  const PlayersPage({this.position, required this.squadRole, Key? key }) : super(key: key);

  final Position? position;
  final SquadRole squadRole;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayersCubit, PlayersCubitState>(
      builder: (_, state) {
        if(state.runtimeType == PlayersLoading)
        {
          return Text("sss");
        }

        var availablePlayers = state.players.where((p) => !context.read<SquadCubit>().state.squad.firstTeamPlayersIds().contains(p.playerID.toString())).toList();
        if(position != null) {
          availablePlayers = availablePlayers.where((p) => p.position.positionId == position?.positionId).toList();
        }

        return ListView(
          children: availablePlayers
            .map((player) => 
              Container(
                height: 80,
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    PlayerImageWidget(player: player,),
                    Text(player.fullname()),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              context.read<SquadCubit>().addPlayer(
                                squadRole: squadRole, 
                                player: player
                              );
                            }, 
                            icon: const Icon(
                              Icons.check,
                              color: C.green,
                            )
                          ),
                        ],
                      )
                    )
                  ],
                ),
              )
            ).toList()
        );
      },
    );
  }
}