import 'package:fantasy_football/models/user.dart';

abstract class AllUsersCubitState
{
  List<User> users;

  AllUsersCubitState([List<User>?  users]) : users = users ?? [];
}

class AllUsersLoading extends AllUsersCubitState
{

}

class AllUsersLoaded extends AllUsersCubitState
{
  AllUsersLoaded({required List<User> users}) : super(users);
}