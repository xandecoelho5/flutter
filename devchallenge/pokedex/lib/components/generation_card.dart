import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:numerus/numerus.dart';

import '../utils/constants.dart';

class GenerationCard extends StatefulWidget {
  GenerationCard({
    Key? key,
    required this.selected,
    required this.generation,
    required this.numbers,
    required this.onSelected,
  }) : super(key: key);

  bool selected;
  final int generation;
  final List<String> numbers;
  final Function(bool) onSelected;

  @override
  State<GenerationCard> createState() => _GenerationCardState();
}

class _GenerationCardState extends State<GenerationCard> {
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
          widget.selected ? kGradientPokeballWhite : kGradientPokeballGrey,
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
    return SizedBox(
      height: 129,
      width: 160,
      child: Material(
        color: widget.selected ? kTypePsychic : kBackgroundDefaultInput,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: () {
            setState(() => widget.selected = !widget.selected);
            widget.onSelected(widget.selected);
          },
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
                child: _image(widget.generation, widget.numbers[0]),
              ),
              Positioned(
                left: 57,
                top: 30,
                child: _image(widget.generation, widget.numbers[1]),
              ),
              Positioned(
                left: 97,
                top: 30,
                child: _image(widget.generation, widget.numbers[2]),
              ),
              Positioned(
                bottom: 20,
                child: Text(
                  'Generation ${widget.generation.toRomanNumeralString()}',
                  style: TextStyle(
                    color: widget.selected ? kTextWhite : kTextGrey,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
