import 'package:fantasy_football/blocs/players/players_cubit_state.dart';
import 'package:fantasy_football/services/DbServices/players_db_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayersCubit extends Cubit<PlayersCubitState> 
{
  PlayersCubit() : super(PlayersLoading());

  Future<void> loadPlayers() async
  {
    emit(PlayersLoading());
    emit(PlayersLoaded(players: await PlayersDbServices.getPlayers()));
  }
}