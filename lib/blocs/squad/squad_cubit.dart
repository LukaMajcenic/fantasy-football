import 'package:fantasy_football/blocs/squad/squad_cubit_state.dart';
import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/models/squad.dart';
import 'package:fantasy_football/services/DbServices/shared_db_services.dart';
import 'package:fantasy_football/services/DbServices/squad_db_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SquadCubit extends Cubit<SquadCubitState>
{
  SquadCubit() : super(SquadLoading());

  Future<void> loadSquad() async
  {
    if(!await SharedDbServices.nodeExists("users/${FirebaseAuth.instance.currentUser?.uid}"))
    {
      await SquadDbServices.initSquad();
    }

    emit(SquadLoading());
    emit(SquadLoaded(squad: await SquadDbServices.loadSquad()));
  }

  Future<void> swapPlayers(Player player) async
  {
    var newReserve = state.squad.firstTeamPlayers()
      .firstWhere((p) => p?.position.positionId == player.position.positionId) as Player;

    switch(player.position.positionId)
    {
      case 1:
        state.squad.goalkeeper = player;
        break;
      case 2:
        state.squad.defender = player;
        break;
      case 3:
        state.squad.midfielder = player;
        break;
      case 4:
        state.squad.attacker = player;
        break;
    }

    if(state.squad.sub1?.playerID == player.playerID)
    {
      state.squad.sub1 = newReserve;
    }
    else
    {
      state.squad.sub2 = newReserve;
    }

    emit(SquadSavingSwapPlayers(squad: state.squad));
    await SquadDbServices.saveSquad(state.squad);
    emit(SquadLoaded(squad: Squad.from(state.squad)));
  }
}