import 'package:firebase_auth/firebase_auth.dart';

abstract class CurrentUserState
{
  User? user;

  CurrentUserState([User? user]);
}

class CurrentUserLoading
{
  
}

class CurrentUserLoggedOut extends CurrentUserState
{
  
}

class CurrentUserLoggedIn extends CurrentUserState
{
  CurrentUserLoggedIn({User? user}) : super(user);
}