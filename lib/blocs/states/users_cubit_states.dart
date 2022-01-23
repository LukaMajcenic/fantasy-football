import 'package:fantasy_football/models/user.dart';

abstract class UsersCubitState
{
  List<User> users;

  UsersCubitState([List<User>?  users]) : users = users ?? [];
}

class UsersLoading extends UsersCubitState
{

}

class UsersLoaded extends UsersCubitState
{
  UsersLoaded({required List<User> users}) : super(users);
}