import 'package:pokedex/src/features/pokemon/domain/entities/pokemon_entity.dart';

abstract class IPokemonLocalDatasource {
  Future<void> addFavouritePokemon(PokemonEntity pokemon);

  Future<void> removeFavouritePokemon(PokemonEntity pokemon);

  Future<Stream<List<PokemonEntity>>> getFavouritesPokemon();

  List<PokemonEntity> getAll();
}
