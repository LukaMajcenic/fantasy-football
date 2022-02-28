import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({this.text, Key? key }) : super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            value: null,
            semanticsLabel: text ?? '',
          ),
          Text(text ?? '')
        ],
      )
    );
  }
}