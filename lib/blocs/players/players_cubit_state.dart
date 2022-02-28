import 'package:fantasy_football/models/player.dart';

abstract class PlayersCubitState
{
  List<Player> players;

  PlayersCubitState([List<Player>? players]) : players = players ?? [];
}

class PlayersLoading extends PlayersCubitState
{

}

class PlayersLoaded extends PlayersCubitState
{
  PlayersLoaded({required players}) : super(players);
}