import 'package:fantasy_football/blocs/squad_cubit.dart';
import 'package:fantasy_football/blocs/states/squad_cubit_state.dart';
import 'package:fantasy_football/const/colors.dart';
import 'package:fantasy_football/models/squad.dart';
import 'package:fantasy_football/widgets/squad_text_container.dart';
import 'package:fantasy_football/widgets/widget_generators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SquadPage extends StatelessWidget {
  const SquadPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<SquadCubit, SquadCubitState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            )
          ],
        );
      }
    );
  }
}