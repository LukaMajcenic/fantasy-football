import 'package:fantasy_football/blocs/players/players_cubit.dart';
import 'package:fantasy_football/blocs/squad/squad_cubit.dart';
import 'package:fantasy_football/const/colors.dart';
import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/models/position.dart';
import 'package:fantasy_football/models/squad.dart';
import 'package:fantasy_football/models/squad.dart';
import 'package:fantasy_football/models/squad.dart';
import 'package:fantasy_football/pages/logged_in/players_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmptyPlayerButton extends StatelessWidget {
  const EmptyPlayerButton({required this.text, required this.squadRole, this.position, this.color, Key? key }) : super(key: key);

  final String text;
  final Color? color;
  final Position? position;
  final SquadRole squadRole;

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color ?? C.dark_1,
          onPrimary: Colors.grey[200],
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        onPressed: () async {          
          showModalBottomSheet(
            backgroundColor: C.dark_1,
            context: context,
            builder: (_) {

              return MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: context.read<SquadCubit>()
                  ),
                  BlocProvider.value(
                    value: context.read<PlayersCubit>()
                  )
                ], 
                child: PlayersPage(position: position, squadRole: squadRole)
              );
              
            }
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text),
          ],
        )
      ),
    );
  }
}