import 'package:fantasy_football/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({this.text, Key? key }) : super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: const [
              SpinKitCircle(
                color: C.green
              ),
              SpinKitCircle(
                color: C.blue,
                duration: Duration(milliseconds: 1000),
              )
            ],
          ),
          Text(text ?? "")
        ],
      )
    );
  }
}