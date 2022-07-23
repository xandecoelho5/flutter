import 'package:flutter/material.dart';
import 'package:pokedex/utils/constants.dart';

import 'i_filterable.dart';

enum PokemonHeight implements IFilterable {
  short(kHeightShort),
  medium(kHeightMedium),
  tall(kHeightTall);

  const PokemonHeight(this.color);

  @override
  final Color color;

  @override
  String get fileName => name;

  @override
  String get assetsFolder => 'heights';
}
