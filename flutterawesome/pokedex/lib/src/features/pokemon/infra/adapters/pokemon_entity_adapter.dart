import '../../domain/entities/pokemon_entity.dart';

class PokemonEntityAdapter {
  PokemonEntityAdapter._();

  static PokemonEntity fromMap(Map map) {
    return PokemonEntity(
      id: map['id'],
      name: map['name'],
      height: map['height'],
      weight: map['weight'],
      types: map['types'],
      baseStats: map['baseStats'],
      imageUrl: map['imageUrl'],
    );
  }
}
