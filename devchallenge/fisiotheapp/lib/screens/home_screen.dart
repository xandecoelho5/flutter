import 'package:flutter/material.dart';

import '../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double _deviceWidth;
  late double _deviceHeight;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;

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

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/images/person.png'),
            ),
            const Text(
              'Hey, Lorena!',
              style: TextStyle(
                fontFamily: 'Actor',
                fontSize: 30,
                color: Color(0xFF333333),
              ),
            ),
            SizedBox(height: _deviceHeight * 0.048),
            const Text(
              'Let\'s start your treatment? :)',
              style: TextStyle(
                color: Color(0xFF4F4F4F),
                fontSize: 25,
                height: 1.1,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: _deviceHeight * 0.06),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: kPurple,
                fixedSize: Size(_deviceWidth * 0.8, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              onPressed: () => Navigator.pushNamed(context, '/exercise'),
              child: const Text(
                'Start',
                style: TextStyle(
                  fontFamily: 'Actor',
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }
}
