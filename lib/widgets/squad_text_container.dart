import 'package:flutter/material.dart';

class SquadTextContainer extends StatelessWidget {
  const SquadTextContainer(this.text, this.backgroundColor, {Key? key }) : super(key: key);

  final String text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 5),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey[800]
        ),
      ),
    );
  }
}