part of 'favourite_bloc.dart';

abstract class FavouriteState {}

class InitialFavouriteState implements FavouriteState {}

class LoadingFavouriteState implements FavouriteState {}

class SuccessFavouriteState implements FavouriteState {
  final List<PokemonEntity> pokemons;

  SuccessFavouriteState(this.pokemons);
}

class ErrorFavouriteState implements FavouriteState {
  final String message;

  ErrorFavouriteState(this.message);
}
