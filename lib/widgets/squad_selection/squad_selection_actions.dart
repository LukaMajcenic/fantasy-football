import 'package:fantasy_football/blocs/squad_cubit.dart';
import 'package:fantasy_football/const/colors.dart';
import 'package:fantasy_football/models/squad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';

class SquadSelectionActions extends StatelessWidget {
  const SquadSelectionActions({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SquadCubit, Squad>(
      builder: (context, snapshot) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          color: C.dark_2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: ElevatedButton(
                  onPressed: () => context.read<SquadCubit>().saveSquad(),
                  child: const Icon(Icons.clear)
                ),
              ),
              ElevatedButton(
                onPressed: context.read<SquadCubit>().state.allPlayers().where((p) => p == null).isEmpty 
                ? () => context.read<SquadCubit>().saveSquad()
                : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text("Save squad"),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Icon(Icons.save_alt),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}