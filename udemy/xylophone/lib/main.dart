import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() => runApp(const XylophoneApp());

class XylophoneApp extends StatelessWidget {
  const XylophoneApp({Key? key}) : super(key: key);

  void _playSound(int soundNumber) {
    final player = AudioCache();
    player.play('note$soundNumber.wav');
  }

  Expanded _buildKey(Color color, int soundNumber) {
    return Expanded(
      child: Container(
        color: color,
        child: TextButton(
          onPressed: () => _playSound(soundNumber),
          child: Container(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildKey(Colors.red, 1),
              _buildKey(Colors.orange, 2),
              _buildKey(Colors.yellow, 3),
              _buildKey(Colors.green, 4),
              _buildKey(Colors.teal, 5),
              _buildKey(Colors.blue, 6),
              _buildKey(Colors.purple, 7),
            ],
          ),
        ),
      ),
    );
  }
}
