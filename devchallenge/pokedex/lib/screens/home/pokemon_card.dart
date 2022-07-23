import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../components/badge.dart';
import '../../models/pokemon.dart';
import '../../utils/constants.dart';
import '../profile/profile_screen.dart';

class PokemonCardComponent extends StatefulWidget {
  const PokemonCardComponent({Key? key, required this.pokemon})
      : super(key: key);

  final Pokemon pokemon;

  @override
  State<PokemonCardComponent> createState() => _PokemonCardComponentState();
}

class _PokemonCardComponentState extends State<PokemonCardComponent> {
  late double _deviceWidth;
  late double _deviceHeight;

  // TODO align correctly the pokemon type inside the container
  _info() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '#${widget.pokemon.pokedexNumber.toString().padLeft(3, '0')}',
          style: TextStyle(
            color: kTextNumber,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        Text(
          widget.pokemon.name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        Row(
          children: widget.pokemon.types.map((type) => Badge(type)).toList(),
        ),
      ],
    );
  }

  _image() {
    return Image.network(
      widget.pokemon.imageUrl,
      fit: BoxFit.cover,
      height: _deviceHeight * 0.2,
    );
  }

  _pattern() {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) {
        return ui.Gradient.linear(
          const Offset(0.0, 35.0),
          const Offset(0.0, 0.0),
          [
            Colors.white.withOpacity(0.0),
            Colors.white.withOpacity(0.25),
          ],
        );
      },
      child: SvgPicture.asset(
        'assets/patterns/6x3.svg',
        fit: BoxFit.contain,
        height: _deviceHeight * 0.048,
      ),
    );
  }

  _pokeball() {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) {
        return ui.Gradient.linear(
          const Offset(200.0, 0.0),
          const Offset(200.0, 130.0),
          [
            Colors.white.withOpacity(0.25),
            Colors.white.withOpacity(0.0),
          ],
        );
      },
      child: SvgPicture.asset(
        'assets/patterns/pokeball.svg',
        fit: BoxFit.contain,
        height: _deviceHeight * 0.22,
      ),
    );
  }

  _container() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _deviceWidth * 0.05,
        vertical: _deviceHeight * 0.02,
      ),
      height: _deviceHeight * 0.17,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.pokemon.types.first.backgroundColor,
      ),
      child: _info(),
    );
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(pokemon: widget.pokemon),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: widget.pokemon.types.first.backgroundColor,
              blurRadius: 20,
              offset: const Offset(0, 25),
              spreadRadius: -25,
            ),
          ],
        ),
        child: Stack(
          children: [
            SizedBox(
              height: _deviceHeight * 0.2,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: _container(),
            ),
            Positioned(
              right: _deviceWidth * -0.04,
              bottom: _deviceHeight * -0.03, // -15,
              child: _pokeball(),
            ),
            Positioned(
              right: _deviceWidth * 0.025,
              bottom: _deviceHeight * 0.008,
              child: _image(),
            ),
            Positioned(
              left: _deviceWidth * 0.215,
              top: _deviceHeight * 0.038, //0.016
              child: _pattern(),
            ),
          ],
        ),
      ),
    );
  }
}
