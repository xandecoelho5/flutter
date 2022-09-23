import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex/src/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/src/features/pokemon/domain/usecases/get_all_pokemons.dart';
import 'package:pokedex/src/features/pokemon/domain/usecases/get_pokemon_by_name.dart';
import 'package:pokedex/src/features/pokemon/external/datasources/pokemon_datasource.dart';
import 'package:pokedex/src/features/pokemon/infra/datasources/pokemon_datasource.dart';
import 'package:pokedex/src/features/pokemon/presenter/blocs/pokemon_bloc.dart';
import 'package:pokedex/src/features/pokemon/presenter/screens/pokemon_details_screen.dart';
import 'package:pokedex/src/features/pokemon/presenter/screens/pokemon_screen.dart';

import 'infra/repositories/pokemon_repository.dart';

class PokemonModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton<IPokemonDatasource>((i) => PokemonDatasource(i())),
    Bind.singleton<IPokemonRepository>((i) => PokemonRepository(i())),
    Bind.singleton<IGetPokemonByName>((i) => GetPokemonByName(i())),
    Bind.singleton<IGetAllPokemons>((i) => GetAllPokemons(i())),
    Bind.singleton((i) => PokemonBloc(i(), i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const PokemonScreen()),
    ChildRoute(
      '/details',
      child: (_, args) => PokemonDetailsScreen(pokemon: args.data),
    ),
  ];
}
