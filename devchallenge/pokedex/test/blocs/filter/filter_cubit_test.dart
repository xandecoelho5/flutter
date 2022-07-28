import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/models/filter/filter.dart';
import 'package:pokedex/models/filter/generations_options.dart';
import 'package:pokedex/models/pokemon_height.dart';
import 'package:pokedex/models/pokemon_type.dart';
import 'package:pokedex/models/pokemon_weight.dart';
import 'package:pokedex/utils/mocks.dart';

void main() {
  test('should verify if a filter don\'t has any filter', () {
    const filter = Filter();

    expect(filter.hasAnyFilter, isFalse);
  });

  test('should verify if a filter has any filter', () {
    const filter = mockFilter;

    expect(filter.hasAnyFilter, isTrue);
  });

  test('should return only bulbasaur', () {
    const filter = Filter(
      types: [PokemonType.grass],
    );

    final filteredPokemons = filter.doFilter(pokemonsMock);

    expect(filteredPokemons.length, equals(1));
    expect(filteredPokemons.first.name, equals('Bulbasaur'));
  });

  test('should return only charmander', () {
    const filter = Filter(
      types: [PokemonType.fire],
      weaknesses: [PokemonType.water],
      heights: [PokemonHeight.short],
      weights: [PokemonWeight.light],
    );

    final filteredPokemons = filter.doFilter(pokemonsMock);

    expect(filteredPokemons.length, equals(1));
    expect(filteredPokemons.first.name, equals('Charmander'));
  });

  test('should return only bulbasaur and charmander', () {
    const filter = Filter(
      numberRange: RangeValues(1, 4),
    );

    final filteredPokemons = filter.doFilter(pokemonsMock);

    expect(filteredPokemons.length, equals(2));
  });

  test('shouldn\'t return any pokemon', () {
    const filter = Filter(
      generation: GenerationOptions.second,
    );

    final filteredPokemons = filter.doFilter(pokemonsMock);

    expect(filteredPokemons, isEmpty);
  });
}
