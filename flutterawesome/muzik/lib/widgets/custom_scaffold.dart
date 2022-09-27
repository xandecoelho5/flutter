import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muzik/utils/routes.dart';

import '../main.dart';
import '../utils/assets.dart';

class CustomScaffold extends StatefulWidget {
  const CustomScaffold({
    Key? key,
    required this.child,
    this.appBar,
  }) : super(key: key);

  final Widget child;
  final AppBar? appBar;

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  final bottomNavigationBarRoutes = [
    Routes.home,
    Routes.search,
    Routes.playlist,
    Routes.bookmark,
  ];

  _onBottomNavigationBarTap(index) {
    setState(() {
      if (bottomBarSelectedIndex != index) {
        bottomBarSelectedIndex = index;
        Navigator.pushNamed(context, bottomNavigationBarRoutes[index]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: SafeArea(child: widget.child),
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
