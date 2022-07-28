import 'package:pokedex/models/sort/sort_options.dart';

import '../pokemon.dart';

class Sort {
  final SortOptions sortBy;

  const Sort({
    this.sortBy = SortOptions.smallestNumber,
  });

  List<Pokemon> doSort(List<Pokemon> pokemons) {
    switch (sortBy) {
      case SortOptions.smallestNumber:
        pokemons.sort((a, b) => a.pokedexNumber.compareTo(b.pokedexNumber));
        break;
      case SortOptions.highestNumber:
        pokemons.sort((a, b) => b.pokedexNumber.compareTo(a.pokedexNumber));
        break;
      case SortOptions.aZ:
        pokemons.sort((a, b) => a.name.compareTo(b.name));
        break;
      case SortOptions.zA:
        pokemons.sort((a, b) => b.name.compareTo(a.name));
        break;
    }
    return pokemons;
  }

  Sort copyWith({SortOptions? sortBy}) {
    return Sort(sortBy: sortBy ?? this.sortBy);
  }
}
