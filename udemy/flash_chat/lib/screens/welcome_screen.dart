import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/app_routes.dart';
import 'package:flutter/material.dart';

import '../components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? animation;

  Future<void> init(BuildContext context) async {
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller!);

    controller!.forward();
    controller!.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    init(context);

    return Scaffold(
      backgroundColor: animation!.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 60.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Flash Chat',
                      textStyle: const TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                      speed: const Duration(milliseconds: 200),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 48.0),
            RoundedButton(
              color: Colors.lightBlueAccent,
              title: 'Log In',
              onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
            ),
            RoundedButton(
              color: Colors.blueAccent,
              title: 'Register',
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.registration),
            ),
          ],
        ),
      ),
    );
  }
}
