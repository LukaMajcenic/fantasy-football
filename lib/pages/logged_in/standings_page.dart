import 'package:fantasy_football/blocs/all_users/all_users_cubit.dart';
import 'package:fantasy_football/blocs/all_users/all_users_cubit_state.dart';
import 'package:fantasy_football/models/user.dart';
import 'package:fantasy_football/widgets/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StandingsPage extends StatelessWidget {
  const StandingsPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllUsersCubit, AllUsersCubitState>(
      builder: (_, state) {
        if(state.runtimeType == AllUsersLoading)
        {
          return const Loading(text: "Loading standings");
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
            for(var user in User.sortUsers(state.users))
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