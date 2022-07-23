import 'package:flutter/material.dart';
import 'package:pokedex/screens/home/home_screen.dart';
import 'package:pokedex/utils/constants.dart';
import 'package:pokedex/widgets/custom_scroll_behavior.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex',
      home: const HomeScreen(),
      theme: ThemeData(
        primaryColor: kTypePsychic,
        fontFamily: 'SF Pro Display',
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: kTypePsychic,
            ),
        buttonTheme: ButtonThemeData(
          buttonColor: kTypePsychic,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        ),
      ),
      scrollBehavior: CustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
    );
  }
}
