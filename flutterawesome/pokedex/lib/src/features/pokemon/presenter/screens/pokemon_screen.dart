import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex/src/features/pokemon/presenter/blocs/favourite_bloc.dart';
import 'package:pokedex/src/features/pokemon/presenter/components/pokemon_grid_list.dart';

import '../../../../core/utils/colors.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../../domain/entities/pokemon_response_entity.dart';
import '../blocs/pokemon_bloc.dart';

class PokemonScreen extends StatefulWidget {
  const PokemonScreen({Key? key}) : super(key: key);

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> with CompleteStateMixin {
  final List<PokemonEntity> pokemonList = [];
  var responseEntity = const PokemonResponseEntity(pokemons: []);
  final EasyRefreshController _controller = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  onLoadPokemons() async {
    Modular.get<PokemonBloc>().add(GetAllPokemonEvent(responseEntity));
  }

  @override
  void initState() {
    super.initState();
    onLoadPokemons();
  }

  @override
  void completeState() {
    Modular.get<FavouriteBloc>().add(FetchFavouritesEvent());
    Modular.get<FavouriteBloc>().add(GetAllFavouritesEvent());
  }

  AppBar appBarTitle() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/icons/pokeball.png', width: 30),
          const SizedBox(width: 10),
          const Text(
            'Pokedex',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: kTextColor,
            ),
          ),
        ],
      ),
      elevation: 1,
      backgroundColor: Colors.white,
    );
  }

  AppBar appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(-4),
        child: TabBar(
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(color: kPrimaryColor, width: 4),
          ),
          indicatorColor: kPrimaryColor,
          indicatorWeight: 4,
          labelColor: kTextColor,
          unselectedLabelColor: kUnselectedTabColor,
          tabs: [
            const Tab(
              child: Text('All Pokemons', style: TextStyle(fontSize: 16)),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Favourites',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 4),
                  BlocBuilder<FavouriteBloc, FavouriteState>(
                    bloc: Modular.get<FavouriteBloc>(),
                    builder: (context, state) {
                      if (state is SuccessFavouriteState) {
                        if (state.pokemons.isNotEmpty) {
                          return CircleAvatar(
                            radius: 13,
                            backgroundColor: kPrimaryColor,
                            child: Text(
                              '${state.pokemons.length}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }
                        return Container();
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TabBarView tabBarView() {
    return TabBarView(
      children: [
        BlocBuilder<PokemonBloc, PokemonState>(
          bloc: Modular.get<PokemonBloc>(),
          builder: (context, state) {
            if (state is InitialPokemonState) {
              return const Center(child: Text('No Data fetched yet'));
            }

            if (state is LoadingPokemonState) {
              if (pokemonList.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
            }

            if (state is ErrorPokemonState) {
              return const Center(child: Text('Error'));
            }

            if (state is SuccessPokemonState) {
              // state.pokemons.forEach((e) => print(e.isFavourite));
              for (final pokemon in state.pokemons) {
                if (!pokemonList.contains(pokemon)) {
                  pokemonList.add(pokemon);
                }
              }

              if (state.responseEntity?.next != null) {
                if (mounted) {
                  _controller.finishLoad(
                    state.responseEntity?.next == null
                        ? IndicatorResult.noMore
                        : IndicatorResult.success,
                  );
                }
                responseEntity = state.responseEntity!;
              } else {
                if (mounted) _controller.finishLoad(IndicatorResult.success);
              }
            }

            return EasyRefresh(
              controller: _controller,
              onLoad: onLoadPokemons,
              footer: const ClassicFooter(
                readyText: 'Fetching...',
                noMoreText: 'No more pokemons',
                processingText: 'Fetching...',
                messageText: 'Last fetch at %T',
              ),
              child: PokemonGridList(pokemons: pokemonList),
            );
          },
        ),
        BlocBuilder(
          bloc: Modular.get<FavouriteBloc>(),
          builder: (context, state) {
            if (state is ErrorFavouriteState) {
              return const Center(child: Text('Error'));
            }

            if (state is SuccessFavouriteState) {
              if (state.pokemons.isEmpty) {
                return const Center(child: Text('No favourites yet'));
              }
              return PokemonGridList(pokemons: state.pokemons);
            }

            return const Center(child: Text('No favourites yet'));
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarTitle(),
      body: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: appBar(),
          body: tabBarView(),
          backgroundColor: kBackgroundColor,
        ),
      ),
    );
  }
}

mixin CompleteStateMixin<T extends StatefulWidget> on State<T> {
  void completeState();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      completeState();
    });
  }
}
