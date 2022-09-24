import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex/src/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:pokedex/src/features/pokemon/domain/entities/pokemon_response_entity.dart';
import 'package:pokedex/src/features/pokemon/presenter/blocs/pokemon_bloc.dart';
import 'package:pokedex/src/features/pokemon/presenter/components/pokemon_grid_list.dart';

import '../../../../core/utils/colors.dart';

class PokemonScreen extends StatefulWidget {
  const PokemonScreen({Key? key}) : super(key: key);

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  final List<PokemonEntity> pokemonList = [];
  var pokemonResponseEntity = PokemonResponseEntity(pokemons: []);

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
      actions: [
        IconButton(
          onPressed: () => Modular.get<PokemonBloc>().add(
            GetAllPokemonEvent(pokemonResponseEntity),
          ),
          icon: const Icon(Icons.not_started, color: kPrimaryColor),
        ),
      ],
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
              child: Text(
                'All Pokemons',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Favourites',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 4),
                  CircleAvatar(
                    radius: 13,
                    backgroundColor: kPrimaryColor,
                    child: Text(
                      '1',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
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
                return const Center(child: CircularProgressIndicator());
              }

              if (state is SuccessPokemonState) {
                for (final pokemon in state.pokemons) {
                  if (!pokemonList.contains(pokemon)) {
                    pokemonList.add(pokemon);
                  }
                }

                if (state.responseEntity?.next != null) {
                  pokemonResponseEntity = state.responseEntity!;
                }

                return PokemonGridList(pokemons: pokemonList);
              }

              return const Center(child: Text('Error'));
            }),
        const Center(child: Text('Favourites')),
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
