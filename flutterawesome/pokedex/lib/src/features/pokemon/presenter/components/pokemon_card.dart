import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex/src/core/utils/types.dart';
import 'package:pokedex/src/features/pokemon/domain/entities/pokemon_entity.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/utils.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({Key? key, required this.pokemon}) : super(key: key);

  final PokemonEntity pokemon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Modular.to.pushNamed('/pokemon/details', arguments: pokemon),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: Container(
                height: 104,
                width: double.infinity,
                color: PokemonType.getColorByName(pokemon.types.first)
                    .withOpacity(0.15),
                child: Image.network(
                  pokemon.imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '#${pokemon.id.toString().padLeft(3, '0')}',
                style: const TextStyle(
                  color: kUnselectedTabColor,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: FittedBox(
                child: Text(
                  Utils.capitalize(pokemon.name),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: FittedBox(
                child: Text(
                  pokemon.types.join(','),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: kUnselectedTabColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
