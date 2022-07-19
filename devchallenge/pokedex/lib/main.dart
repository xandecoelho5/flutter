import 'package:flutter/material.dart';
import 'package:pokedex/screens/home_screen.dart';
import 'package:pokedex/utils/constants.dart';

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
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
