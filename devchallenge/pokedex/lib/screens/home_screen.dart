import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex/components/badge.dart';
import 'package:pokedex/screens/profile_screen.dart';

import '../models/pokemon.dart';
import '../utils/constants.dart';
import '../utils/mocks.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double _deviceWidth;
  late double _deviceHeight;
  late final FocusNode _searchFocusNode;

  @override
  void initState() {
    super.initState();
    _searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _requestFocus() {
    setState(() => FocusScope.of(context).requestFocus(_searchFocusNode));
  }

  _appBar() {
    _svgIcon(assetName) {
      return InkWell(
        onTap: () {},
        child: SvgPicture.asset(
          'assets/icons/$assetName',
          color: Colors.black,
        ),
      );
    }

    return AppBar(
      actions: [
        _svgIcon('generation.svg'),
        SizedBox(width: _deviceWidth * 0.05),
        _svgIcon('sort.svg'),
        SizedBox(width: _deviceWidth * 0.05),
        _svgIcon('filter.svg'),
        SizedBox(width: _deviceWidth * 0.1),
      ],
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 30,
    );
  }

  _searchBar() {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.transparent, width: 0),
    );

    return TextField(
      onTap: _requestFocus,
      focusNode: _searchFocusNode,
      decoration: InputDecoration(
        focusedBorder: border,
        enabledBorder: border,
        fillColor: _searchFocusNode.hasFocus
            ? kBackgroundPressedInput
            : kBackgroundDefaultInput,
        hoverColor: kBackgroundPressedInput,
        filled: true,
        hintText: 'What Pokémon are you looking for?',
        hintStyle: const TextStyle(color: kTextGrey),
        prefixIconConstraints: BoxConstraints(minWidth: _deviceWidth * 0.11),
        prefixIcon: const Icon(
          Icons.search,
          color: kTextGrey,
          size: 20,
        ),
      ),
      style: const TextStyle(color: kTextBlack),
    );
  }

  _pokemonList() {
    // TODO align correctly the pokemon type inside the container
    _pokemonCard(Pokemon pokemon) {
      _info() {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '#${pokemon.pokedexNumber.toString().padLeft(3, '0')}',
              style: TextStyle(
                color: kTextNumber,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            Text(
              pokemon.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
            Row(
              children: pokemon.types.map((type) => Badge(type)).toList(),
            ),
          ],
        );
      }

      _image() {
        return Image.network(
          pokemon.imageUrl,
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
            color: pokemon.types.first.backgroundColor,
          ),
          child: _info(),
        );
      }

      return GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileScreen(pokemon: pokemon),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: pokemon.types.first.backgroundColor,
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

    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.symmetric(
          vertical: _deviceHeight * 0.05,
          horizontal: _deviceWidth * 0.05,
        ),
        itemCount: pokemons.length,
        itemBuilder: (context, index) => _pokemonCard(pokemons[index]),
        separatorBuilder: (_, __) => SizedBox(height: _deviceHeight * 0.02),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: Column(
        children: [
          SizedBox(height: _deviceHeight * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: _deviceWidth * 0.05,
              vertical: _deviceHeight * 0.015,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pokédex',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: _deviceHeight * 0.01),
                Text(
                  'Search for Pokémon by name or using the National Pokédex number.',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: _deviceHeight * 0.038),
                _searchBar(),
              ],
            ),
          ),
          _pokemonList(),
        ],
      ),
    );
  }
}
