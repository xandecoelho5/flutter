import 'package:flutter/material.dart';

import 'game_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? _deviceHeight, _deviceWidth;
  double _selectedDifficulty = 0;
  final _difficultyOptions = ['Easy', 'Medium', 'Hard'];

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                const Text(
                  'Frivia',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _difficultyOptions[_selectedDifficulty.toInt()],
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
              child: Slider(
                value: _selectedDifficulty,
                max: 2,
                divisions: 2,
                label: 'Difficulty',
                onChanged: (value) =>
                    setState(() => _selectedDifficulty = value),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GamePage(
                    difficulty: _difficultyOptions[_selectedDifficulty.toInt()],
                  ),
                ),
              ),
              child: Container(
                width: _deviceWidth! * 0.8,
                height: _deviceHeight! * 0.1,
                decoration: const BoxDecoration(color: Colors.blue),
                child: const Center(
                  child: Text(
                    'Start',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
