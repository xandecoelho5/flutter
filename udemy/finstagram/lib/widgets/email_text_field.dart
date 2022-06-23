import 'package:flutter/material.dart';

final regexValidation = RegExp(
    r"^[a-zA-Z\d.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z\d](?:[a-zA-Z\d-]{0,253}[a-zA-Z\d])?(?:\.[a-zA-Z\d](?:[a-zA-Z\d-]{0,253}[a-zA-Z\d])?)*$");

class EmailTextField extends StatelessWidget {
  const EmailTextField({Key? key, required this.onSave}) : super(key: key);

  final Function(String?) onSave;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(hintText: 'Email...'),
      onSaved: onSave,
      validator: (value) {
        return value!.contains(regexValidation)
            ? null
            : 'Please enter a valid email';
      },
    );
  }
}
