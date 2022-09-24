import 'package:pokedex/src/core/utils/utils.dart';
import 'package:pokedex/src/features/pokemon/domain/value_objects/base_stats.dart';

import '../../domain/entities/pokemon_entity.dart';

class PokemonEntityAdapter {
  PokemonEntityAdapter._();

  static PokemonEntity fromMap(Map map) {
    return PokemonEntity(
      id: map['id'],
      name: map['name'],
      height: map['height'],
      weight: map['weight'],
      types: _getTypes(map),
      baseStats: _getBaseStats(map),
      imageUrl: _getImageUrl(map),
    );
  }

  static String _getImageUrl(Map map) {
    return map['sprites']['other']['official-artwork']['front_default'];
  }

  static BaseStats _getBaseStats(Map map) {
    var baseStats = BaseStats(
      hp: Hp(map['stats'][0]['base_stat']),
      attack: Attack(map['stats'][1]['base_stat']),
      defense: Defense(map['stats'][2]['base_stat']),
      specialAttack: SpecialAttack(map['stats'][3]['base_stat']),
      specialDefense: SpecialDefense(map['stats'][4]['base_stat']),
      speed: Speed(map['stats'][5]['base_stat']),
    );
    return baseStats;
  }

  static List<dynamic> _getTypes(Map map) {
    return map['types']
        .map((e) => Utils.capitalize(e['type']['name']))
        .toList();
  }
}
