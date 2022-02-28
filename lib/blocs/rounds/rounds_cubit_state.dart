import 'package:fantasy_football/const/colors.dart';
import 'package:fantasy_football/models/round.dart';

abstract class RoundsCubitState
{
  List<Round> rounds;

  RoundsCubitState([List<Round>? rounds]) : rounds = rounds ?? [];
}

class RoundsLoading extends RoundsCubitState
{

}

class RoundsLoaded extends RoundsCubitState
{
  RoundsLoaded({required rounds}) : super(rounds);
}

class SquadNotSelected extends RoundsCubitState
{
  
}