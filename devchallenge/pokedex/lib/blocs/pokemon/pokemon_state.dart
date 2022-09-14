part of 'pokemon_cubit.dart';

abstract class PokemonState {}

class PokemonInitial extends PokemonState {}

class PokemonLoading extends PokemonState {}

class PokemonMoreLoading extends PokemonState {}

class PokemonComplete extends PokemonState {
  final List<Pokemon> pokemons;

  PokemonComplete(this.pokemons);
}

class PokemonMoreComplete extends PokemonState {
  final List<Pokemon> pokemons;
  final int offset;

  PokemonMoreComplete(this.pokemons, this.offset);
}

class PokemonFailure extends PokemonState {
  final String message;

  PokemonFailure(this.message);
}
