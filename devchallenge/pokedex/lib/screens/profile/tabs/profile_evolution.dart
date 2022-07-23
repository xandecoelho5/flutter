import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';

import '../../../models/evolution.dart';
import '../../../utils/constants.dart';

class ProfileEvolutionComponent extends StatefulWidget {
  const ProfileEvolutionComponent({Key? key, required this.pokemon})
      : super(key: key);

  final Pokemon pokemon;

  @override
  State<ProfileEvolutionComponent> createState() =>
      _ProfileEvolutionComponentState();
}

class _ProfileEvolutionComponentState extends State<ProfileEvolutionComponent> {
  _evolutionRow(Evolution evolution) {
    _pokemonColumn(int id, String name) {
      _image() {
        return Image.network(
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png',
          fit: BoxFit.cover,
          height: 75,
          width: 75,
        );
      }

      return Column(
        children: [
          _image(),
          Text(
            '#${id.toString().padLeft(3, '0')}',
            style: const TextStyle(
              color: kTextGrey,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
          Text(
            name,
            style: const TextStyle(
              color: kTextBlack,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    _evolutionFactor() {
      return Column(
        children: [
          Icon(Icons.arrow_forward, color: kTextGrey.withOpacity(0.1)),
          Text(
            '(Level ${evolution.level})',
            style: const TextStyle(
              color: kTextBlack,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: _pokemonColumn(
            evolution.basePokemonId,
            evolution.basePokemonName,
          ),
        ),
        Expanded(
          flex: 4,
          child: _evolutionFactor(),
        ),
        Expanded(
          flex: 3,
          child: _pokemonColumn(
            evolution.nextPokemonId,
            evolution.nextPokemonName,
          ),
        ),
      ],
    );
  }

  _evolutionChain() {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: widget.pokemon.evolutions.length,
        itemBuilder: (context, index) {
          final evolution = widget.pokemon.evolutions[index];
          return _evolutionRow(evolution);
        },
        separatorBuilder: (_, __) => const SizedBox(height: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TODO use _sectionTitle
        Text(
          'Evolution Chain',
          style: TextStyle(
            color: widget.pokemon.types.first.color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 30),
        _evolutionChain(),
      ],
    );
  }
}
