import 'package:pokedex/src/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:pokedex/src/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/src/features/pokemon/infra/adapters/pokemon_entity_adapter.dart';
import 'package:pokedex/src/features/pokemon/infra/datasources/pokemon_remote_datasource.dart';

import '../../domain/entities/pokemon_response_entity.dart';
import '../datasources/pokemon_local_datasource.dart';

class PokemonRepository implements IPokemonRepository {
  final IPokemonRemoteDataSource remoteDatasource;
  final IPokemonLocalDatasource localDatasource;

  PokemonRepository(this.remoteDatasource, this.localDatasource);

  @override
  Future<PokemonResponseEntity> getAllPokemons([String? url]) async {
    final responseModel = await remoteDatasource.getAllPokemons(url);
    return PokemonResponseEntity(
      next: responseModel.next,
      pokemons: responseModel.results,
    );
  }

  @override
  Future<PokemonEntity> getPokemonByName(String name) async {
    final map = await remoteDatasource.getPokemonByName(name);
    return PokemonEntityAdapter.fromMap(map);
  }

  @override
  Future<void> addFavouritePokemon(PokemonEntity pokemon) async {
    await localDatasource.addFavouritePokemon(pokemon);
  }

  @override
  Future<void> removeFavouritePokemon(PokemonEntity pokemon) async {
    await localDatasource.removeFavouritePokemon(pokemon);
  }

  @override
  Future<Stream<List<PokemonEntity>>> getFavouritesPokemons() async {
    final stream = localDatasource.getFavouritesPokemon();
    return stream;
  }
}
