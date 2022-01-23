import 'package:fantasy_football/blocs/pageview_cubit.dart';
import 'package:fantasy_football/blocs/players_cubit.dart';
import 'package:fantasy_football/blocs/round_cubit.dart';
import 'package:fantasy_football/blocs/round_timer_cubit.dart';
import 'package:fantasy_football/blocs/squad_cubit.dart';
import 'package:fantasy_football/blocs/states/squad_cubit_state.dart';
import 'package:fantasy_football/const/colors.dart';
import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/models/squad.dart';
import 'package:fantasy_football/pages/squad_page.dart';
import 'package:fantasy_football/pages/squad_selection.dart';
import 'package:fantasy_football/pages/standings_page.dart';
import 'package:fantasy_football/services/login_service.dart';
import 'package:fantasy_football/widgets/shared/appbar.dart';
import 'package:fantasy_football/widgets/shared/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Main extends StatelessWidget {
  Main({ Key? key }) : super(key: key);

  final PageController _controller =  PageController();
  void _animateToPage(int index) 
  { 
    _controller.animateToPage(index, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<SquadCubit>(
          create: (_) => SquadCubit()..loadSquad()
        )
      ],
      child: Scaffold(
        appBar: const SharedAppBar(
          text: "text",
        ),
        body: BlocBuilder<SquadCubit, SquadCubitState>(
          builder: (_, state) {
            if(state.runtimeType == SquadLoading)
            {
              return Text("Loadinsssg squad");
            }
            
            if(!state.squad.squadSelected)
            {
              return const SquadSelection();
            }
            else
            {
              return PageView(
                controller: _controller,
                onPageChanged: (newIndex) => context.read<PageViewCubit>().changeIndex(newIndex),
                children: [
                  Container(),
                  const SquadPage(),
                  Container(
                    color: Colors.grey[900],
                  ),
                  const StandingsPage(),
                ]
              );
            }
          },
        ),
        bottomNavigationBar: BlocBuilder<PageViewCubit, int>(
          builder: (context, index) {
            return BottomNavigationBar(
              onTap: (newIndex) {
                _animateToPage(newIndex);
                context.read<PageViewCubit>().changeIndex(newIndex);
              },
              currentIndex: index,
              unselectedItemColor:  Colors.blueAccent[100],
              selectedItemColor: C.green,
              backgroundColor: C.blue,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                  backgroundColor: C.blue,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people), 
                  label: "Squad",
                  backgroundColor: C.blue,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.sports_soccer), 
                  label: "Rounds",
                  backgroundColor: C.blue,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.table_chart_outlined), 
                  label: "Table",
                  backgroundColor: C.blue,
                )
              ],
            );
          }
        )
      )
    );

    /* return FutureBuilder<List<dynamic>>(
      future: Future.wait([
        context.read<SquadCubit>().loadSquad(),
        context.read<RoundsCubit>().loadRounds()
      ]), 
      builder: (_, snapshot) {
        if(snapshot.hasData)
        {
          return BlocBuilder<SquadCubit, SquadCubitState>(
            builder: (_, state) {
              if(state.squad.squadSelected)
              {
                return Scaffold(
                  appBar: SharedAppBar(
                    textWidget: BlocBuilder<RoundTimerCubit, Duration>(
                      builder: (_, timer) {
                        return Text(timer.toString().split('.').first.padLeft(8, "0"));
                      },
                    ),
                  ),
                  drawer: const SharedDrawer(),
                  body: PageView(
                    controller: _controller,
                    onPageChanged: (newIndex) => context.read<PageViewCubit>().changeIndex(newIndex),
                    children: [
                      Container(),
                      const SquadPage(),
                      Container(
                        color: Colors.grey[900],
                      ),
                      const StandingsPage(),
                    ]
                  ),
                  bottomNavigationBar: BlocBuilder<PageViewCubit, int>(
                    builder: (context, index) {
                      return BottomNavigationBar(
                        onTap: (newIndex) {
                          _animateToPage(newIndex);
                          context.read<PageViewCubit>().changeIndex(newIndex);
                        },
                        currentIndex: index,
                        unselectedItemColor:  Colors.blueAccent[100],
                        selectedItemColor: C.green,
                        backgroundColor: C.blue,
                        items: const [
                          BottomNavigationBarItem(
                            icon: Icon(Icons.home),
                            label: "Home",
                            backgroundColor: C.blue,
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.people), 
                            label: "Squad",
                            backgroundColor: C.blue,
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.sports_soccer), 
                            label: "Rounds",
                            backgroundColor: C.blue,
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.table_chart_outlined), 
                            label: "Table",
                            backgroundColor: C.blue,
                          )
                        ],
                      );
                    }
                  )
                );
              }
              else
              {
                return const SquadSelection();
              }
            }
          );
        }
        else
        {
          return const Text("Loadinsssg squad (and rounds)");
        }
      }
    ); */
  }
}