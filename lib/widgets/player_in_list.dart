import 'dart:typed_data';

import 'package:fantasy_football/blocs/players_cubit.dart';
import 'package:fantasy_football/blocs/round_timer_cubit.dart';
import 'package:fantasy_football/blocs/squad_cubit.dart';
import 'package:fantasy_football/const/colors.dart';
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

    var child2 = player != null ? ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          onPrimary: Colors.grey[200],
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.topStart,
              children: [            
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.centerRight,
                      colors: [
                        player?.position.color.withOpacity(0.7) as Color,
                        Colors.transparent
                      ]
                    )
                  ),
                  child: Image.memory(player?.image.uint8list as Uint8List),
                ),
                Text(
                  player?.position.shortName as String,
                  style: TextStyle(
                    color: player?.position.color as Color
                  )
                )   
              ]
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(player?.fullname() as String),
                Row(children: WidgetGenerators.getRatingWidgets(player?.ratings as List<Rating>))
              ],
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: Builder(
                  builder: (context) {
                    if(!context.read<SquadCubit>().state.squad.squadSelected)
                    {
                      return IconButton(
                        color: Colors.red,
                        onPressed: () {
                          context.read<SquadCubit>().changePlayer(squadRole);
                        }, 
                        icon: const Icon(Icons.clear)
                      );
                    }
                    else if(position == null)
                    {
                      return BlocBuilder<RoundTimerCubit, Duration>
                      (
                        builder: (_, timer) {
                          if(timer > const Duration())
                          {
                            return IconButton(
                              onPressed: (){
                                context.read<SquadCubit>().changePlayer(squadRole, player);
                              }, 
                              icon: const Icon(Icons.change_circle)
                            );
                          }
                          return Container();
                        }
                      );
                    }
                    else
                    {
                      return Container(width: 0.0, height: 0.0);
                    }
                  }
                )
              )
            )
          ],
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
      );
    return Expanded(
      child: child2
    );
  }
}