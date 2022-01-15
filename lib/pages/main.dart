import 'package:fantasy_football/blocs/pageview_cubit.dart';
import 'package:fantasy_football/blocs/players_cubit.dart';
import 'package:fantasy_football/blocs/squad_cubit.dart';
import 'package:fantasy_football/const/colors.dart';
import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/models/squad.dart';
import 'package:fantasy_football/pages/squad_page.dart';
import 'package:fantasy_football/pages/squad_selection.dart';
import 'package:fantasy_football/services/login_service.dart';
import 'package:fantasy_football/widgets/shared/appbar.dart';
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

    return FutureBuilder<Squad>(
      future: context.read<SquadCubit>().loadSquad(),
      builder: (_, snapshot) {
        if(snapshot.hasData)
        {
          return BlocBuilder<SquadCubit, Squad>(
            builder: (_, squad) {
              if(squad.squadSelected)
              {
                return Scaffold(
                  appBar: const SharedAppBar("Squad"),
                  body: PageView(
                    controller: _controller,
                    onPageChanged: (newIndex) => context.read<PageViewCubit>().changeIndex(newIndex),
                    children: [
                      Container(),
                      const SquadPage(),
                      Container(
                        color: Colors.grey[900],
                      )
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
                            label: "Home"
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.people), 
                            label: "Squad"
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.sports_soccer), 
                            label: "Fixtures"
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
          return const Text("Loading squad");
        }
      }
    );
  }
}