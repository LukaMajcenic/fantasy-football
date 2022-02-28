import 'package:fantasy_football/blocs/admin_actions/admin_actions_cubit.dart';
import 'package:fantasy_football/blocs/all_users/all_users_cubit.dart';
import 'package:fantasy_football/blocs/page/page_cubit.dart';
import 'package:fantasy_football/blocs/rounds/rounds_cubit.dart';
import 'package:fantasy_football/blocs/squad/squad_cubit.dart';
import 'package:fantasy_football/blocs/squad/squad_cubit_state.dart';
import 'package:fantasy_football/models/squad.dart';
import 'package:fantasy_football/pages/logged_in/home_page.dart';
import 'package:fantasy_football/pages/logged_in/main_app_bar.dart';
import 'package:fantasy_football/pages/logged_in/main_bottom_navigation_bar.dart';
import 'package:fantasy_football/pages/logged_in/main_drawer.dart';
import 'package:fantasy_football/pages/logged_in/rounds_page.dart';
import 'package:fantasy_football/pages/logged_in/squad_page.dart';
import 'package:fantasy_football/pages/logged_in/standings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoggedInPage extends StatelessWidget {
  const LoggedInPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SquadCubit>(
          create: (_) => SquadCubit()..loadSquad()
        ),
        BlocProvider<AllUsersCubit>(
          create: (_) => AllUsersCubit()..loadUsers()
        ),
        BlocProvider<RoundsCubit>(
          create: (_) => RoundsCubit()..loadRounds()
        )
      ],
      child: Scaffold(
        appBar: const MainAppBar(),
        drawer: const MainDrawer(),
        body: PageView(
          controller: context.read<PageCubit>().controller,
          onPageChanged: (newIndex) => context.read<PageCubit>().changeIndexPageView(newIndex),
          children: const [
            HomePage(),
            SquadPage(),
            RoundsPage(),
            StandingsPage(),
          ]
        ),
        bottomNavigationBar: const MainBottomNavigationBar(),
      ),
    );
  }
}