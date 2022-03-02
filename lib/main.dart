import 'package:fantasy_football/blocs/admin_actions/admin_actions_cubit.dart';
import 'package:fantasy_football/blocs/current_user/firebase_user.dart';
import 'package:fantasy_football/blocs/current_user/firebase_user_state.dart';
import 'package:fantasy_football/blocs/page/page_cubit.dart';
import 'package:fantasy_football/const/colors.dart';
import 'package:fantasy_football/pages/logged_in/logged_in_page.dart';
import 'package:fantasy_football/pages/logged_out/logged_out_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAuth.instance.signOut();
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CurrentUserCubit>(
          create: (_) => CurrentUserCubit()
        ),
        BlocProvider<PageCubit>(
          create: (_) => PageCubit()
        ),
        BlocProvider<AdminActionsCubit>(
          create: (_) => AdminActionsCubit(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: C.dark_1,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: C.blue,
              onPrimary: C.green
            ),
          ),
          textTheme: Theme.of(context).textTheme.apply(
            displayColor: Colors.white,
            bodyColor: Colors.grey[50]
          ),
        ),
        home: BlocBuilder<CurrentUserCubit, CurrentUserState>(
          builder: (_, state) {
            if(state.runtimeType == CurrentUserLoggedOut)
            {
              return const LoggedOutPage();
            }
            else if(state.runtimeType == CurrentUserLoading)
            {
              return const Text("User laoding...");
            }

            return const LoggedInPage();
          },
        ),
      ),
    );
  }
}