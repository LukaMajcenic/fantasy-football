import 'package:fantasy_football/blocs/page/page_cubit.dart';
import 'package:fantasy_football/blocs/page/page_cubit_state.dart';
import 'package:fantasy_football/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBottomNavigationBar extends StatelessWidget {
  const MainBottomNavigationBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageCubit, PageCubitState>(
      builder: (_, state) {
        return BottomNavigationBar(
          onTap: (newIndex) async {
            await context.read<PageCubit>().changeIndexBottomNavigation(newIndex);
          },
          currentIndex: state.index,
          unselectedItemColor:  C.white.withOpacity(0.4),
          selectedItemColor: C.green,
          backgroundColor: C.blue,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.people), 
              label: "",
              backgroundColor: C.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sports_soccer), 
              label: "",
              backgroundColor: C.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.table_chart_outlined), 
              label: "",
              backgroundColor: C.blue,
            )
          ],
        );
      },
    );
  }
}