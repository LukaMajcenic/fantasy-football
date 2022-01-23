import 'package:fantasy_football/const/colors.dart';
import 'package:flutter/material.dart';

class AdminButton extends StatelessWidget {
  AdminButton({required this.text, required this.onPressed, this.icon, Key? key }) : super(key: key);

  String text;
  VoidCallback onPressed;
  IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 6),
      child: ElevatedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
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
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: C.dark_2,
          onPrimary: C.white,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w900,
          )
        ),
      ),
    );
  }
}