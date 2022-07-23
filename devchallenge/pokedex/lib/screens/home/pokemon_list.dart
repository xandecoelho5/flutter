import 'package:flutter/material.dart';
import 'package:pokedex/screens/home/pokemon_card.dart';

import '../../utils/mocks.dart';

class PokemonListComponent extends StatelessWidget {
  const PokemonListComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.05,
          horizontal: MediaQuery.of(context).size.width * 0.05,
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
}
