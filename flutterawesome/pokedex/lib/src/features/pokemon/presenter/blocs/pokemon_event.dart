part of 'pokemon_bloc.dart';

abstract class PokemonEvent {}

class GetByIdPokemonEvent implements PokemonEvent {
  final int id;

  GetByIdPokemonEvent(this.id);
}

class GetAllPokemonEvent implements PokemonEvent {}
