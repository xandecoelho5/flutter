import 'package:flash_chat/app_routes.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const FlashChat());

class FlashChat extends StatelessWidget {
  const FlashChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.welcome,
      routes: {
        AppRoutes.welcome: (context) => WelcomeScreen(),
        AppRoutes.login: (context) => LoginScreen(),
        AppRoutes.registration: (context) => RegistrationScreen(),
        AppRoutes.chat: (context) => ChatScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
