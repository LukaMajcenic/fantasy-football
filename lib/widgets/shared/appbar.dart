import 'package:fantasy_football/blocs/pageview_cubit.dart';
import 'package:fantasy_football/blocs/squad_cubit.dart';
import 'package:fantasy_football/const/colors.dart';
import 'package:fantasy_football/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class SharedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SharedAppBar(this.text, { Key? key }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: C.dark_2,
      title: Text(text),
      actions: [
        IconButton(
          onPressed: () async {
            await LoginService.logout();
            context.read<PageViewCubit>().reset();
            context.read<SquadCubit>().reset();
          }, 
          icon: const Icon(Icons.logout)
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}