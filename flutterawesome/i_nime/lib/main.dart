import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:i_nime/repositories/anime_repository.dart';
import 'package:i_nime/screens/home_screen.dart';
import 'package:i_nime/services/anime_service.dart';

GetIt getIt = GetIt.instance;

void main() {
  getIt.registerSingleton(Dio());
  getIt.registerSingleton<IAnimeService>(AnimeService(getIt.get<Dio>()));
  getIt.registerSingleton<IAnimeRepository>(
    AnimeRepository(getIt.get<IAnimeService>()),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'INime',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
