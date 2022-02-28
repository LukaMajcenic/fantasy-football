import 'package:flutter/material.dart';

class C
{
  static const Color transparent = Colors.transparent;
  static const Color dark_1 = Color(0xFF191919);
  static const Color dark_2 = Color(0XFF212121);
  static const Color dark_3 = Color(0XFF2E2E2E);
  static const Color green = Color(0xFFB2FF59);
  static const Color blue = Color(0xFF2962FF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color silver = Color(0XFFAAAAAA);

  static String toHex(Color color)
  {
    return "#" + color.value.toRadixString(16).substring(2, 8).toUpperCase();
  }
}