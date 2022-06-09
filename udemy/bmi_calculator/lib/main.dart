import 'package:flutter/material.dart';

import 'screens/input_page.dart';

void main() => runApp(const BMICalculator());

class BMICalculator extends StatelessWidget {
  const BMICalculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.light().copyWith(
          primary: const Color(0xFF0a0E21),
        ),
        scaffoldBackgroundColor: const Color(0xFF0a0E21),
      ),
      home: const InputPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
