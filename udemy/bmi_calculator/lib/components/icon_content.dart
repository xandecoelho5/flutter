import 'package:flutter/material.dart';

import '../constants.dart';

class IconContent extends StatelessWidget {
  const IconContent({
    required this.icon,
    required this.label,
    Key? key,
  }) : super(key: key);

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 70.0),
        const SizedBox(height: 15.0),
        Text(label, style: kLabelTextStyle)
      ],
    );
  }
}
