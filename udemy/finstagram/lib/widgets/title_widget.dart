import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Finstagram',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
    );
  }
}
