import 'package:flutter/material.dart';
import 'package:pokedex/models/filter/generations_options.dart';
import 'package:pokedex/models/pokemon_height.dart';
import 'package:pokedex/models/pokemon_type.dart';

import '../pokemon.dart';
import '../pokemon_weight.dart';

class Filter {
  final List<PokemonType> types;
  final List<PokemonType> weaknesses;
  final List<PokemonHeight> heights;
  final List<PokemonWeight> weights;
  final RangeValues numberRange;
  final GenerationOptions? generation;

  const Filter({
    this.types = const [],
    this.weaknesses = const [],
    this.heights = const [],
    this.weights = const [],
    this.numberRange = const RangeValues(1, 898),
    this.generation,
  });

  bool get hasAnyFilter =>
      types.isNotEmpty ||
      weaknesses.isNotEmpty ||
      heights.isNotEmpty ||
      weights.isNotEmpty ||
      numberRange.start != 1 ||
      numberRange.end != 898 ||
      generation != null;

  List<Pokemon> doFilter(List<Pokemon> pokemons) {
    return pokemons.where((pokemon) {
      final byType = _listContains(types, pokemon.types);
      final byWeakness = _listContains(weaknesses, pokemon.weaknesses);
      final byHeight = heights.isEmpty ||
          heights.contains(PokemonHeight.getByHeight(pokemon.height));
      final byWeight = weights.isEmpty ||
          weights.contains(PokemonWeight.getByWeight(pokemon.weight));
      final byNumber = pokemon.pokedexNumber >= numberRange.start &&
          pokemon.pokedexNumber <= numberRange.end;
      final byGeneration = generation == null ||
          generation ==
              GenerationOptions.getGenerationByPokedexNumber(
                  pokemon.pokedexNumber);
      return byType &&
          byWeakness &&
          byHeight &&
          byWeight &&
          byNumber &&
          byGeneration;
    }).toList();
  }

  bool _listContains(List list, List target) {
    if (list.isEmpty) {
      return true;
    }

    for (var item in list) {
      if (target.contains(item)) {
        return true;
      }
    }
    return false;
  }

  Filter copyWith({
    List<PokemonType>? types,
    List<PokemonType>? weaknesses,
    List<PokemonHeight>? heights,
    List<PokemonWeight>? weights,
    RangeValues? numberRange,
    GenerationOptions? generation,
  }) {
    return Filter(
      types: types ?? this.types,
      weaknesses: weaknesses ?? this.weaknesses,
      heights: heights ?? this.heights,
      weights: weights ?? this.weights,
      numberRange: numberRange ?? this.numberRange,
      generation: generation ?? this.generation,
    );
  }
}
