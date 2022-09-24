import '../../domain/entities/pokemon_model.dart';

class PokemonModelAdapter {
  PokemonModelAdapter._();

  static PokemonModel fromMap(Map map) => PokemonModel(
        name: map["name"],
        url: map["url"],
      );
}
