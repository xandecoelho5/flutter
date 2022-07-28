import 'package:flutter/material.dart';
import 'package:pokedex/models/i_filterable.dart';
import 'package:pokedex/utils/constants.dart';

enum PokemonWeight implements IFilterable {
  light(kWeightLight, 44.5),
  normal(kWeightNormal, 225.0),
  heavy(kWeightHeavy, 999.9);

  const PokemonWeight(this.color, this.maxWeight);

  @override
  final Color color;
  final double maxWeight;

  @override
  String get fileName => name;

  @override
  String get assetsFolder => 'weights';

  static PokemonWeight getByWeight(double weight) {
    for (var lbs in values) {
      if (weight <= lbs.maxWeight) {
        return lbs;
      }
    }
    return heavy;
  }
}
