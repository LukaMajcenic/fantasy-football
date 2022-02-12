import 'package:fantasy_football/const/colors.dart';
import 'package:flutter/material.dart';

class IconButtonV2 extends StatelessWidget {
  const IconButtonV2({
    required this.onPressed, 
    required this.icon,
    this.colors,
    Key? key 
  }) : super(key: key);

  final VoidCallback onPressed;
  final IconData icon;
  final List<Color>? colors;

  @override
  Widget build(BuildContext context) {

    //Gradient requires at least two values
    if(colors?.length == 1) {
      colors?.add(colors?.first as Color);
    }

    return ShaderMask(
       shaderCallback: (bounds) => RadialGradient(
        center: Alignment.bottomRight,
        radius: 0.6,
        colors: colors ?? [C.green, C.silver],
        tileMode: TileMode.mirror
      ).createShader(bounds),
      child: IconButton(
        onPressed: onPressed, 
        icon: Icon(icon)
      ),
    );
  }
}