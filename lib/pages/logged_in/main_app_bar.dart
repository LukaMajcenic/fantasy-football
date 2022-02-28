import 'package:fantasy_football/blocs/page/page_cubit.dart';
import 'package:fantasy_football/blocs/page/page_cubit_state.dart';
import 'package:fantasy_football/const/colors.dart';
import 'package:fantasy_football/services/login_service.dart';
import 'package:fantasy_football/widgets/shared/icon_button_v2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: C.dark_2,
      leading: IconButtonV2(
        onPressed: () => Scaffold.of(context).openDrawer(), 
        icon: Icons.menu_sharp
      ),
      title: BlocBuilder<PageCubit, PageCubitState>(
        builder: (_, state) {
          return Text(state.appBarText);
        }
      ),
      actions: [
        IconButtonV2(
          onPressed: () async {
            context.read<PageCubit>().changeIndexBottomNavigation(0);
            await LoginService.logout();
          }, 
          icon: Icons.logout
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}