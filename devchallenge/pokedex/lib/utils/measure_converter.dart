class MeasureConverter {
  MeasureConverter._();

  static const double _metersToInchsConversion = 39.37;
  static const double _kilogramsToPoundsConversion = 2.205;

  static double metersToInchs(double meters) {
    return meters * _metersToInchsConversion;
  }

  static double kilogramsToPounds(double kilograms) {
    return kilograms * _kilogramsToPoundsConversion;
  }
}
