part of 'favourite_bloc.dart';

abstract class FavouriteEvent {}

class FetchFavouritesEvent implements FavouriteEvent {}

class AddFavouriteEvent implements FavouriteEvent {
  final PokemonEntity pokemon;

  AddFavouriteEvent(this.pokemon);
}

class RemoveFavouriteEvent implements FavouriteEvent {
  final PokemonEntity pokemon;

  RemoveFavouriteEvent(this.pokemon);
}
