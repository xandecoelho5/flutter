import 'package:dio/dio.dart';

double calculateBMI(int height, int weight) {
  return 703 * (weight / (height * height));
}

Future<double> calculateBMIAsync(Dio dio) async {
  final result = await dio.get('https://jsonkeeper.com/b/AKFA');
  final data = result.data;
  final bmi = calculateBMI(data['Sergio Ramos'][0], data['Sergio Ramos'][1]);
  return bmi;
}
