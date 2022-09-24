import '../entities/pokemon_entity.dart';
import '../entities/pokemon_response_entity.dart';

abstract class IPokemonRepository {
  Future<PokemonEntity> getPokemonByName(String name);
  Future<PokemonResponseEntity> getAllPokemons([String? url]);
}
