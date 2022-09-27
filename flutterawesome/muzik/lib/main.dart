import 'package:flutter/material.dart';
import 'package:muzik/screens/bookmark_screen.dart';
import 'package:muzik/screens/home_screen.dart';
import 'package:muzik/screens/main_screen.dart';
import 'package:muzik/screens/playing_screen.dart';
import 'package:muzik/screens/playlist_screen.dart';
import 'package:muzik/screens/search_screen.dart';
import 'package:muzik/screens/song_screen.dart';
import 'package:muzik/screens/splash_screen.dart';
import 'package:muzik/utils/routes.dart';
import 'package:muzik/widgets/custom_scroll_behavior.dart';

int bottomBarSelectedIndex = 0;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Muzik',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark().copyWith(
          surface: Colors.black,
          primary: Colors.black,
          secondary: Colors.white,
        ),
        chipTheme: const ChipThemeData(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
          side: BorderSide(color: Colors.white),
          backgroundColor: Colors.black,
          labelStyle: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          selectedColor: Color(0xFF4E4E4E),
        ),
        sliderTheme: const SliderThemeData().copyWith(
          activeTrackColor: Colors.white,
          inactiveTrackColor: Colors.white.withOpacity(0.5),
          thumbColor: Colors.white,
          overlayColor: Colors.white.withOpacity(0.5),
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 14.0),
        ),
      ),
      themeMode: ThemeMode.dark,
      scrollBehavior: CustomScrollBehavior(),
      initialRoute: Routes.splash,
      routes: {
        Routes.splash: (context) => const SplashScreen(),
        Routes.main: (context) => const MainScreen(),
        Routes.home: (context) => const HomeScreen(),
        Routes.search: (context) => const SearchScreen(),
        Routes.song: (context) => const SongScreen(),
        Routes.bookmark: (context) => const BookmarkScreen(),
        Routes.playlist: (context) => const PlaylistScreen(),
        Routes.playing: (context) => const PlayingScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
