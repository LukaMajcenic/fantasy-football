import 'package:fantasy_football/blocs/admin_actions/admin_actions_cubit.dart';
import 'package:fantasy_football/blocs/rounds/rounds_cubit.dart';
import 'package:fantasy_football/const/colors.dart';
import 'package:fantasy_football/widgets/shared/admin_button.dart';
import 'package:fantasy_football/widgets/shared/icon_button_v2.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: C.dark_1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              AppBar(
                backgroundColor: C.dark_2,
                automaticallyImplyLeading: false,
                actions: [
                  IconButtonV2(
                    onPressed: () => Navigator.pop(context), 
                    icon: Icons.menu_open_sharp
                  )
                ],
              ),
            ],
          ),
          Column(
            children: [
              AdminButton(
                text: "Init/reset rounds", 
                onPressed: () async {
                  await context.read<AdminActionsCubit>().resetRounds();
                },
              ),
              AdminButton(
                onPressed: () async {
                  await context.read<AdminActionsCubit>().simulateNextRound();
                },
                text: "Simulate next round",
                icon: Icons.next_plan_outlined,
              ),
            ],
          )
        ],
      )
    );
  }
}