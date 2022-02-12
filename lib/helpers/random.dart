import 'dart:math';

class HelperRandom
{
  static double randomDouble(double min, double max) => double.parse((Random().nextDouble() * (min - max) + max).toStringAsFixed(2));
  static bool randomBool({double chanceForTrue = 0.8}) => Random().nextDouble() < chanceForTrue;
}