import 'package:fantasy_football/blocs/admin_actions/admin_actions_cubit.dart';
import 'package:fantasy_football/blocs/admin_actions/admin_actions_cubit_state.dart';
import 'package:fantasy_football/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DrawerButton extends StatelessWidget {
  const DrawerButton({required this.text, required this.onPressed, required this.icon, Key? key }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ElevatedButton(
        child: BlocBuilder<AdminActionsCubit, AdminActionsCubitState>(
          builder: (_, state) {

            if(state.runtimeType == AdminActionsExecuting) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Text("Executing admin action"),
                  ),
                  SpinKitRing(
                    color: C.green,
                    lineWidth: 2,
                    size: 20,
                  )
                ],
              );
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon, 
                  color: C.blue
                ),
                Text(text.toUpperCase()),
              ],
            );
          }
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: C.dark_2,
          onPrimary: C.white,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}