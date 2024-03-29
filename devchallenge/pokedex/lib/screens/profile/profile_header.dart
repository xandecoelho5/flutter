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

  _info() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '#${widget.pokemon.pokedexNumber.toString().padLeft(3, '0')}',
          style: TextStyle(
            color: kTextNumberDarker,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        FittedBox(
          child: Text(
            widget.pokemon.name,
            style: const TextStyle(
              color: kTextWhite,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
        ),
        const SizedBox(height: 4),
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
          fontWeight: FontWeight.bold,
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
        width: 140,
        height: 65,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: -8,
            child: _pokemonName(),
          ),
          Positioned(
            bottom: -10,
            right: -75,
            child: _pattern(),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 40,
              left: _deviceWidth * 0.1,
              right: _deviceWidth * 0.17,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _image(), flex: 5),
                Expanded(child: _info(), flex: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
