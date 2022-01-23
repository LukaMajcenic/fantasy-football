import 'package:fantasy_football/blocs/players_cubit.dart';
import 'package:fantasy_football/blocs/squad_cubit.dart';
import 'package:fantasy_football/blocs/states/squad_cubit_state.dart';
import 'package:fantasy_football/const/colors.dart';
import 'package:fantasy_football/models/squad.dart';
import 'package:fantasy_football/services/login_service.dart';
import 'package:fantasy_football/widgets/shared/appbar.dart';
import 'package:fantasy_football/widgets/squad_selection/squad_selection_actions.dart';
import 'package:fantasy_football/widgets/squad_text_container.dart';
import 'package:fantasy_football/widgets/widget_generators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';

class SquadSelection extends StatelessWidget {
  const SquadSelection({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<PlayersCubit>().loadPlayers(),
      builder: (_, snapshot) {
        if(snapshot.hasData)
        {
          return Scaffold(
            appBar: const SharedAppBar(text: "Select squad"), 
            body: BlocBuilder<SquadCubit, SquadCubitState>(
              builder: (_, state) {
                return Column(
                  children: [
                    const SquadTextContainer("FIRST TEAM", C.dark_1),
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                          children: WidgetGenerators.getFirstTeamPlayerWidgets(state.squad.firstTeamPlayers()),
                        ),
                    ),
                    const SquadTextContainer("RESERVES", C.dark_2),
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: C.dark_2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: WidgetGenerators.getSubsPlayerWidgets(state.squad.reservePlayers()),
                        ),
                      )
                    ),
                    const SquadSelectionActions()
                  ]
                );
              },
            )
          );
        }
        else
        {
          return const Text("Loading players...");
        }
      },
    );
  }
}