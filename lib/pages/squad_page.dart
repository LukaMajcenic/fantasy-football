import 'package:fantasy_football/blocs/squad_cubit.dart';
import 'package:fantasy_football/models/squad.dart';
import 'package:fantasy_football/widgets/widget_generators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SquadPage extends StatelessWidget {
  const SquadPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<SquadCubit, Squad>(
      builder: (context, squad) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                "FIRST TEAM",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800]
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                  children: WidgetGenerators.getFirstTeamPlayerWidgets(squad.firstTeamPlayers()),
                ),
            ),
            Container(
              color: Colors.grey[900],
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                "SUBSTITUTES",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800]
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.grey[900],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: WidgetGenerators.getSubsPlayerWidgets(squad.reservePlayers()),
                ),
              )
            )
          ],
        );
      }
    );
  }
}