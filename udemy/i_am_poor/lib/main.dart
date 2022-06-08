import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('I Am Poor'),
          backgroundColor: Colors.grey[800],
        ),
        body: Center(
          child: Image.asset('images/poor.jpg'),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
