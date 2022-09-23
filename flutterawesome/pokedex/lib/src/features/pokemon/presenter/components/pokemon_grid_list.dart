import 'package:flutter/material.dart';
import 'package:pokedex/src/features/pokemon/presenter/components/pokemon_card.dart';

import '../../../../core/utils/dimensions.dart';
import '../../domain/entities/pokemon_entity.dart';

class PokemonGridList extends StatelessWidget {
  const PokemonGridList({Key? key, required this.pokemons}) : super(key: key);

  final List<PokemonEntity> pokemons;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: pokemons.length,
      padding: const EdgeInsets.symmetric(
        horizontal: kGridVerPadding,
        vertical: kGridVerPadding,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 12,
        childAspectRatio: 0.575,
      ),
      itemBuilder: (ctx, index) => PokemonCard(pokemon: pokemons[index]),
    );
  }
}
