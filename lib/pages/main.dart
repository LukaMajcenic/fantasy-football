import 'package:fantasy_football/blocs/pageview_cubit.dart';
import 'package:fantasy_football/blocs/players_cubit.dart';
import 'package:fantasy_football/blocs/squad_cubit.dart';
import 'package:fantasy_football/const/colors.dart';
import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/models/squad.dart';
import 'package:fantasy_football/pages/squad_page.dart';
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

    context.read<SquadCubit>().loadSquad();
    if(!context.read<SquadCubit>().state.teamPicked)
    {
      context.read<PlayersCubit>().setList();
    }
    
    print("built");

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: BlocBuilder<PageViewCubit, int>(
          builder: (context, index) {
            return AppBar(
              backgroundColor: C.dark_2,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'Show Snackbar',
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
              ),
              actions: [
                if(index == 1) ...[
                  BlocBuilder<SquadCubit, Squad>(
                    builder: (_, squad) {
                      return Padding(
                        padding: EdgeInsets.all(8),
                        child: ElevatedButton(
                          child: const Text("CONFIRM TEAM"),
                          onPressed: squad.allPlayers().where((p) => p == null).isEmpty 
                          ? () => context.read<SquadCubit>().saveSquad(squad)
                          : null,
                        )
                      );
                    }
                  )
                ],
              ]
            );
          }
        ),
      ),
      body: PageView(
        controller: _controller,
        onPageChanged: (newIndex) => context.read<PageViewCubit>().changeIndex(newIndex),
        children: context.read<SquadCubit>().state.teamPicked ? [
          Container(),
          const SquadPage(),
          Container(
            color: Colors.grey[900],
          )
        ] : [
          Container(),
          Container(color: Colors.red,),
          Container()
        ],
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
            selectedItemColor: Colors.lightGreenAccent[400],
            backgroundColor: Colors.blueAccent[700],
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
}