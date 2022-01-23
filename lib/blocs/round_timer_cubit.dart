import 'dart:async';

import 'package:fantasy_football/const/timers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoundTimerCubit extends Cubit<Duration>
{
  RoundTimerCubit() : super(const Duration())
  {
    DatabaseReference ref = FirebaseDatabase.instance.ref("rounds");
    Stream<DatabaseEvent> stream = ref.onValue;

    stream.listen((DatabaseEvent event) async {
      startTimer();
    });
  }

  void startTimer()
  {
    emit(Timers.afterRound);
    Timer.periodic(const Duration(seconds: 1), (timer) {
      emit(Duration(seconds: state.inSeconds - 1));

      if(state == const Duration())
      {
        timer.cancel();
      }
    });
  }
}