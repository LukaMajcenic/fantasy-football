import 'package:fantasy_football/models/round.dart';
import 'package:fantasy_football/services/DbServices/rounds_db_services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoundsCubit extends Cubit<List<Round>>
{
  RoundsCubit() : super([])
  {
    DatabaseReference ref = FirebaseDatabase.instance.ref("rounds");
    Stream<DatabaseEvent> stream = ref.onValue;

    stream.listen((DatabaseEvent event) async {
      emit(await RoundsDbServices.loadRounds());
    });
  }

  Future initRounds() async
  { 
    await RoundsDbServices.initRounds();
  }

  Future<List<Round>> loadRounds() async
  {
    var rounds = await RoundsDbServices.loadRounds();
    emit(rounds);
    return rounds;
  }

  Future simulateNextRound() async
  {
    await RoundsDbServices.simulateRound(state);
  }
}