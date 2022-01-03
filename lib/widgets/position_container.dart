import 'package:flutter/material.dart';

class PositionContainer extends StatelessWidget {
  const PositionContainer(this.text, this.color, {this.textScaleFactor = 1, Key? key }) : super(key: key);

  final String text;
  final Color color;
  final double textScaleFactor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      padding: const EdgeInsets.all(2),
      child: Text(
        text.toUpperCase(),
        textScaleFactor: textScaleFactor,
        style: TextStyle(color: Colors.grey[900]),
      ),
    );
  }
}