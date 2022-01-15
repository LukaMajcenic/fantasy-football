import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/services/api_services.dart';
import 'package:fantasy_football/services/db_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayersCubit extends Cubit<List<Player>> 
{
  PlayersCubit() : super([]);

  Future<List<Player>> loadPlayers() async
  {
    var players = await DbServices.getPlayers();
    emit(players);
    return players;
  }
}