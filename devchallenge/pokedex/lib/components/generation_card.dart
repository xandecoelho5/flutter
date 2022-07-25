import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:numerus/numerus.dart';

import '../utils/constants.dart';

class GenerationCard extends StatelessWidget {
  const GenerationCard(
      {Key? key,
      this.selected = false,
      required this.generation,
      required this.numbers})
      : super(key: key);

  final bool selected;
  final int generation;
  final List<String> numbers;

  _pattern() {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) {
        return ui.Gradient.linear(
          bounds.topLeft,
          bounds.bottomRight,
          kGradientVectorGrey,
        );
      },
      child: SvgPicture.asset(
        'assets/patterns/6x3.svg',
        width: 80,
        height: 35,
      ),
    );
  }

  _pokeball() {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) {
        return ui.Gradient.linear(
          bounds.topLeft,
          bounds.bottomRight,
          selected ? kGradientPokeballWhite : kGradientPokeballGrey,
        );
      },
      child: SvgPicture.asset(
        'assets/patterns/pokeball.svg',
        width: 110,
        height: 110,
      ),
    );
  }

  Image _image(generation, number) {
    return Image.asset(
      'assets/generations/generation$generation/$number.png',
      fit: BoxFit.cover,
      width: 45,
      height: 45,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 129,
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: selected ? kTypePsychic : kBackgroundDefaultInput,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 10,
            left: 15,
            child: _pattern(),
          ),
          Positioned(
            top: 60,
            left: 70,
            child: _pokeball(),
          ),
          Positioned(
            left: 17,
            top: 30,
            child: _image(generation, numbers[0]),
          ),
          Positioned(
            left: 57,
            top: 30,
            child: _image(generation, numbers[1]),
          ),
          Positioned(
            left: 97,
            top: 30,
            child: _image(generation, numbers[2]),
          ),
          Positioned(
            bottom: 20,
            child: Text(
              'Generation ${generation.toRomanNumeralString()}',
              style: TextStyle(
                color: selected ? kTextWhite : kTextGrey,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
