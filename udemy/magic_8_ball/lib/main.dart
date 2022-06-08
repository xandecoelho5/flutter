import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: BallPage()));
}

class Ball extends StatefulWidget {
  const Ball({Key? key}) : super(key: key);

  @override
  State<Ball> createState() => _BallState();
}

class _BallState extends State<Ball> {
  int _ballNumber = 1;

  void _changeBallNumber() {
    setState(() => _ballNumber = Random().nextInt(5) + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: _changeBallNumber,
        child: Image.asset('images/ball$_ballNumber.png'),
      ),
    );
  }
}

class BallPage extends StatelessWidget {
  const BallPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ask Me Anything'),
        backgroundColor: Colors.blue[900],
      ),
      backgroundColor: Colors.blue,
      body: const Ball(),
    );
  }
}
