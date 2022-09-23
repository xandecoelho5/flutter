part of 'pokemon_bloc.dart';

abstract class PokemonState {}

class InitialPokemonState implements PokemonState {}

class LoadingPokemonState implements PokemonState {}

class SuccessPokemonState implements PokemonState {
  final List<PokemonEntity> pokemons;

  SuccessPokemonState(this.pokemons);
}

class ErrorPokemonState implements PokemonState {
  final String message;

  ErrorPokemonState(this.message);
}
