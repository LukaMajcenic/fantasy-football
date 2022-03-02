import 'package:fantasy_football/blocs/page/page_cubit.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class HomePageButton extends StatelessWidget {
  const HomePageButton({required this.navigateTo, required this.child, Key? key }) : super(key: key);

  final int navigateTo;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => context.read<PageCubit>().changeIndexBottomNavigation(navigateTo),
      child: child,
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        onPrimary: Colors.grey[200],
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
    );
  }
}