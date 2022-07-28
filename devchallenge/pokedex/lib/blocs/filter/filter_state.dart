part of 'filter_cubit.dart';

abstract class FilterState {}

class FilterInitial extends FilterState {}

class FilterLoading extends FilterState {}

class FilterComplete extends FilterState {
  final List<Pokemon> pokemons;

  FilterComplete(this.pokemons);
}
