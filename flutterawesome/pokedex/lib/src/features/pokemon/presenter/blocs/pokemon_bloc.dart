import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/src/features/pokemon/domain/entities/pokemon_response_entity.dart';

import '../../domain/entities/pokemon_entity.dart';
import '../../domain/usecases/get_all_pokemons.dart';
import '../../domain/usecases/get_pokemon_by_name.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final IGetPokemonByName getPokemonByName;
  final IGetAllPokemons getAllPokemons;

  PokemonBloc(
    this.getPokemonByName,
    this.getAllPokemons,
  ) : super(InitialPokemonState()) {
    on<GetByNamePokemonEvent>(_onGetByNamePokemonEvent);
    on<GetAllPokemonEvent>(_onGetAllPokemonEvent);
  }

  void _onGetByNamePokemonEvent(GetByNamePokemonEvent event, emit) async {
    emit(LoadingPokemonState());
    try {
      final pokemon = await getPokemonByName(event.name);
      emit(SuccessPokemonState([pokemon]));
    } catch (e) {
      print(e);
      emit(ErrorPokemonState(e.toString()));
    }
  }

  void _onGetAllPokemonEvent(GetAllPokemonEvent event, emit) async {
    emit(LoadingPokemonState());
    try {
      var responseEntity = event.responseEntity;
      if (event.responseEntity.next == null) {
        responseEntity = await getAllPokemons();
      } else {
        responseEntity = await getAllPokemons(event.responseEntity.next!);
      }

      final pokemons = await Future.wait(
        responseEntity.pokemons.map(
          (pokemon) => getPokemonByName(pokemon.name),
        ),
      );

      emit(SuccessPokemonState(pokemons, responseEntity));
    } catch (e) {
      print(e);
      emit(ErrorPokemonState(e.toString()));
    }
  }
}
