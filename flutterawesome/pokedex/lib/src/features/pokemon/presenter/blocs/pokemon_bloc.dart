import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/pokemon_entity.dart';
import '../../domain/usecases/get_all_pokemons.dart';
import '../../domain/usecases/get_pokemon_by_name.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final IGetPokemonByName getPokemonById;
  final IGetAllPokemons getAllPokemons;

  PokemonBloc(
    this.getPokemonById,
    this.getAllPokemons,
  ) : super(InitialPokemonState()) {
    on<GetByIdPokemonEvent>(_onGetByIdPokemonEvent);
    on<GetAllPokemonEvent>(_onGetAllPokemonEvent);
  }

  void _onGetByIdPokemonEvent(event, emit) async {
    emit(LoadingPokemonState());
    try {
      final pokemon = await getPokemonById(event.id);
      emit(SuccessPokemonState([pokemon]));
    } catch (e) {
      print(e);
      emit(ErrorPokemonState(e.toString()));
    }
  }

  void _onGetAllPokemonEvent(event, emit) async {
    emit(LoadingPokemonState());
    try {
      final pokemons = await getAllPokemons();
      emit(SuccessPokemonState(pokemons));
    } catch (e) {
      print(e);
      emit(ErrorPokemonState(e.toString()));
    }
  }
}
