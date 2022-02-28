import 'package:fantasy_football/blocs/rounds/rounds_cubit_state.dart';
import 'package:fantasy_football/models/round.dart';
import 'package:fantasy_football/models/squad.dart';
import 'package:fantasy_football/services/DbServices/rounds_db_services.dart';
import 'package:fantasy_football/services/DbServices/squad_db_services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoundsCubit extends Cubit<RoundsCubitState>
{
  RoundsCubit() : super(RoundsLoading())
  {
    DatabaseReference ref = FirebaseDatabase.instance.ref("rounds");
    Stream<DatabaseEvent> stream = ref.onChildChanged;

    stream.listen((DatabaseEvent event) async {
      await loadRounds();
    });
  }

  Future<void> loadRounds() async
  {
    if(!await SquadDbServices.squadSelected())
    {
      emit(SquadNotSelected());
      return;
    }

    emit(RoundsLoaded(rounds: await RoundsDbServices.loadRounds()));
  }
}