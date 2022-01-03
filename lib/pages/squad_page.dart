import 'package:fantasy_football/blocs/squad_cubit.dart';
import 'package:fantasy_football/models/squad.dart';
import 'package:fantasy_football/widgets/widget_generators.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class SquadPage extends StatefulWidget {
  final Squad currentSquad;

  const SquadPage({ Key? key, required this.currentSquad }) : super(key: key);

  @override
  _SquadPageState createState() => _SquadPageState();
}

class _SquadPageState extends State<SquadPage> {

  @override
  Widget build(BuildContext context) {

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
              children: WidgetGenerators.getFirstTeamPlayerWidgets(widget.currentSquad.firstTeamPlayers()),
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
              children: WidgetGenerators.getSubsPlayerWidgets(widget.currentSquad.reservePlayers()),
            ),
          )
        ),
        Center(
          child: ElevatedButton(
            onPressed: context.read<SquadCubit>().state.teamPicked() ? 
            (){}
            : null,
            child: const Text("CONFIRM TEAM"),
          )
        ),
      ],
    );
  }
}