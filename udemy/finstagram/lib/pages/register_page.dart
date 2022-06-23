import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:finstagram/services/firebase_service.dart';
import 'package:finstagram/widgets/password_text_field.dart';
import 'package:finstagram/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../widgets/custom_button.dart';
import '../widgets/email_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  double? _deviceHeight, _deviceWidth;

  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  FirebaseService? _firebaseService;

  String? _name, _email, _password;
  File? _image;

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
                _profileImageWidget(),
                _registrationForm(),
                CustomButton(label: 'Register', onPress: _registerUser),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _registrationForm() {
    return SizedBox(
      height: _deviceHeight! * 0.35,
      child: Form(
        key: _registerFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _nameTextField(),
            EmailTextField(onSave: (value) => setState(() => _email = value)),
            PasswordTextField(onSave: (v) => setState(() => _password = v)),
          ],
        ),
      ),
    );
  }

  Widget _profileImageWidget() {
    final _imageProvider = _image != null
        ? FileImage(_image!)
        : const NetworkImage('https://i.pravatar.cc/300');

    return GestureDetector(
      onTap: () {
        FilePicker.platform.pickFiles(type: FileType.image).then((value) {
          setState(() {
            _image = File(value!.files.first.path!);
          });
        });
      },
      child: Container(
        height: _deviceHeight! * 0.15,
        width: _deviceHeight! * 0.15,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: _imageProvider as ImageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _nameTextField() {
    return TextFormField(
      decoration: const InputDecoration(hintText: 'Name...'),
      onSaved: (value) => setState(() => _name = value),
      validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
    );
  }

  void _registerUser() async {
    if (_registerFormKey.currentState!.validate() && _image != null) {
      _registerFormKey.currentState!.save();
      final result = await _firebaseService!.registerUser(
        name: _name!,
        email: _email!,
        password: _password!,
        image: _image!,
      );

      if (result) Navigator.pop(context);
    }
  }
}
