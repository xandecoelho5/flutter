import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';

import '../../../components/badge.dart';
import '../../../utils/constants.dart';
import '../../../utils/measure_converter.dart';

class ProfileAboutComponent extends StatefulWidget {
  const ProfileAboutComponent({Key? key, required this.pokemon})
      : super(key: key);

  final Pokemon pokemon;

  @override
  State<ProfileAboutComponent> createState() => _ProfileAboutComponentState();
}

class _ProfileAboutComponentState extends State<ProfileAboutComponent> {
  late double _deviceWidth;
  late double _deviceHeight;
  late double miniSpacer;
  late double spacer;
  late double titleSpacer;

  _contentText(content) => Text('$content', style: kContentStyle);

  _contentRow(String title, Widget value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            title,
            style: const TextStyle(
              color: kTextBlack,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: value,
        ),
      ],
    );
  }

  _sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: widget.pokemon.types.first.color,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }

  _pokedexData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Pokédex Data'),
        SizedBox(height: titleSpacer),
        _contentRow('Species', _contentText(widget.pokemon.species)),
        SizedBox(height: spacer),
        _contentRow(
          'Height',
          Row(
            children: [
              _contentText('${widget.pokemon.height}m'),
              SizedBox(width: _deviceWidth * 0.007),
              Text(
                '(${MeasureConverter.metersToInchs(widget.pokemon.height).toStringAsFixed(2)})',
                style: const TextStyle(color: kTextGrey, fontSize: 12),
              ),
            ],
          ),
        ),
        SizedBox(height: spacer),
        _contentRow(
          'Weight',
          Row(
            children: [
              _contentText('${widget.pokemon.weight}kg'),
              SizedBox(width: _deviceWidth * 0.007),
              Text(
                '(${MeasureConverter.kilogramsToPounds(widget.pokemon.weight).toStringAsFixed(2)} lbs)',
                style: const TextStyle(color: kTextGrey, fontSize: 12),
              ),
            ],
          ),
        ),
        SizedBox(height: spacer),
        _contentRow(
          'Abilities',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.pokemon.abilities.map(
              (ability) {
                if (ability.isHidden) {
                  return Text(
                    '${ability.name} (hidden ability)',
                    style: const TextStyle(color: kTextGrey, fontSize: 12),
                  );
                } else {
                  return Text(
                    '${ability.slot}.${ability.name}',
                    style: kContentStyle,
                  );
                }
              },
            ).toList(),
          ),
        ),
        SizedBox(height: spacer),
        _contentRow(
          'Weaknesses',
          Row(
            children: widget.pokemon.weaknesses
                .map((type) => Badge(type, onlyIcon: true))
                .toList(),
          ),
        ),
        SizedBox(height: titleSpacer),
      ],
    );
  }

  // TODO verify formula for base Friendship category
  _training() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Training'),
        SizedBox(height: titleSpacer),
        _contentRow(
          'EV Yield',
          _contentText(widget.pokemon.evYield),
        ),
        SizedBox(height: spacer),
        _contentRow(
          'Catch Rate',
          _contentText(widget.pokemon.catchRate),
        ),
        SizedBox(height: spacer),
        _contentRow(
          'Base Friendship',
          _contentText('${widget.pokemon.baseFriendship} (normal)'),
        ),
        SizedBox(height: spacer),
        _contentRow(
          'Base Exp',
          _contentText(widget.pokemon.baseExp),
        ),
        SizedBox(height: spacer),
        _contentRow(
          'Growth Rate',
          _contentText(widget.pokemon.growthRate),
        ),
        SizedBox(height: titleSpacer),
      ],
    );
  }

  _breeding() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Breeding'),
        SizedBox(height: titleSpacer),
        _contentRow(
          'Gender',
          Row(
            children: [
              const Icon(Icons.female, color: kTypeFlying, size: 14),
              Text(
                widget.pokemon.gender.split(',')[0],
                style: const TextStyle(color: kTypeFlying, fontSize: 16),
              ),
              const Text(',', style: kContentStyle),
              const Icon(Icons.male, color: kTypeFairy, size: 14),
              Text(
                widget.pokemon.gender.split(',')[1],
                style: const TextStyle(color: kTypeFairy, fontSize: 16),
              ),
            ],
          ),
        ),
        SizedBox(height: spacer),
        _contentRow(
          'Egg Groups',
          _contentText(widget.pokemon.eggGroups),
        ),
        SizedBox(height: spacer),
        _contentRow(
          'Egg Cycles',
          _contentText('${widget.pokemon.eggCycles} (normal)'),
        ),
        SizedBox(height: titleSpacer),
      ],
    );
  }

  _location() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Location'),
        SizedBox(height: titleSpacer),
        ...widget.pokemon.locations
            .map(
              (location) => Column(
                children: [
                  _contentRow(
                    location.id.toString().padLeft(3, '0'),
                    _contentText(location.name),
                  ),
                  SizedBox(height: spacer),
                ],
              ),
            )
            .toList(),
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
      children: [
        Text(
          widget.pokemon.description,
          style: const TextStyle(color: kTextGrey, fontSize: 16),
        ),
        SizedBox(height: _deviceHeight * 0.05),
        _pokedexData(),
        _training(),
        _breeding(),
        _location(),
      ],
    );
  }
}
