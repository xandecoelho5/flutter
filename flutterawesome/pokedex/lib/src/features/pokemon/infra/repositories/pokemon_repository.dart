import 'package:pokedex/src/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:pokedex/src/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/src/features/pokemon/infra/adapters/pokemon_entity_adapter.dart';
import 'package:pokedex/src/features/pokemon/infra/datasources/pokemon_datasource.dart';

class PokemonRepository implements IPokemonRepository {
  final IPokemonDatasource datasource;

  PokemonRepository(this.datasource);

  @override
  Future<List<PokemonEntity>> getAllPokemons() async {
    final responseModel = await datasource.getAllPokemons();
    return list.map((e) => PokemonEntityAdapter.fromMap(e)).toList();
  }

  @override
  Future<PokemonEntity> getPokemonByName(String name) async {
    final map = await datasource.getPokemonByName(name);
    return PokemonEntityAdapter.fromMap(map);
  }
}
