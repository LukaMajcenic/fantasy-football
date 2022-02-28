import 'package:fantasy_football/blocs/all_users/all_users_cubit.dart';
import 'package:fantasy_football/blocs/all_users/all_users_cubit_state.dart';
import 'package:fantasy_football/blocs/rounds/rounds_cubit.dart';
import 'package:fantasy_football/blocs/rounds/rounds_cubit_state.dart';
import 'package:fantasy_football/blocs/squad/squad_cubit.dart';
import 'package:fantasy_football/blocs/squad/squad_cubit_state.dart';
import 'package:fantasy_football/models/round.dart';
import 'package:fantasy_football/models/user.dart';
import 'package:fantasy_football/pages/logged_in/standings_page.dart';
import 'package:fantasy_football/widgets/home_page/home_page_button.dart';
import 'package:fantasy_football/widgets/shared/loading.dart';
import 'package:fantasy_football/widgets/shared/player_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("TODO");
  }
}