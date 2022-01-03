import 'package:fantasy_football/blocs/squad_cubit.dart';
import 'package:fantasy_football/pages/login.dart';
import 'package:fantasy_football/pages/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/players_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const FantasyFootball());
}

class FantasyFootball extends StatefulWidget {
  const FantasyFootball({ Key? key }) : super(key: key);

  @override
  State<FantasyFootball> createState() => FantasyFootballState();
}

class FantasyFootballState extends State<FantasyFootball> {

  @override
  initState(){
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((User? user) 
    { 
      setState(() {
        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PlayersCubit>(
          create: (_) => PlayersCubit()
        ),
        BlocProvider<SquadCubit>(
          create: (_) => SquadCubit()
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xff191919),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: Colors.blueAccent[700],
              onPrimary: Colors.lightGreenAccent[400]
            ),
          ),
          textTheme: Theme.of(context).textTheme.apply(
            displayColor: Colors.white,
            bodyColor: Colors.grey[50]
          )
        ),
        home: FirebaseAuth.instance.currentUser == null ? const Login() : const Main()
      ),
    );
  }
}