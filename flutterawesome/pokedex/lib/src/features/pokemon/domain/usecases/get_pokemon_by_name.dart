import 'package:pokedex/src/features/pokemon/domain/entities/pokemon_entity.dart';

import '../repositories/pokemon_repository.dart';

abstract class IGetPokemonByName {
  Future<PokemonEntity> call(String name);
}

class GetPokemonByName implements IGetPokemonByName {
  final IPokemonRepository repository;

  GetPokemonByName(this.repository);

  @override
  Future<PokemonEntity> call(String name) async {
    return await repository.getPokemonByName(name);
  }
}
