import 'package:fantasy_football/blocs/states/users_cubit_states.dart';
import 'package:fantasy_football/blocs/users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StandingsPage extends StatelessWidget {
  const StandingsPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersCubit, UsersCubitState>(
      builder: (_, state) {
        if(state.runtimeType == UsersLoading)
        {
          return Text("Loading...xxx");
        }
       
        return DataTable(
          columns: const [
            DataColumn(
              label: Text("Username")
            ),
            DataColumn(
              label: Text("Points")
            )
          ], 
          rows: [
            for(var user in state.users)
              DataRow(
                cells: [
                  DataCell(Text(user.userId)),
                  DataCell(Text(user.points.toStringAsFixed(2)))
                ]
              )
          ]
        );
      }
    );
  }
}