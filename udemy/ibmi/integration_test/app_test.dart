import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibmi/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end app test', () {
    //Arrange
    final weightIncrementButton = find.byKey(const Key('weight_plus'));
    final ageIncrementButton = find.byKey(const Key('age_plus'));
    final calculateBMIButton = find.byType(CupertinoButton);

    testWidgets(
        'Given app is ran When height, age data input and calculateBMI button pressed Then correct BMI returned',
        (tester) async {
      app.main();
      //Act
      await tester.pumpAndSettle();
      await tester.tap(weightIncrementButton);
      await tester.pumpAndSettle();
      await tester.tap(ageIncrementButton);
      await tester.pumpAndSettle();
      await tester.tap(calculateBMIButton);
      await tester.pumpAndSettle();
      final resultText = find.text('Normal');
      //Assert
      expect(resultText, findsOneWidget);
    });
  });
}
