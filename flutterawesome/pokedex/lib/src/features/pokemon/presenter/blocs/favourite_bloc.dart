import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/pokemon_entity.dart';
import '../../domain/usecases/add_favourite_pokemon.dart';
import '../../domain/usecases/get_favourite_pokemons.dart';
import '../../domain/usecases/remove_favourite_pokemon.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final IAddFavouritePokemon addFavouritePokemon;
  final IRemoveFavouritePokemon removeFavouritePokemon;
  final IGetFavouritesPokemons getFavouritesPokemons;

  FavouriteBloc(
    this.addFavouritePokemon,
    this.removeFavouritePokemon,
    this.getFavouritesPokemons,
  ) : super(InitialFavouriteState()) {
    on<AddFavouriteEvent>(_onAddFavouriteEvent);
    on<RemoveFavouriteEvent>(_onRemoveFavouritePokemon);
    on<FetchFavouritesEvent>(_onFetchFavouritesEvent);
  }

  void _onAddFavouriteEvent(AddFavouriteEvent event, emit) async {
    await addFavouritePokemon(event.pokemon);
  }

  void _onRemoveFavouritePokemon(RemoveFavouriteEvent event, emit) async {
    await removeFavouritePokemon(event.pokemon);
  }

  void _onFetchFavouritesEvent(FetchFavouritesEvent event, Emitter emit) async {
    emit(LoadingFavouriteState());

    await emit.onEach<List<PokemonEntity>>(
      await getFavouritesPokemons.call(),
      onData: (data) => emit(SuccessFavouriteState(data)),
      onError: (error, st) => emit(ErrorFavouriteState(error.toString())),
    );
  }
}
