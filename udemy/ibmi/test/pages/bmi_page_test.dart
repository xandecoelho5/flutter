import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibmi/pages/bmi_page.dart';

void main() {
  testWidgets(
      'Given weightInfoCard When user click + button Then weight increment by 1',
      (tester) async {
    //Arrange
    await tester.pumpWidget(const CupertinoApp(home: BMIPage()));
    final weightIncrementButton = find.byKey(const Key('weight_plus'));
    //Act
    await tester.tap(weightIncrementButton);
    await tester.pump();
    //Assert
    final text = find.text('161');
    expect(text, findsOneWidget);
  });

  testWidgets(
      'Given weightInfoCard When user click + button Then weight decremented by 1',
      (tester) async {
    //Arrange
    await tester.pumpWidget(const CupertinoApp(
      home: BMIPage(),
    ));
    final weightDecrementButton = find.byKey(const Key('weight_minus'));
    //Act
    await tester.tap(weightDecrementButton);
    await tester.pump();
    //Assert
    final text = find.text('159');
    expect(text, findsOneWidget);
  });
}
