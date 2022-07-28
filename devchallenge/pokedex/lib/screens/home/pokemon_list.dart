import 'package:flutter/material.dart';
import 'package:pokedex/screens/home/pokemon_card.dart';
import 'package:pokedex/utils/constants.dart';

import '../../models/pokemon.dart';

class PokemonListComponent extends StatelessWidget {
  const PokemonListComponent({Key? key, required this.pokemons})
      : super(key: key);

  final List<Pokemon> pokemons;

  @override
  Widget build(BuildContext context) {
    if (pokemons.isNotEmpty) {
      return Expanded(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(
            vertical: kMediumPadding,
            horizontal: kLargePadding,
          ),
          itemCount: pokemons.length,
          itemBuilder: (context, index) => PokemonCardComponent(
            pokemon: pokemons[index],
          ),
          separatorBuilder: (_, __) => SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
        ),
      );
    }

    return const Center(child: Text("No Data found!"));
  }
}
