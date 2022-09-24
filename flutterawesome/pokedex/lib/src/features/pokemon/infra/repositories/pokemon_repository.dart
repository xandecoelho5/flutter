import 'package:pokedex/src/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:pokedex/src/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/src/features/pokemon/infra/adapters/pokemon_entity_adapter.dart';
import 'package:pokedex/src/features/pokemon/infra/datasources/pokemon_datasource.dart';

import '../../domain/entities/pokemon_response_entity.dart';

class PokemonRepository implements IPokemonRepository {
  final IPokemonDatasource datasource;

  PokemonRepository(this.datasource);

  @override
  Future<PokemonResponseEntity> getAllPokemons([String? url]) async {
    final responseModel = await datasource.getAllPokemons(url);
    return PokemonResponseEntity(
      next: responseModel.next,
      pokemons: responseModel.results,
    );
  }

  @override
  Future<PokemonEntity> getPokemonByName(String name) async {
    final map = await datasource.getPokemonByName(name);
    return PokemonEntityAdapter.fromMap(map);
  }
}
