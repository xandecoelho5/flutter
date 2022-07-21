import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/models/pokemon.dart';

import '../../components/badge.dart';
import '../../utils/constants.dart';
import '../../widgets/shader_mask_linear.dart';

class ProfileHeaderComponent extends StatefulWidget {
  const ProfileHeaderComponent({Key? key, required this.pokemon})
      : super(key: key);

  final Pokemon pokemon;

  @override
  State<ProfileHeaderComponent> createState() => _ProfileHeaderComponentState();
}

class _ProfileHeaderComponentState extends State<ProfileHeaderComponent> {
  late double _deviceWidth;
  late double _deviceHeight;

  _info() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '#${widget.pokemon.pokedexNumber.toString().padLeft(3, '0')}',
          style: TextStyle(
            color: kTextNumberDarker,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        Text(
          widget.pokemon.name,
          style: const TextStyle(
            color: kTextWhite,
            fontWeight: FontWeight.w700,
            fontSize: 32,
          ),
        ),
        Row(
          children: widget.pokemon.types.map((type) => Badge(type)).toList(),
        ),
      ],
    );
  }

  _image() {
    return Stack(
      children: [
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (Rect bounds) {
            return ui.Gradient.linear(
              bounds.topLeft,
              bounds.bottomCenter,
              [
                Colors.white.withOpacity(0.0),
                Colors.white.withOpacity(0.35),
              ],
            );
          },
          child: ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (Rect bounds) {
              return ui.Gradient.linear(
                bounds.topCenter,
                bounds.bottomRight,
                [
                  Colors.white.withOpacity(0.0),
                  Colors.white.withOpacity(1),
                ],
              );
            },
            child: SvgPicture.asset(
              'assets/patterns/circle.svg',
              height: 125,
              width: 125,
            ),
          ),
        ),
        Image.network(
          widget.pokemon.imageUrl,
          height: 125,
          width: 125,
        ),
      ],
    );
  }

  _pokemonName() {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) {
        return ui.Gradient.linear(
          bounds.topCenter,
          bounds.bottomCenter,
          kGradientVector,
        );
      },
      child: Text(
        widget.pokemon.name.toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 100,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2
            ..shader = ui.Gradient.linear(
              const Offset(0.0, 50.0),
              const Offset(0.0, 100.0),
              [kTextWhite, kWhiteTenOpacity],
            ),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  _pattern() {
    return ShaderMaskLinear(
      from: const Offset(0.0, 0.0),
      to: const Offset(0.0, 70.0),
      colors: kGradientVector,
      child: SvgPicture.asset(
        'assets/patterns/10x5.svg',
        width: 65,
        height: 70,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Stack(
        children: [
          SizedBox(height: _deviceHeight * 0.283),
          Positioned(
            top: 0,
            left: -90,
            child: _pokemonName(),
          ),
          Positioned(
            bottom: 5,
            right: -82,
            child: _pattern(),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: _deviceHeight * 0.08,
              left: _deviceWidth * 0.1,
              right: _deviceWidth * 0.17,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _image(),
                _info(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
