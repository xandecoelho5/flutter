import 'package:flutter/material.dart';

class CustomAppBar {
  CustomAppBar._();

  static AppBar build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back_ios_new),
        splashRadius: 24,
      ),
    );
  }
}
