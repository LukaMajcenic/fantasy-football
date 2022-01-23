import 'package:fantasy_football/blocs/states/squad_cubit_state.dart';
import 'package:fantasy_football/models/player.dart';
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
    Stream<DatabaseEvent> stream = ref.onValue;

    stream.listen((DatabaseEvent event) async {
      emit(SquadLoaded(squad: await SquadDbServices.loadSquad()));
    });
  }

  void changePlayer(SquadRole squadRole, [Player? player])
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


  Future saveSquad() async 
  {
    state.squad.squadSelected = true;
    await SquadDbServices.saveSquad(state.squad);
    emit(SquadLoaded(squad: Squad.from(state.squad)));
  }
 
  Future<Squad> loadSquad() async
  {
    if(!await SharedDbServices.nodeExists("users/${FirebaseAuth.instance.currentUser?.uid}"))
    {
      await SquadDbServices.initSquad();
    }

    Squad squad = await SquadDbServices.loadSquad();
    emit(SquadLoaded(squad: Squad.from(state.squad)));
    return squad;
  }
}