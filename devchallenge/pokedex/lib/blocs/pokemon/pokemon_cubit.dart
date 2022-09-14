import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/pokemon.dart';
import '../../services/http/i_http_service.dart';

part 'pokemon_state.dart';

const baseUrl = 'https://pokeapi.co/api/v2';

class PokemonCubit extends Cubit<PokemonState> {
  final IHttpService _httpService;

  PokemonCubit(this._httpService) : super(PokemonInitial());

  void loadInitialPokemons() async {
    emit(PokemonLoading());
    try {
      final pokemons = await _httpService.get('$baseUrl/pokemon?limit=10');
      print(pokemons);
      // emit(PokemonComplete(pokemons));
    } catch (e) {
      emit(PokemonFailure(e.toString()));
    }
  }

  void loadMorePokemons(offset) async {
    const limit = 20;

    emit(PokemonMoreLoading());
    try {
      final pokemons = await _httpService.get(
        '$baseUrl/pokemon?offset=$offset&limit=$limit',
      );
      print(pokemons);
      emit(PokemonMoreComplete(pokemons, offset + limit));
    } catch (e) {
      emit(PokemonFailure(e.toString()));
    }
  }
}
