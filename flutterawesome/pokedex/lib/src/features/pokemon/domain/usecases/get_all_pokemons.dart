import '../entities/pokemon_entity.dart';
import '../repositories/pokemon_repository.dart';

abstract class IGetAllPokemons {
  Future<List<PokemonEntity>> call();
}

class GetAllPokemons implements IGetAllPokemons {
  final IPokemonRepository repository;

  GetAllPokemons(this.repository);

  @override
  Future<List<PokemonEntity>> call() async {
    return await repository.getAllPokemons();
  }
}
