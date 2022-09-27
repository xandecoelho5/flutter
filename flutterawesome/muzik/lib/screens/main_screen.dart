import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muzik/screens/bookmark_screen.dart';
import 'package:muzik/screens/home_screen.dart';
import 'package:muzik/screens/playlist_screen.dart';
import 'package:muzik/screens/search_screen.dart';

import '../main.dart';
import '../utils/assets.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final bottomNavigationBarWidgets = [
    const HomeScreen(),
    const SearchScreen(),
    const PlaylistScreen(),
    const BookmarkScreen(),
  ];

  _onBottomNavigationBarTap(index) {
    setState(() {
      if (bottomBarSelectedIndex != index) {
        bottomBarSelectedIndex = index;
        // Navigator.pushNamed(context, bottomNavigationBarRoutes[index]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: bottomNavigationBarWidgets.elementAt(bottomBarSelectedIndex),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.black),
        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(Assets.homeSelected),
                icon: SvgPicture.asset(Assets.home),
                label: '',
              ),
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(Assets.searchSelected),
                icon: SvgPicture.asset(Assets.search),
                label: '',
              ),
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(Assets.musicSelected),
                icon: SvgPicture.asset(Assets.music),
                label: '',
              ),
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(Assets.bookmarkSelected),
                icon: SvgPicture.asset(Assets.bookmark),
                label: '',
              ),
            ],
            currentIndex: bottomBarSelectedIndex,
            showSelectedLabels: false,
            onTap: _onBottomNavigationBarTap,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}
