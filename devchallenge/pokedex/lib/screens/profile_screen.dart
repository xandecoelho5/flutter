import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/pokemon_types.dart';
import 'package:pokedex/utils/constants.dart';
import 'package:pokedex/utils/measure_converter.dart';

import '../components/badge.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.pokemon}) : super(key: key);

  final Pokemon pokemon;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late double _deviceWidth;
  late double _deviceHeight;

  _profileHeader() {
    _info() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '#${widget.pokemon.pokedexNumber.toString().padLeft(3, '0')}',
            style: TextStyle(
              color: kTextNumberDarker,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          Text(
            widget.pokemon.name,
            style: const TextStyle(
              color: kTextWhite,
              fontWeight: FontWeight.w700,
              fontSize: 32,
            ),
          ),
          Row(
            children: widget.pokemon.types.map((type) => Badge(type)).toList(),
          ),
        ],
      );
    }

    _image() {
      return Image.network(
        widget.pokemon.imageUrl,
        fit: BoxFit.cover,
        // height: _deviceHeight * 0.2,
        height: 125,
        width: 125,
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _image(),
        const SizedBox(width: 10),
        _info(),
      ],
    );
  }

  _profileBars() {
    const textStyle = TextStyle(
      color: kTextWhite,
      fontWeight: FontWeight.w700,
      fontSize: 16,
    );

    return const TabBar(
      tabs: [
        Tab(child: Text('About', style: textStyle)),
        Tab(child: Text('Stats', style: textStyle)),
        Tab(child: Text('Evolution', style: textStyle)),
      ],
    );
  }

  _profileBody() {
    const contentStyle = TextStyle(color: kTextGrey, fontSize: 16);
    final miniSpacer = _deviceHeight * 0.01;
    final spacer = _deviceHeight * 0.02;
    final titleSpacer = _deviceHeight * 0.02;

    _container(child) {
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: _deviceWidth * 0.1,
            vertical: _deviceHeight * 0.05,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            color: kBackgroundColor,
          ),
          child: child,
        ),
      );
    }

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

    _contentText(content) {
      return Text('$content', style: contentStyle);
    }

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

    _aboutTabContent() {
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
                        style: contentStyle,
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
                  const Text(',', style: contentStyle),
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

    _statsTabContent() {
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
                  style: contentStyle,
                  textAlign: TextAlign.end,
                ),
              ),
              SizedBox(width: _deviceWidth * 0.02),
              Expanded(flex: 5, child: _bar()),
              SizedBox(width: _deviceWidth * 0.02),
              Expanded(
                child: Text(
                  '$min',
                  style: contentStyle,
                  textAlign: TextAlign.end,
                ),
              ),
              SizedBox(width: _deviceWidth * 0.02),
              Expanded(
                child: Text(
                  '$max',
                  style: contentStyle,
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
          // return GridView.count(
          //   crossAxisSpacing: 3,
          //   mainAxisSpacing: 10,
          //   crossAxisCount: 9,
          //   childAspectRatio: 0.75,
          //   children: [
          //     ...PokemonTypes.values.map((type) {
          //       return Column(
          //         children: [
          //           Badge(type, onlyIcon: true),
          //           const SizedBox(height: 3),
          //           const Text('2', style: contentStyle),
          //         ],
          //       );
          //     }).toList(),
          //   ],
          // );

          return GridView.builder(
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
                  const SizedBox(height: 3),
                  const Text('2', style: contentStyle),
                ],
              );
            },
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

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _baseStats(),
          _typeDefenses(),
        ],
      );
    }

    return Expanded(
      child: TabBarView(
        children: [
          _container(_aboutTabContent()),
          _container(_statsTabContent()),
          _container(Text('Evolution')),
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: _appBar(),
        backgroundColor: widget.pokemon.types.first.backgroundColor,
        body: Column(
          children: [
            _profileHeader(),
            _profileBars(),
            _profileBody(),
          ],
        ),
      ),
    );
  }
}
