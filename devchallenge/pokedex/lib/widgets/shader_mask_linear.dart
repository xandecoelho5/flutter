import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class ShaderMaskLinear extends StatelessWidget {
  const ShaderMaskLinear({
    Key? key,
    required this.from,
    required this.to,
    required this.colors,
    required this.child,
  }) : super(key: key);

  final Offset from;
  final Offset to;
  final List<Color> colors;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => ui.Gradient.linear(from, to, colors),
      child: child,
    );
  }
}
