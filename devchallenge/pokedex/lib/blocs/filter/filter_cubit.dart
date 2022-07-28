import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/models/filter/filter.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/sort/sort.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterInitial());

  void executeFiltering(List<Pokemon> pokemons, Filter filter, Sort sort) {
    emit(FilterLoading());
    if (filter.hasAnyFilter) {
      pokemons = filter.doFilter(pokemons);
    }
    sort.doSort(pokemons);
    emit(FilterComplete(pokemons));
  }

  void executeSorting(List<Pokemon> pokemons, Sort sort) {
    emit(FilterLoading());
    sort.doSort(pokemons);
    emit(FilterComplete(pokemons));
  }
}
