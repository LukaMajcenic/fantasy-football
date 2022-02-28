import 'package:fantasy_football/blocs/players/players_cubit.dart';
import 'package:fantasy_football/blocs/rounds/rounds_cubit.dart';
import 'package:fantasy_football/blocs/squad/squad_cubit.dart';
import 'package:fantasy_football/blocs/squad/squad_cubit_state.dart';
import 'package:fantasy_football/const/colors.dart';
import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/models/position.dart';
import 'package:fantasy_football/models/squad.dart';
import 'package:fantasy_football/pages/logged_in/players_page.dart';
import 'package:fantasy_football/widgets/shared/icon_button_v2.dart';
import 'package:fantasy_football/widgets/shared/player_general_info_widget.dart';
import 'package:fantasy_football/widgets/squad_page/squad_text_container.dart';
import 'package:fantasy_football/widgets/squad_selection/empty_player_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SquadSelectionPage extends StatelessWidget {
  const SquadSelectionPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: C.dark_2,
      ),
      body: BlocProvider(
        create: (_) => PlayersCubit()..loadPlayers(),
        child: BlocBuilder<SquadCubit, SquadCubitState>(
          builder: (_, state) {

            if(state.runtimeType == SquadSaving)
            {
              return Text("wot");
            }

            return Column(
              children: [
                const SquadTextContainer("FIRST TEAM", C.dark_1),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      state.squad.goalkeeper == null
                      ? EmptyPlayerButton(
                          text: "Pick goalkeeper", 
                          position: Position.goalkeeper(),
                          squadRole: SquadRole.goalkeeper,
                        )
                      : PlayerGeneralInfoWidget(
                          player: state.squad.goalkeeper as Player,
                          iconButtons: [
                            IconButtonV2(
                              onPressed: () => context.read<SquadCubit>().removePlayer(
                                squadRole: SquadRole.goalkeeper
                              ),
                              icon: Icons.clear,
                              colors: const [Colors.red, Colors.red],
                            )
                          ],
                      ),
                      state.squad.defender == null
                      ? EmptyPlayerButton(
                          text: "Pick defender", 
                          position: Position.defender(),
                          squadRole: SquadRole.defender,
                        )
                      : PlayerGeneralInfoWidget(
                          player: state.squad.defender as Player,
                          iconButtons: [
                            IconButtonV2(
                              onPressed: () => context.read<SquadCubit>().removePlayer(
                                squadRole: SquadRole.defender
                              ), 
                              icon: Icons.clear,
                              colors: const [Colors.red, Colors.red],
                            )
                          ],
                      ),
                      state.squad.midfielder == null
                      ? EmptyPlayerButton(
                          text: "Pick midfielder", 
                          position: Position.midfielder(),
                          squadRole: SquadRole.midfielder,
                        )
                      : PlayerGeneralInfoWidget(
                          player: state.squad.midfielder as Player,
                          iconButtons: [
                            IconButtonV2(
                              onPressed: () => context.read<SquadCubit>().removePlayer(
                                squadRole: SquadRole.midfielder
                              ), 
                              icon: Icons.clear,
                              colors: const [Colors.red, Colors.red],
                            )
                          ],
                      ),
                      state.squad.attacker == null
                      ? EmptyPlayerButton(
                          text: "Pick attacker", 
                          position: Position.attacker(),
                          squadRole: SquadRole.attacker,
                        )
                      : PlayerGeneralInfoWidget(
                          player: state.squad.attacker as Player,
                          iconButtons: [
                            IconButtonV2(
                              onPressed: () => context.read<SquadCubit>().removePlayer(
                                squadRole: SquadRole.attacker
                              ), 
                              icon: Icons.clear,
                              colors: const [Colors.red, Colors.red],
                            )
                          ],
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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        state.squad.sub1 == null
                        ? const EmptyPlayerButton(
                            text: "Pick sub 1", 
                            color: C.dark_2,
                            squadRole: SquadRole.sub1,
                          )
                        : PlayerGeneralInfoWidget(
                          player: state.squad.sub1 as Player,
                          iconButtons: [
                            IconButtonV2(
                              onPressed: () => context.read<SquadCubit>().removePlayer(
                                squadRole: SquadRole.sub1
                              ), 
                              icon: Icons.clear,
                              colors: const [Colors.red, Colors.red],
                            )
                          ],
                        ),
                        state.squad.sub2 == null
                        ? const EmptyPlayerButton(
                            text: "Pick sub 2", 
                            color: C.dark_2,
                            squadRole: SquadRole.sub2,
                          )
                        : PlayerGeneralInfoWidget(
                          player: state.squad.sub2 as Player,
                          iconButtons: [
                            IconButtonV2(
                              onPressed: () => context.read<SquadCubit>().removePlayer(
                                squadRole: SquadRole.sub2
                              ), 
                              icon: Icons.clear,
                              colors: const [Colors.red, Colors.red],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: state.squad.allPlayers().where((p) => p == null).isEmpty
                      ? () async {
                        await context.read<SquadCubit>().saveSquad();
                        await context.read<RoundsCubit>().loadRounds();
                        Navigator.pop(context);
                      }
                      : null,
                    child: const Text("Save squad")
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}