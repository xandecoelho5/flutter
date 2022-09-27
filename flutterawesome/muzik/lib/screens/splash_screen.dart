import 'package:flutter/material.dart';

import '../utils/assets.dart';
import '../utils/routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, Routes.home);
    });

    return const Image(
      image: AssetImage(Assets.splash),
      fit: BoxFit.cover,
    );
  }
}
