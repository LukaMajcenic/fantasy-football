import 'package:flutter/material.dart';

class PlayerInfoDialogTableCell extends StatelessWidget {
  const PlayerInfoDialogTableCell({required this.text, Key? key }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
        ),
      )
    );
  }
}