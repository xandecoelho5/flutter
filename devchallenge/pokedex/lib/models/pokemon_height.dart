import 'package:flutter/material.dart';
import 'package:pokedex/utils/constants.dart';

import 'i_filterable.dart';

enum PokemonHeight implements IFilterable {
  short(kHeightShort, 1.2),
  medium(kHeightMedium, 2.1),
  tall(kHeightTall, 14.5);

  const PokemonHeight(this.color, this.maxHeight);

  @override
  final Color color;
  final double maxHeight;

  @override
  String get fileName => name;

  @override
  String get assetsFolder => 'heights';

  static PokemonHeight getByHeight(double height) {
    for (var m in values) {
      if (height <= m.maxHeight) {
        return m;
      }
    }
    return tall;
  }
}
