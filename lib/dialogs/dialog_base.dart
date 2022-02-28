import 'package:fantasy_football/const/colors.dart';
import 'package:flutter/material.dart';

class DialogBase extends StatelessWidget {
  const DialogBase({required this.widget, Key? key }) : super(key: key);

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: C.dark_1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget,
            Container(
              padding: const EdgeInsets.only(right: 5),
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context), 
                child: const Text("Zatvori")
              ),
            )
          ],
        )
      )
    );
  }
}