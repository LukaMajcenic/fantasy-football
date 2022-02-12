import 'package:fantasy_football/blocs/admin_actions/admin_actions_cubit_state.dart';
import 'package:fantasy_football/services/DbServices/rounds_db_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminActionsCubit extends Cubit<AdminActionsCubitState>
{
  AdminActionsCubit() : super(AdminActionsNotExecuting());

  Future<void> simulateNextRound() async
  {
    await RoundsDbServices.simulateRound();
  }

  Future<void> resetRounds() async
  {
    await RoundsDbServices.initRounds();
  }
}