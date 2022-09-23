import '../../domain/entities/pokemon_model.dart';

class PokemonModelAdapter {
  PokemonModelAdapter._();

  static PokemonModel fromMap(Map<String, dynamic> map) => PokemonModel(
        name: map["name"],
        url: map["url"],
      );

  static Map<String, dynamic> toMap(PokemonModel model) => {
        "name": model.name,
        "url": model.url,
      };
}
