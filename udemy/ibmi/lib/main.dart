import 'package:flutter/cupertino.dart';
import 'package:ibmi/pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'IBMI',
      routes: {
        '/': (context) => const MainPage(),
      },
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
    );
  }
}
