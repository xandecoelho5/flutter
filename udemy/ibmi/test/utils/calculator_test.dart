import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibmi/utils/calculator.dart';
import 'package:mocktail/mocktail.dart';

class DioMock extends Mock implements Dio {}

void main() {
  test(
    'Given height and weight When calculateBMI function invoked Then correct BMI returned',
    () {
      //Arrange
      const int height = 70, weight = 160;
      //Act
      double bmi = calculateBMI(height, weight);
      //Assert
      expect(bmi, equals(22.955102040816328));
    },
  );

  test('Given url When calculateBMIAsync invoked Then correct BMI returned',
      () async {
    //Arrange
    final dio = DioMock();
    when(() => dio.get('https://jsonkeeper.com/b/AKFA')).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: 'https://jsonkeeper.com/b/AKFA'),
        data: {
          'Sergio Ramos': [72, 165],
        },
      ),
    );
    //Act
    final result = await calculateBMIAsync(dio);
    //Assert
    expect(result, equals(22.375578703703706));
  });
}
