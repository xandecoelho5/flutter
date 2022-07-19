import 'package:flutter/material.dart';

enum PokemonTypes {
  bug('Bug', Colors.green, Colors.green),
  dark('Dark', Colors.black, Colors.black),
  dragon('Dragon', Colors.blue, Colors.blue),
  eletric('Eletric', Colors.yellow, Colors.yellow),
  fairy('Fairy', Colors.pink, Colors.pink),
  fighting('Fighting', Colors.red, Colors.red),
  fire('Fire', Colors.orange, Colors.orange),
  flying('Flying', Colors.lightBlue, Colors.lightBlue),
  ghost('Ghost', Colors.purple, Colors.purple),
  grass('Grass', Colors.green, Color.fromRGBO(139, 190, 138, 1)),
  ground('Ground', Colors.brown, Colors.brown),
  ice('Ice', Colors.blue, Colors.blue),
  normal('Normal', Colors.grey, Colors.grey),
  poison('Poison', Colors.purple, Colors.purple),
  psychic('Psychic', Colors.pink, Colors.pink),
  rock('Rock', Colors.brown, Colors.brown),
  steel('Steel', Colors.grey, Colors.grey),
  water('Water', Colors.blue, Colors.blue);

  const PokemonTypes(this.type, this.foregroundColor, this.backgroundColor);

  final String type;
  final Color foregroundColor;
  final Color backgroundColor;
}

class Pokemon {
  final int pokedexNumber;
  final String name;
  final String imageUrl;
  final List<PokemonTypes> types;

  const Pokemon({
    required this.pokedexNumber,
    required this.name,
    required this.imageUrl,
    required this.types,
  });
}
