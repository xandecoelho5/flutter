import 'package:pokedex/src/features/pokemon/domain/entities/pokemon_model.dart';
import 'package:pokedex/src/features/pokemon/infra/adapters/pokemon_model_adapter.dart';

import '../../domain/entities/pokemon_response_entity.dart';

class PokemonResponseModel extends PokemonResponseEntity {
  final int count;
  final String? previous;
  final List<PokemonModel> results;

  PokemonResponseModel({
    required this.count,
    next,
    this.previous,
    required this.results,
  }) : super(next: next, pokemons: results);

  factory PokemonResponseModel.fromMap(Map map) => PokemonResponseModel(
        count: map["count"],
        next: map["next"],
        previous: map["previous"],
        results: (map["results"] as List)
            .map((e) => PokemonModelAdapter.fromMap(e))
            .toList(),
      );
}
