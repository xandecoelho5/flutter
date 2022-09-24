part of 'pokemon_bloc.dart';

abstract class PokemonEvent {}

class GetByNamePokemonEvent implements PokemonEvent {
  final String name;

  GetByNamePokemonEvent(this.name);
}

class GetAllPokemonEvent implements PokemonEvent {
  final PokemonResponseEntity responseEntity;

  GetAllPokemonEvent(this.responseEntity);
}
