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

class LoadingRoundInfo extends RoundsCubitState
{
  LoadingRoundInfo({required rounds}) : super(rounds);
}