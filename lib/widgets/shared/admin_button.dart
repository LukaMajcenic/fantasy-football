import 'package:fantasy_football/blocs/admin_actions/admin_actions_cubit.dart';
import 'package:fantasy_football/blocs/admin_actions/admin_actions_cubit_state.dart';
import 'package:fantasy_football/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AdminButton extends StatelessWidget {
  const AdminButton({required this.text, required this.onPressed, this.icon, Key? key }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 6),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: icon == null ? [
                Text(text.toUpperCase()),
              ] : [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    icon, 
                    color: C.blue
                  ),
                ),
                Text(text.toUpperCase()),
              ],
            );
          }
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: C.dark_2,
          onPrimary: C.green,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w900,
          ),
          side: const BorderSide(
            color: C.blue,
            width: 2
          )
        ),
      ),
    );
  }
}