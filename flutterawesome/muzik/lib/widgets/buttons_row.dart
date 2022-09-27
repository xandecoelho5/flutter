import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muzik/utils/assets.dart';

class ButtonsRow extends StatelessWidget {
  const ButtonsRow({
    Key? key,
    required this.plays,
    required this.downloads,
    required this.likes,
    this.mainAxisAlignment,
  }) : super(key: key);

  final int plays;
  final int downloads;
  final int likes;
  final MainAxisAlignment? mainAxisAlignment;

  List<Widget> _iconRow(String assetName, int count) {
    return [
      SvgPicture.asset(assetName),
      const SizedBox(width: 4),
      Text(
        '$count',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      children: [
        ..._iconRow(Assets.play, plays),
        const SizedBox(width: 16),
        ..._iconRow(Assets.download, downloads),
        const SizedBox(width: 16),
        ..._iconRow(Assets.heart, likes),
      ],
    );
  }
}
