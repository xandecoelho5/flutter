import 'package:flutter/material.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({Key? key, required this.onSave}) : super(key: key);

  final Function(String?) onSave;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(hintText: 'Password...'),
      onSaved: onSave,
      validator: (value) => value!.length > 6
          ? null
          : 'Please enter a password greater than 6 characters',
    );
  }
}
