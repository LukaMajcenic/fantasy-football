import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/models/squad.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SquadCubit extends Cubit<Squad>
{
  SquadCubit() : super(Squad());

  void changePlayer(SquadRole squadRole, [Player? player])
  {
    switch(squadRole)
    {
      case SquadRole.goalkeeper:
        state.goalkeeper = player;
        break;
      case SquadRole.defender:
        state.defender = player;
        break;
      case SquadRole.midfielder:
        state.midfielder = player;
        break;
      case SquadRole.attacker:
        state.attacker = player;
        break;
      case SquadRole.sub1:
        state.sub1 = player;
        break;
      case SquadRole.sub2:
        state.sub2 = player;
        break;
    }

    emit(Squad.from(state));
  }
}