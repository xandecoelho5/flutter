import '../entities/pokemon_entity.dart';
import '../repositories/pokemon_repository.dart';

abstract class IGetAllFavouritesPokemon {
  Future<List<PokemonEntity>> call();
}

class GetAllFavouritesPokemon implements IGetAllFavouritesPokemon {
  final IPokemonRepository repository;

  GetAllFavouritesPokemon(this.repository);

  @override
  Future<List<PokemonEntity>> call() async {
    return await repository.getAllFavouritesPokemon();
  }
}
