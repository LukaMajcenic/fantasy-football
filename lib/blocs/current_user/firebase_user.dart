
import 'package:fantasy_football/blocs/current_user/firebase_user_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentUserCubit extends Cubit<CurrentUserState>
{
  CurrentUserCubit() : super(CurrentUserLoggedOut())
  {
    FirebaseAuth.instance.authStateChanges().listen((User? user) 
    {
      emit(user != null ? CurrentUserLoggedIn(user: user) : CurrentUserLoggedOut());
    });
  }
}