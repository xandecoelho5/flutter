import '../entities/pokemon_response_entity.dart';
import '../repositories/pokemon_repository.dart';

abstract class IGetAllPokemons {
  Future<PokemonResponseEntity> call([String? url]);
}

class GetAllPokemons implements IGetAllPokemons {
  final IPokemonRepository repository;

  GetAllPokemons(this.repository);

  @override
  Future<PokemonResponseEntity> call([String? url]) async {
    return await repository.getAllPokemons(url);
  }
}
