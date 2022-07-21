import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';

import '../../../components/badge.dart';
import '../../../models/pokemon_types.dart';
import '../../../utils/constants.dart';

class ProfileStatsComponent extends StatefulWidget {
  const ProfileStatsComponent({Key? key, required this.pokemon})
      : super(key: key);

  final Pokemon pokemon;

  @override
  State<ProfileStatsComponent> createState() => _ProfileStatsComponentState();
}

class _ProfileStatsComponentState extends State<ProfileStatsComponent> {
  late double _deviceWidth;
  late double _deviceHeight;
  late double miniSpacer;
  late double spacer;
  late double titleSpacer;

  _sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: widget.pokemon.types.first.foregroundColor,
        fontWeight: FontWeight.w700,
        fontSize: 16,
      ),
    );
  }

  _baseStats() {
    _statsRow(String stats, int base, int min, int max) {
      _bar() {
        return Stack(
          children: [
            Container(
              height: 4,
              color: Colors.white,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 4,
              width: 140 * (base / ((max + min) / 2)),
              decoration: BoxDecoration(
                color: widget.pokemon.types.first.foregroundColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        );
      }

      return Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              stats,
              style: const TextStyle(
                color: kTextBlack,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              '$base',
              style: kContentStyle,
              textAlign: TextAlign.end,
            ),
          ),
          SizedBox(width: _deviceWidth * 0.02),
          Expanded(flex: 5, child: _bar()),
          SizedBox(width: _deviceWidth * 0.02),
          Expanded(
            child: Text(
              '$min',
              style: kContentStyle,
              textAlign: TextAlign.end,
            ),
          ),
          SizedBox(width: _deviceWidth * 0.02),
          Expanded(
            child: Text(
              '$max',
              style: kContentStyle,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      );
    }

    _totalRow() {
      _bar() {
        return Container(
          height: 4,
          color: Colors.white,
        );
      }

      return Row(
        children: [
          const Expanded(
            flex: 2,
            child: Text(
              'Total',
              style: TextStyle(
                color: kTextBlack,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              '${widget.pokemon.totalStats}',
              style: const TextStyle(
                color: kTextGrey,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.end,
            ),
          ),
          SizedBox(width: _deviceWidth * 0.02),
          Expanded(flex: 5, child: _bar()),
          SizedBox(width: _deviceWidth * 0.02),
          const Expanded(
            child: Text(
              'Min',
              style: TextStyle(
                color: kTextBlack,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
              textAlign: TextAlign.end,
            ),
          ),
          SizedBox(width: _deviceWidth * 0.02),
          const Expanded(
            child: Text(
              'Max',
              style: TextStyle(
                color: kTextBlack,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Base Stats'),
        SizedBox(height: titleSpacer),
        _statsRow(
          'HP',
          widget.pokemon.hp,
          widget.pokemon.minHp,
          widget.pokemon.maxHp,
        ),
        SizedBox(height: miniSpacer),
        _statsRow(
          'Attack',
          widget.pokemon.attack,
          widget.pokemon.minAttack,
          widget.pokemon.maxAttack,
        ),
        SizedBox(height: miniSpacer),
        _statsRow(
          'Defense',
          widget.pokemon.defense,
          widget.pokemon.minDefense,
          widget.pokemon.maxDefense,
        ),
        SizedBox(height: miniSpacer),
        _statsRow(
          'Sp. Atk',
          widget.pokemon.specialAttack,
          widget.pokemon.minSpecialAttack,
          widget.pokemon.maxSpecialAttack,
        ),
        SizedBox(height: miniSpacer),
        _statsRow(
          'Sp. Def',
          widget.pokemon.specialDefense,
          widget.pokemon.minSpecialDefense,
          widget.pokemon.maxSpecialDefense,
        ),
        SizedBox(height: miniSpacer),
        _statsRow(
          'Speed',
          widget.pokemon.speed,
          widget.pokemon.minSpeed,
          widget.pokemon.maxSpeed,
        ),
        SizedBox(height: miniSpacer),
        _totalRow(),
        SizedBox(height: spacer),
        const Text(
          'The ranges shown on the right are for a level 100 Pokémon. Maximum values are based on a beneficial nature, 252 EVs, 31 IVs; minimum values are based on a hindering nature, 0 EVs, 0 IVs.',
          style: TextStyle(
            color: kTextGrey,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: spacer),
      ],
    );
  }

  _typeDefenses() {
    _typeDefenseRow() {
      String _textByEffectiveness(double value) {
        if (value == 0.5) return '½';
        if (value == 0.25) return '¼';
        if (value == 2.0 || value == 4.0) {
          return value.toStringAsFixed(0);
        }
        return '';
      }

      return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 9,
            mainAxisExtent: 60,
            crossAxisSpacing: _deviceWidth * 0.02,
          ),
          itemCount: PokemonTypes.values.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final type = PokemonTypes.values[index];
            return Column(
              children: [
                Badge(type, onlyIcon: true, margin: 0),
                const SizedBox(height: 5),
                Text(
                  _textByEffectiveness(
                    PokemonTypes.getEffectiveness(widget.pokemon.types, type),
                  ),
                  style: kContentStyle,
                ),
              ],
            );
          },
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Type Defenses'),
        SizedBox(height: spacer),
        Text(
          'The effectiveness of each type on ${widget.pokemon.name}.',
          style: const TextStyle(
            color: kTextGrey,
            fontSize: 16,
          ),
        ),
        SizedBox(height: spacer),
        _typeDefenseRow(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    miniSpacer = _deviceHeight * 0.01;
    spacer = _deviceHeight * 0.02;
    titleSpacer = _deviceHeight * 0.02;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _baseStats(),
        _typeDefenses(),
      ],
    );
  }
}
