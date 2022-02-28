import 'package:fantasy_football/blocs/all_users/all_users_cubit_state.dart';
import 'package:fantasy_football/services/DbServices/users_db_services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllUsersCubit extends Cubit<AllUsersCubitState>
{
  AllUsersCubit() : super(AllUsersLoading())
  {
    DatabaseReference ref = FirebaseDatabase.instance.ref("rounds");
    Stream<DatabaseEvent> stream = ref.onChildChanged;

    stream.listen((DatabaseEvent event) async {
      loadUsers();
    });
  }

  Future loadUsers() async
  {
    emit(AllUsersLoaded(users: await UserDbServices.getUsers()));
  }
}