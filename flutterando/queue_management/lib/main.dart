import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:queue_management/firebase_options.dart';
import 'package:queue_management/src/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const AppWidget());
}
