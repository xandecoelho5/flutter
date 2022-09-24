import '../entities/pokemon_entity.dart';
import '../repositories/pokemon_repository.dart';

abstract class IGetFavouritesPokemons {
  Future<Stream<List<PokemonEntity>>> call();
}

class GetFavouritesPokemons implements IGetFavouritesPokemons {
  final IPokemonRepository repository;

  GetFavouritesPokemons(this.repository);

  @override
  Future<Stream<List<PokemonEntity>>> call() async {
    return await repository.getFavouritesPokemons();
  }
}
