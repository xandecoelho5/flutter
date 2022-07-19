import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../models/pokemon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double _deviceWidth;
  late double _deviceHeight;

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
    final textColor = Colors.grey.shade600; //Color.fromRGBO(153, 153, 155, 1);
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.transparent),
    );

    // TODO change selection color of search bar
    return TextField(
      decoration: InputDecoration(
        focusedBorder: border,
        enabledBorder: border,
        fillColor: const Color.fromRGBO(242, 242, 242, 1),
        filled: true,
        hintText: 'What Pokémon are you looking for?',
        hintStyle: TextStyle(color: textColor),
        prefixIconConstraints: BoxConstraints(minWidth: _deviceWidth * 0.11),
        prefixIcon: Icon(
          Icons.search,
          color: textColor,
          size: 20,
        ),
      ),
      cursorColor: textColor,
      style: TextStyle(color: textColor),
    );
  }

  _pokemonList() {
    const pokemons = [
      Pokemon(
        pokedexNumber: 1,
        name: 'Bulbasaur',
        imageUrl:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
        types: [PokemonTypes.grass, PokemonTypes.poison],
      ),
      Pokemon(
        pokedexNumber: 4,
        name: 'Charmander',
        // imageUrl: 'assets/generations/generation1/004.png',
        imageUrl:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png',
        types: [PokemonTypes.fire],
      ),
      Pokemon(
        pokedexNumber: 7,
        name: 'Squirtle',
        // imageUrl: 'assets/generations/generation1/007.png',
        imageUrl:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/7.png',
        types: [PokemonTypes.water],
      )
    ];

    // TODO pick correct colors for pokemon types
    // TODO align correctly the pokemon type inside the container
    _pokemonCard(Pokemon pokemon) {
      _info() {
        _types() {
          return Row(
            children: pokemon.types.map((type) {
              return Container(
                height: _deviceHeight * 0.032,
                padding: const EdgeInsets.only(
                  right: 4,
                  top: 4,
                  bottom: 4,
                ),
                margin: EdgeInsets.only(right: _deviceWidth * 0.015),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: type.foregroundColor,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/types/${type.name}.svg',
                      color: Colors.white,
                    ),
                    Text(
                      type.type,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '#${pokemon.pokedexNumber.toString().padLeft(3, '0')}',
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
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
            _types(),
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
            vertical: _deviceHeight * 0.025,
          ),
          height: _deviceHeight * 0.17,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: pokemon.types.first.backgroundColor,
          ),
          child: _info(),
        );
      }

      return Container(
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
      );
    }

    return Expanded(
      child: ListView.separated(
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: _deviceHeight * 0.05),
            const Text(
              'Pokédex',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: _deviceHeight * 0.01),
            Text(
              'Search for Pokémon by name or using the National Pokédex number.',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 15,
              ),
            ),
            SizedBox(height: _deviceHeight * 0.038),
            _searchBar(),
            SizedBox(height: _deviceHeight * 0.05),
            _pokemonList(),
          ],
        ),
      ),
    );
  }
}
