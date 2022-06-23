import 'package:flutter/cupertino.dart';
import 'package:ibmi/pages/bmi_page.dart';

import 'history_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _tabs = [const BMIPage(), HistoryPage()];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('IBMI')),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'BMI',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person),
              label: 'History',
            ),
          ],
        ),
        tabBuilder: (context, index) {
          return CupertinoTabView(builder: (context) => _tabs[index]);
        },
      ),
    );
  }
}
