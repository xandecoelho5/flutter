import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex/src/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/src/features/pokemon/domain/usecases/add_favourite_pokemon.dart';
import 'package:pokedex/src/features/pokemon/domain/usecases/get_all_favourites_pokemon.dart';
import 'package:pokedex/src/features/pokemon/domain/usecases/get_all_pokemons.dart';
import 'package:pokedex/src/features/pokemon/domain/usecases/get_favourites_pokemons.dart';
import 'package:pokedex/src/features/pokemon/domain/usecases/get_pokemon_by_name.dart';
import 'package:pokedex/src/features/pokemon/domain/usecases/remove_favourite_pokemon.dart';
import 'package:pokedex/src/features/pokemon/external/datasources/pokemon_remote_datasource.dart';
import 'package:pokedex/src/features/pokemon/infra/datasources/pokemon_remote_datasource.dart';
import 'package:pokedex/src/features/pokemon/presenter/blocs/favourite_bloc.dart';
import 'package:pokedex/src/features/pokemon/presenter/blocs/pokemon_bloc.dart';
import 'package:pokedex/src/features/pokemon/presenter/screens/pokemon_details_screen.dart';
import 'package:pokedex/src/features/pokemon/presenter/screens/pokemon_screen.dart';

import 'external/datasources/pokemon_hive_datasource.dart';
import 'infra/datasources/pokemon_local_datasource.dart';
import 'infra/repositories/pokemon_repository.dart';

class PokemonModule extends Module {
  @override
  final List<Bind> binds = [
    // datasources
    Bind.singleton<IPokemonRemoteDataSource>(
      (i) => PokemonRemoteDatasource(i()),
    ),
    Bind.singleton<IPokemonLocalDatasource>(
      (i) => PokemonHiveDatasource.getInstance(),
    ),
    // repositories
    Bind.singleton<IPokemonRepository>((i) => PokemonRepository(i(), i())),
    // usecases
    Bind.singleton<IGetAllFavouritesPokemon>(
      (i) => GetAllFavouritesPokemon(i()),
    ),
    Bind.singleton<IAddFavouritePokemon>((i) => AddFavouritePokemon(i())),
    Bind.singleton<IRemoveFavouritePokemon>((i) => RemoveFavouritePokemon(i())),
    Bind.singleton<IGetFavouritesPokemons>((i) => GetFavouritesPokemons(i())),
    Bind.singleton<IGetPokemonByName>((i) => GetPokemonByName(i())),
    Bind.singleton<IGetAllPokemons>((i) => GetAllPokemons(i())),
    // blocs
    Bind.singleton((i) => PokemonBloc(i(), i())),
    Bind.singleton((i) => FavouriteBloc(i(), i(), i(), i())),
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
