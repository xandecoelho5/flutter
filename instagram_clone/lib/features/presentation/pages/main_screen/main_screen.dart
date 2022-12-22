import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/features/presentation/pages/activity/activity_page.dart';
import 'package:instagram_clone/features/presentation/pages/home/home_page.dart';
import 'package:instagram_clone/features/presentation/pages/post/upload_post_page.dart';
import 'package:instagram_clone/features/presentation/pages/profile/profile_page.dart';
import 'package:instagram_clone/features/presentation/pages/search/search_page.dart';
import 'package:instagram_clone/utils/consts.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void navigationTapped(int index) => _pageController.jumpToPage(index);

  void onPageChanged(int index) => setState(() => _currentIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: const [
          HomePage(),
          SearchPage(),
          UploadPostPage(),
          ActivityPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: backgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: primaryColor,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: primaryColor,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle,
              color: primaryColor,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: primaryColor,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_outlined,
              color: primaryColor,
            ),
            label: "",
          ),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
