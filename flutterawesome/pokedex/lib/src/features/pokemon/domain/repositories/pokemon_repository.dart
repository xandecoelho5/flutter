import '../entities/pokemon_entity.dart';

abstract class IPokemonRepository {
  Future<PokemonEntity> getPokemonByName(String name);
  Future<List<PokemonEntity>> getAllPokemons();
}
