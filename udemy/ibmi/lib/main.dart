import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ibmi/pages/main_page.dart';
import 'package:ibmi/utils/calculator.dart';

void main() {
  calculateBMIAsync(Dio());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'IBMI',
      routes: {
        '/': (context) => const MainPage(),
      },
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
    );
  }
}
