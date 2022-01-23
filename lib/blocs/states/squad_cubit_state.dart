import 'package:fantasy_football/models/squad.dart';

abstract class SquadCubitState
{
  Squad squad;

  SquadCubitState([Squad? squad]) : squad = squad ?? Squad(squadSelected: false);
}

class SquadLoading extends SquadCubitState
{

}

class SquadLoaded extends SquadCubitState
{
  SquadLoaded({required squad}) : super(squad);
}