import 'package:pokedex/src/features/pokemon/domain/entities/pokemon_entity.dart';

import '../repositories/pokemon_repository.dart';

abstract class IAddFavouritePokemon {
  Future<void> call(PokemonEntity pokemon);
}

class AddFavouritePokemon implements IAddFavouritePokemon {
  final IPokemonRepository repository;

  AddFavouritePokemon(this.repository);

  @override
  Future<void> call(PokemonEntity pokemon) async {
    await repository.addFavouritePokemon(pokemon);
  }
}
