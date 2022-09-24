import 'package:pokedex/src/features/pokemon/domain/entities/pokemon_entity.dart';

import '../repositories/pokemon_repository.dart';

abstract class IRemoveFavouritePokemon {
  Future<void> call(PokemonEntity pokemon);
}

class RemoveFavouritePokemon implements IRemoveFavouritePokemon {
  final IPokemonRepository repository;

  RemoveFavouritePokemon(this.repository);

  @override
  Future<void> call(PokemonEntity pokemon) async {
    await repository.removeFavouritePokemon(pokemon);
  }
}
