import 'package:fantasy_football/blocs/players_cubit.dart';
import 'package:fantasy_football/blocs/squad_cubit.dart';
import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/models/position.dart';
import 'package:fantasy_football/models/squad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickPlayer extends StatelessWidget {
  const PickPlayer({this.position, required this.squadRole, Key? key }) : super(key: key);

  final Position? position;
  final SquadRole squadRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PlayersCubit, List<Player>>(
        builder: (context, allPlayers) {
          var players = allPlayers;
          if(position != null) {
            players = allPlayers.where((p) => p.position == position).toList();
          }
          return ListView.builder(
            itemCount: players.length,
            padding: const EdgeInsets.all(8),
            itemBuilder: (BuildContext context, int index) {
              return ElevatedButton(
                onPressed: () {
                  context.read<SquadCubit>().changePlayer(squadRole, players[index]);
                },
                child: Row(
                  children: [
                    Image.memory(players[index].photo),
                    Text(players[index].fullname())
                  ],
                ),
              );
            }
          );
        }
      )
    );
  }
}