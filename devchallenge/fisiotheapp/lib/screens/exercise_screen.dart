import 'package:flutter/material.dart';

import '../models/exercise.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  late double _deviceWidth;
  late double _deviceHeight;
  int _selectedIndex = 0;

  _bottomNavigationBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.folder_special),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_rounded),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book_rounded),
          label: '',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: const Color(0xFF5B3FFF),
      unselectedItemColor: Colors.grey,
      onTap: (index) => setState(() => _selectedIndex = index),
    );
  }

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;

    const exercise = Exercise(
      name: 'Close and open hands',
      imageUrl: 'assets/images/hand.png',
      series: 3,
      repetitions: 10,
      restSeconds: 20,
    );

    _infoColumn(title, value) => Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            SizedBox(height: _deviceHeight * 0.003),
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF9E2D8C),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          right: _deviceWidth * 0.05,
          left: _deviceWidth * 0.05,
          bottom: _deviceHeight * 0.09,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(image: AssetImage(exercise.imageUrl)),
            Column(
              children: [
                Text(
                  exercise.name,
                  style: const TextStyle(fontSize: 22),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(134, 0, 255, 1),
                    fixedSize: const Size(210, 35),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Done!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _infoColumn('Series', '${exercise.series}x'),
                _infoColumn('Repetitions', '${exercise.repetitions}'),
                _infoColumn('Rest', '${exercise.restSeconds} seg'),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }
}
