import 'package:flutter/material.dart';

import '../../../utils/consts.dart';

class CircleContainer extends StatelessWidget {
  const CircleContainer({Key? key, required this.size}) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: secondaryColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
