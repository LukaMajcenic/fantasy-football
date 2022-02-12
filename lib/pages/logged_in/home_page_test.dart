import 'package:fantasy_football/blocs/squad/squad_cubit.dart';
import 'package:fantasy_football/blocs/squad/squad_cubit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageTest extends StatelessWidget {
  const HomePageTest({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<SquadCubit, SquadCubitState>(
        builder: (_, state) {
          return Text(state.runtimeType.toString());
        },
      ),
    );
  }
}