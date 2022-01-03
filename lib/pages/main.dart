import 'package:fantasy_football/blocs/players_cubit.dart';
import 'package:fantasy_football/blocs/squad_cubit.dart';
import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/models/squad.dart';
import 'package:fantasy_football/pages/squad_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Main extends StatefulWidget {
  const Main({ Key? key }) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {

  List<Player> players = [];

  final PageController _controller =  PageController();
  int _selectedIndex = 0;
  void _onItemTapped(int index) 
  { 
    setState(() {
      _selectedIndex = index;
    });

    _controller.animateToPage(index, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {

    context.read<PlayersCubit>().setList();

    return BlocBuilder<SquadCubit, Squad>(
      builder: (context, squad) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[900],
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'Show Snackbar',
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
              ),
            ],
          ),
          body: PageView(
            controller: _controller,
            children: [
              Container(

              ),
              SquadPage(currentSquad: squad),
              Container(
                color: Colors.grey[900],
              )
            ],
            onPageChanged: (page) {
              setState(() {
                _selectedIndex = page;
              });
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: _onItemTapped,
            currentIndex: _selectedIndex,
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
          ),
        );
      }
    );
  }
}