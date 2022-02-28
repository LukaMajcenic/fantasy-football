import 'dart:typed_data';

import 'package:fantasy_football/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ImageFutureBuilder extends StatelessWidget {
  const ImageFutureBuilder({required this.future, this.height, this.width, Key? key }) : super(key: key);

  final Future<Uint8List> future;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: future,
      builder: (_, snapshot) {

        if(snapshot.hasData)
        {
          return Image.memory(
            snapshot.data as Uint8List,
            height: height,
          );
        }

        return SpinKitRipple(
          color: C.white.withOpacity(0.4)
        );
      },
    );
  }
}