import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/services/api_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayersCubit extends Cubit<List<Player>> 
{
  PlayersCubit() : super([]);

  void setList() async
  {
    if(state.isEmpty)
    {
      var players = await ApiServices.getPlayers();
      emit(players);
    }
  }
}