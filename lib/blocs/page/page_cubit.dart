import 'package:fantasy_football/blocs/page/page_cubit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageCubit extends Cubit<PageCubitState>
{
  PageController controller = PageController();

  PageCubit() : super(PageCubitState(index: 0, appBarText: "Home"));

  Future _animateToPage(int index) async
  {
    await controller.animateToPage(
      index, 
      duration: const Duration(milliseconds: 400), 
      curve: Curves.easeInOut
    );
  }

  String _generateAppBarText(int index)
  {
    switch(index)
    {
      case 0:
        return "Home";
      case 1:
        return "Squad";
      case 2:
        return "Rounds";
      case 3:
        return "Standings";
      default:
        return "";
    }
  }

  void changeIndexPageView(int index)
  {
    emit(PageCubitState(index: index, appBarText: _generateAppBarText(index)));
  }

  Future changeIndexBottomNavigation(int index) async
  {
    await _animateToPage(index);
  }
}