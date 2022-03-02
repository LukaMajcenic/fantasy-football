import 'package:fantasy_football/blocs/rounds/rounds_cubit_state.dart';
import 'package:fantasy_football/models/round.dart';
import 'package:fantasy_football/services/DbServices/rounds_db_services.dart';
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
    emit(RoundsLoaded(rounds: await RoundsDbServices.loadRounds()));
  }

  Future<void> loadRoundSquad(Round round) async
  {
    emit(LoadingRoundInfo(rounds: state.rounds));
    state.rounds.firstWhere((r) => r.roundId == round.roundId).squadThatRound = (await RoundsDbServices.loadRoundSquad(round)).squadThatRound;
    emit(RoundsLoaded(rounds: state.rounds));
  }
}