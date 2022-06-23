import 'dart:io';

import 'package:finstagram/pages/home_page.dart';
import 'package:finstagram/pages/login_page.dart';
import 'package:finstagram/pages/register_page.dart';
import 'package:finstagram/services/firebase_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

const firebaseOptions = FirebaseOptions(
  appId: '1:183255749716:web:3c533301083ddedff889c1',
  apiKey: 'AIzaSyDdhUhlLrKphcjF-34OfTKxUUCMsgcIHXg',
  projectId: 'finstagram-udemy-7987d',
  messagingSenderId: '183255749716',
  authDomain: 'finstagram-udemy-7987d.firebaseapp.com',
  storageBucket: 'finstagram-udemy-7987d.appspot.com',
  measurementId: 'G-JEHGG3H0EE',
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows) {
    await Firebase.initializeApp(options: firebaseOptions);
  } else {
    await Firebase.initializeApp();
  }

  GetIt.instance.registerSingleton<FirebaseService>(FirebaseService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finstagram',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: 'login',
      routes: {
        'home': (context) => const HomePage(),
        'login': (context) => const LoginPage(),
        'register': (context) => const RegisterPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
