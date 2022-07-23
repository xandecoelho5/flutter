import 'package:flutter/material.dart';
import 'package:pokedex/models/i_filterable.dart';
import 'package:pokedex/utils/constants.dart';

enum PokemonWeight implements IFilterable {
  light(kWeightLight),
  normal(kWeightNormal),
  heavy(kWeightHeavy);

  const PokemonWeight(this.color);

  @override
  final Color color;

  @override
  String get fileName => name;

  @override
  String get assetsFolder => 'weights';
}
