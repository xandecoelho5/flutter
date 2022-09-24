import '../entities/pokemon_entity.dart';
import '../entities/pokemon_response_entity.dart';

abstract class IPokemonRepository {
  Future<PokemonEntity> getPokemonByName(String name);
  Future<PokemonResponseEntity> getAllPokemons([String? url]);
  Future<void> addFavouritePokemon(PokemonEntity pokemon);
  Future<void> removeFavouritePokemon(PokemonEntity pokemon);
  Future<Stream<List<PokemonEntity>>> getFavouritesPokemons();
  Future<List<PokemonEntity>> getAllFavouritesPokemon();
}
