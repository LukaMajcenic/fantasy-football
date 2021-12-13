import 'package:fantasy_football/pages/squad_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FantasyFootball());
}

class FantasyFootball extends StatefulWidget {
  const FantasyFootball({ Key? key }) : super(key: key);

  @override
  State<FantasyFootball> createState() => FantasyFootballState();
}

class FantasyFootballState extends State<FantasyFootball> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) 
  {
    setState(() {
      _selectedIndex = index;
    });

    _controller.animateToPage(index, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
  }

  final PageController _controller =  PageController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
          displayColor: Colors.white,
          bodyColor: Colors.grey[50]
        )
      ),
      home: Scaffold(
        body: PageView(
          controller: _controller,
          children: [
            Container(
              color: Colors.grey[900],
            ),
            const SquadPage(),
            Container(
              color: Colors.grey[900],
            ),
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
      ),
    );
  }
}