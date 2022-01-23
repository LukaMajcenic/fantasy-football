import 'package:fantasy_football/blocs/round_cubit.dart';
import 'package:fantasy_football/blocs/round_timer_cubit.dart';
import 'package:fantasy_football/const/colors.dart';
import 'package:fantasy_football/widgets/shared/admin_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class SharedDrawer extends StatelessWidget {
  const SharedDrawer({ Key? key }) : super(key: key);

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
                  IconButton(
                    onPressed: () => Navigator.pop(context), 
                    icon: const Icon(Icons.menu)
                  )
                ],
              ),
            ],
          ),
          Column(
            children: [
              AdminButton(
                text: "Init/reset rounds", 
                onPressed: () => context.read<RoundsCubit>().initRounds()
              ),
              AdminButton(
                onPressed: () async {
                  await context.read<RoundsCubit>().simulateNextRound();
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