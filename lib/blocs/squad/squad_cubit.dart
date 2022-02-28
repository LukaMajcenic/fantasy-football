import 'package:fantasy_football/blocs/squad/squad_cubit_state.dart';
import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/models/position.dart';
import 'package:fantasy_football/models/squad.dart';
import 'package:fantasy_football/services/DbServices/shared_db_services.dart';
import 'package:fantasy_football/services/DbServices/squad_db_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SquadCubit extends Cubit<SquadCubitState>
{
  SquadCubit() : super(SquadLoading())
  {
    DatabaseReference ref = FirebaseDatabase.instance.ref("rounds");
    Stream<DatabaseEvent> stream = ref.onChildChanged;

    stream.listen((DatabaseEvent event) async {
      await loadSquad();
    });
  }

  Future<void> loadSquad() async
  {
    print("called");
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

  void addPlayer({required SquadRole squadRole, required Player player})
  {
    switch(squadRole)
    {
      case SquadRole.goalkeeper:
        state.squad.goalkeeper = player;
        break;
      case SquadRole.defender:
        state.squad.defender = player;
        break;
      case SquadRole.midfielder:
        state.squad.midfielder = player;
        break;
      case SquadRole.attacker:
        state.squad.attacker = player;
        break;
      case SquadRole.sub1:
        state.squad.sub1 = player;
        break;
      case SquadRole.sub2:
        state.squad.sub2 = player;
        break;
    }

    emit(SquadLoaded(squad: Squad.from(state.squad)));
  }

  void removePlayer({required SquadRole squadRole})
  {
    switch(squadRole)
    {
      case SquadRole.goalkeeper:
        state.squad.goalkeeper = null;
        break;
      case SquadRole.defender:
        state.squad.defender = null;
        break;
      case SquadRole.midfielder:
        state.squad.midfielder = null;
        break;
      case SquadRole.attacker:
        state.squad.attacker = null;
        break;
      case SquadRole.sub1:
        state.squad.sub1 = null;
        break;
      case SquadRole.sub2:
        state.squad.sub2 = null;
        break;
    }

    emit(SquadLoaded(squad: Squad.from(state.squad)));
  }

  Future<void> saveSquad() async
  {
    state.squad.squadSelected = true;
    emit(SquadSaving(squad: state.squad));
    await SquadDbServices.saveSquad(state.squad);
    emit(SquadLoaded(squad: state.squad));
    await loadSquad();
  }
}