import 'package:fantasy_football/blocs/admin_actions/admin_actions_cubit.dart';
import 'package:fantasy_football/widgets/shared/admin_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class AdminActionsDialog extends StatelessWidget {
  const AdminActionsDialog({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AdminButton(
          text: "Import players from api", 
          onPressed: () async => await context.read<AdminActionsCubit>().importPlayersFromAPI()
        ),
      ],
    );
  }
}