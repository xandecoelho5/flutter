import 'package:pokedex/src/features/pokemon/domain/entities/pokemon_model.dart';

class PokemonResponseEntity {
  final String? next;
  final List<PokemonModel> pokemons;

  const PokemonResponseEntity({this.next, required this.pokemons});
}
