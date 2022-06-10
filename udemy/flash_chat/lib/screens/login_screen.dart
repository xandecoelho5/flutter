import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/rounded_button.dart';
import '../constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String _email = '';
  String _password = '';
  bool _showSpinner = false;

  void _login() async {
    try {
      setState(() => _showSpinner = true);
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      if (userCredential != null) {
        Navigator.pushNamed(context, AppRoutes.chat);
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() => _showSpinner = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(height: 48.0),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) => _email = value,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your email',
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) => _password = value,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                ),
              ),
              const SizedBox(height: 24.0),
              RoundedButton(
                color: Colors.lightBlueAccent,
                title: 'Log In',
                onPressed: _login,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
