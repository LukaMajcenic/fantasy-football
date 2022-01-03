import 'dart:typed_data';

import 'package:fantasy_football/blocs/players_cubit.dart';
import 'package:fantasy_football/blocs/squad_cubit.dart';
import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/models/position.dart';
import 'package:fantasy_football/models/rating.dart';
import 'package:fantasy_football/models/squad.dart';
import 'package:fantasy_football/pages/pick_player.dart';
import 'package:fantasy_football/widgets/position_container.dart';
import 'package:fantasy_football/widgets/widget_generators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerInList extends StatelessWidget {
  const PlayerInList({required this.player,
   required this.squadRole,
   this.position, 
   Key? key }) : super(key: key);

  final Player? player;
  final SquadRole squadRole;
  final Position? position;

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: player != null ? ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          onPrimary: Colors.grey[200],
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        onPressed: () {
  /*         Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => PlayerDetails())
          ); */
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Container(
                    color: player?.position.color,
                    padding: const EdgeInsets.all(2),
                    child: Text(
                      player?.position.shortName as String,
                      style: TextStyle(color: Colors.grey[900]),
                    ),
                  ),
                  Image.memory(player?.photo as Uint8List)
                ]
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(player?.fullname() as String),
                    ),
                    Row(children: WidgetGenerators.getRatingWidgets(player?.ratings as List<Rating>))
                  ],
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    color: Colors.red,
                    onPressed: () 
                    {
                      context.read<SquadCubit>().changePlayer(squadRole);
                    }, 
                    icon: const Icon(Icons.clear)
                  ),
                )
              )
            ],
          ),
        )
      ) : 
      SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          child: ElevatedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: position == null ? [
                const Text("Pick reserve",
                textScaleFactor: 1.3)
              ] : [
                const Text("Pick ",
                textScaleFactor: 1.3),
                PositionContainer(
                  position?.fullName as String, 
                  position?.color as Color,
                  textScaleFactor: 1.15)
              ]
            ),
            onPressed: () { 
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => PickPlayer(position: position, squadRole: squadRole))
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              onPrimary: Colors.grey[200],
            ),
          )
        )
      )
    );
  }
}