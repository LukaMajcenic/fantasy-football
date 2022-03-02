import 'package:fantasy_football/blocs/admin_actions/admin_actions_cubit.dart';
import 'package:fantasy_football/blocs/page/page_cubit.dart';
import 'package:fantasy_football/const/colors.dart';
import 'package:fantasy_football/services/login_service.dart';
import 'package:fantasy_football/widgets/shared/admin_button.dart';
import 'package:fantasy_football/widgets/shared/drawer_button.dart';
import 'package:fantasy_football/widgets/shared/icon_button_v2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer({ Key? key }) : super(key: key);

  final usernameController = TextEditingController();

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
              DrawerButton(
                text: "Odjava",
                icon: Icons.logout, 
                onPressed: () async {
                  await context.read<PageCubit>().changeIndexBottomNavigation(0);
                  await LoginService.logout();
                }
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
                text: "Simulate next round"
              ),
            ],
          )
        ],
      )
    );
  }
}