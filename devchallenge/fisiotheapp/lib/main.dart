import 'package:fisiotheapp/screens/exercise_screen.dart';
import 'package:fisiotheapp/screens/home_screen.dart';
import 'package:fisiotheapp/utils/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fisiotheapp',
      theme: ThemeData(
        primaryColor: kPurple,
        fontFamily: 'ABeeZee',
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomeScreen(),
        '/exercise': (context) => const ExerciseScreen(),
      },
    );
  }
}
