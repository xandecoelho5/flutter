import 'package:finstagram/services/firebase_service.dart';
import 'package:finstagram/widgets/custom_button.dart';
import 'package:finstagram/widgets/email_text_field.dart';
import 'package:finstagram/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../widgets/password_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double? _deviceHeight, _deviceWidth;

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  FirebaseService? _firebaseService;

  String? _email, _password;

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.I<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const TitleWidget(),
                _loginForm(),
                CustomButton(label: 'Login', onPress: _loginUser),
                _registerPageLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginForm() {
    return SizedBox(
      height: _deviceHeight! * 0.25,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            EmailTextField(onSave: (value) => setState(() => _email = value)),
            // _emailTextField(),
            PasswordTextField(
                onSave: (value) => setState(() => _password = value)),
            // _passwordTextField(),
          ],
        ),
      ),
    );
  }

  Widget _registerPageLink() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'register'),
      child: const Text(
        "Don't have an account?",
        style: TextStyle(
          color: Colors.blue,
          fontSize: 18,
          fontWeight: FontWeight.w200,
        ),
      ),
    );
  }

  void _loginUser() async {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
      bool _result = await _firebaseService!
          .loginUser(email: _email!, password: _password!);
      if (_result) {
        Navigator.popAndPushNamed(context, 'home');
      }
    }
  }
}
