import 'package:fantasy_football/blocs/squad/squad_cubit.dart';
import 'package:fantasy_football/blocs/squad/squad_cubit_state.dart';
import 'package:fantasy_football/const/colors.dart';
import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/widgets/shared/icon_button_v2.dart';
import 'package:fantasy_football/widgets/shared/player_general_info_widget.dart';
import 'package:fantasy_football/widgets/squad_page/squad_text_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SquadPage extends StatelessWidget {
  const SquadPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SquadCubit, SquadCubitState>(
      builder: (_, state) {
        if(state.runtimeType == SquadLoading)
        {
          return const Text("squad loading");
        }
        else if(!state.squad.squadSelected)
        {
          return const Text("squad selection button");
        }
        else if(state.runtimeType == SquadSavingSwapPlayers)
        {
          return const Text("saving changes");
        }

        return Column(
          children: [
            const SquadTextContainer("FIRST TEAM", C.dark_1),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for(var player in state.squad.firstTeamPlayers())
                    PlayerGeneralInfoWidget(
                      player: player as Player,
                    )
                ],
              ),
            ),
            const SquadTextContainer("RESERVES", C.dark_2),
            Expanded(
              flex: 2,
              child: Container(
                color: C.dark_2,
                child: Column(
                  children: [
                    for(var player in state.squad.reservePlayers())
                      PlayerGeneralInfoWidget(
                        player: player as Player,
                        iconButtons: [
                          IconButtonV2(
                            onPressed: () => context.read<SquadCubit>().swapPlayers(player),
                            icon: Icons.swap_vert
                          ),
                        ],
                      )
                  ],
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}