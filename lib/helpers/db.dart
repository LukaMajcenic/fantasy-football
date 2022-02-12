class HelperDb
{
  static double readDouble(dynamic value)
  {
    return value.runtimeType == double ? value : (value as int).toDouble();
  }
}