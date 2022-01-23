import 'package:fantasy_football/blocs/states/users_cubit_states.dart';
import 'package:fantasy_football/services/DbServices/users_db_services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersCubit extends Cubit<UsersCubitState>
{
  UsersCubit() : super(UsersLoading())
  {
    DatabaseReference ref = FirebaseDatabase.instance.ref("rounds");
    Stream<DatabaseEvent> stream = ref.onValue;

    stream.listen((DatabaseEvent event) async {
      emit(UsersLoaded(users: await UserDbServices.getUsers()));
    });
  }
  
  Future loadUsers() async
  {
    print("eh?");
    emit(UsersLoaded(users: await UserDbServices.getUsers()));
  }
}