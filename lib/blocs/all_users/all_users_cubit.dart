import 'package:fantasy_football/blocs/all_users/all_users_cubit_state.dart';
import 'package:fantasy_football/services/DbServices/users_db_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllUsersCubit extends Cubit<AllUsersCubitState>
{
  AllUsersCubit() : super(AllUsersLoading());

  Future loadUsers() async
  {
    emit(AllUsersLoaded(users: await UserDbServices.getUsers()));
  }
}