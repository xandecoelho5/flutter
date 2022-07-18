import 'package:flutter/material.dart';

import '../models/exercise.dart';
import '../utils/constants.dart';

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
      selectedItemColor: kPurple,
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

    const shadows = [
      Shadow(
        blurRadius: 4,
        color: Color.fromRGBO(0, 0, 0, 0.25),
        offset: Offset(0, 4),
      ),
    ];

    _infoColumn(title, value) => Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF938989),
                fontWeight: FontWeight.w500,
                fontSize: 25,
                shadows: shadows,
              ),
            ),
            SizedBox(height: _deviceHeight * 0.003),
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF9E2D8C),
                fontSize: 25,
                fontWeight: FontWeight.w500,
                shadows: shadows,
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
                  style: const TextStyle(
                    fontFamily: 'Actor',
                    fontSize: 30,
                    color: Color(0xFF333333),
                    shadows: shadows,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: kPurple,
                    fixedSize: Size(_deviceWidth * 0.75, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    elevation: 5,
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Done!',
                    style: TextStyle(
                      fontFamily: 'Actor',
                      color: Colors.white,
                      fontSize: 30,
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
