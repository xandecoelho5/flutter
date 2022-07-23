import 'package:flutter/material.dart';

import 'i_filterable.dart';

class DamageRelation {
  const DamageRelation(this.type, this.damage);

  final PokemonType type;
  final double damage;
}

enum PokemonType implements IFilterable {
  normal('Normal', Color(0xFF9DA0AA), Color(0xFFB5B9C4)),
  fire('Fire', Color(0xFFFD7D24), Color(0xFFFFA756)),
  water('Water', Color(0xFF4A90DA), Color(0xFF58ABF6)),
  electric('Electric', Color(0xFFEED535), Color(0xFFF2CB55)),
  grass('Grass', Color(0xFF62B957), Color(0xFF8BBE8A)),
  ice('Ice', Color(0xFF61CEC0), Color(0xFF91D8DF)),
  fighting('Fighting', Color(0xFFD04164), Color(0xFFEB4971)),
  poison('Poison', Color(0xFFA552CC), Color(0xFF9F6E97)),
  ground('Ground', Color(0xFFDD7748), Color(0xFFF78551)),
  flying('Flying', Color(0xFF748FC9), Color(0xFF83A2E3)),
  psychic('Psychic', Color(0xFFEA5D60), Color(0xFFFF6568)),
  bug('Bug', Color(0xFF8CB230), Color(0xFF8BD674)),
  rock('Rock', Color(0xFFBAAB82), Color(0xFFD4C294)),
  ghost('Ghost', Color(0xFF556AAE), Color(0xFF8571BE)),
  dragon('Dragon', Color(0xFF0F6AC0), Color(0xFF7383B9)),
  dark('Dark', Color(0xFF58575F), Color(0xFF6F6E78)),
  steel('Steel', Color(0xFF417D9A), Color(0xFF4C91B2)),
  fairy('Fairy', Color(0xFFED6EC7), Color(0xFFEBA8C3));

  const PokemonType(this.type, this.color, this.backgroundColor);

  final String type;
  @override
  final Color color;
  final Color backgroundColor;

  @override
  String get fileName => name;

  @override
  String get assetsFolder => 'types';

  static double getEffectiveness(
    List<PokemonType> types,
    PokemonType attackingType,
  ) {
    double effectiveness = 1.0;
    final damageRelations = _getDamageRelations(attackingType);
    for (var type in types) {
      for (var damageRelation in damageRelations) {
        if (damageRelation.type == type) {
          effectiveness *= damageRelation.damage;
        }
      }
    }

    return effectiveness;
  }

  static List<DamageRelation> _getDamageRelations(PokemonType type) {
    const halfDamage = 0.5;
    const doubleDamage = 2.0;
    const noDamage = 0.0;

    switch (type) {
      case PokemonType.normal:
        return const [
          DamageRelation(PokemonType.rock, halfDamage),
          DamageRelation(PokemonType.ghost, noDamage),
          DamageRelation(PokemonType.steel, halfDamage),
        ];
      case PokemonType.fire:
        return const [
          DamageRelation(PokemonType.rock, halfDamage),
          DamageRelation(PokemonType.bug, doubleDamage),
          DamageRelation(PokemonType.steel, doubleDamage),
          DamageRelation(PokemonType.fire, halfDamage),
          DamageRelation(PokemonType.water, halfDamage),
          DamageRelation(PokemonType.grass, doubleDamage),
          DamageRelation(PokemonType.ice, doubleDamage),
          DamageRelation(PokemonType.dragon, halfDamage),
        ];
      case PokemonType.water:
        return const [
          DamageRelation(PokemonType.ground, doubleDamage),
          DamageRelation(PokemonType.rock, doubleDamage),
          DamageRelation(PokemonType.fire, doubleDamage),
          DamageRelation(PokemonType.water, halfDamage),
          DamageRelation(PokemonType.grass, halfDamage),
          DamageRelation(PokemonType.dragon, halfDamage),
        ];
      case PokemonType.electric:
        return const [
          DamageRelation(PokemonType.flying, doubleDamage),
          DamageRelation(PokemonType.ground, noDamage),
          DamageRelation(PokemonType.water, doubleDamage),
          DamageRelation(PokemonType.grass, halfDamage),
          DamageRelation(PokemonType.electric, halfDamage),
          DamageRelation(PokemonType.dragon, halfDamage),
        ];
      case PokemonType.grass:
        return const [
          DamageRelation(PokemonType.flying, halfDamage),
          DamageRelation(PokemonType.poison, halfDamage),
          DamageRelation(PokemonType.ground, doubleDamage),
          DamageRelation(PokemonType.rock, doubleDamage),
          DamageRelation(PokemonType.bug, halfDamage),
          DamageRelation(PokemonType.steel, halfDamage),
          DamageRelation(PokemonType.fire, halfDamage),
          DamageRelation(PokemonType.water, doubleDamage),
          DamageRelation(PokemonType.grass, halfDamage),
          DamageRelation(PokemonType.dragon, halfDamage),
        ];
      case PokemonType.ice:
        return const [
          DamageRelation(PokemonType.flying, doubleDamage),
          DamageRelation(PokemonType.ground, doubleDamage),
          DamageRelation(PokemonType.steel, halfDamage),
          DamageRelation(PokemonType.fire, halfDamage),
          DamageRelation(PokemonType.water, halfDamage),
          DamageRelation(PokemonType.grass, doubleDamage),
          DamageRelation(PokemonType.ice, halfDamage),
          DamageRelation(PokemonType.dragon, doubleDamage),
        ];
      case PokemonType.fighting:
        return const [
          DamageRelation(PokemonType.normal, doubleDamage),
          DamageRelation(PokemonType.flying, halfDamage),
          DamageRelation(PokemonType.poison, halfDamage),
          DamageRelation(PokemonType.rock, doubleDamage),
          DamageRelation(PokemonType.bug, halfDamage),
          DamageRelation(PokemonType.ghost, noDamage),
          DamageRelation(PokemonType.steel, doubleDamage),
          DamageRelation(PokemonType.psychic, halfDamage),
          DamageRelation(PokemonType.ice, doubleDamage),
          DamageRelation(PokemonType.dark, doubleDamage),
          DamageRelation(PokemonType.fairy, halfDamage),
        ];
      case PokemonType.poison:
        return const [
          DamageRelation(PokemonType.poison, halfDamage),
          DamageRelation(PokemonType.ground, halfDamage),
          DamageRelation(PokemonType.rock, halfDamage),
          DamageRelation(PokemonType.ghost, halfDamage),
          DamageRelation(PokemonType.steel, noDamage),
          DamageRelation(PokemonType.grass, doubleDamage),
          DamageRelation(PokemonType.fairy, doubleDamage),
        ];
      case PokemonType.ground:
        return const [
          DamageRelation(PokemonType.flying, noDamage),
          DamageRelation(PokemonType.poison, doubleDamage),
          DamageRelation(PokemonType.rock, doubleDamage),
          DamageRelation(PokemonType.bug, halfDamage),
          DamageRelation(PokemonType.steel, doubleDamage),
          DamageRelation(PokemonType.fire, doubleDamage),
          DamageRelation(PokemonType.grass, halfDamage),
          DamageRelation(PokemonType.electric, doubleDamage),
        ];
      case PokemonType.flying:
        return const [
          DamageRelation(PokemonType.fighting, doubleDamage),
          DamageRelation(PokemonType.rock, halfDamage),
          DamageRelation(PokemonType.bug, doubleDamage),
          DamageRelation(PokemonType.steel, halfDamage),
          DamageRelation(PokemonType.grass, doubleDamage),
          DamageRelation(PokemonType.electric, halfDamage),
        ];
      case PokemonType.psychic:
        return const [
          DamageRelation(PokemonType.fighting, doubleDamage),
          DamageRelation(PokemonType.poison, doubleDamage),
          DamageRelation(PokemonType.steel, halfDamage),
          DamageRelation(PokemonType.psychic, halfDamage),
          DamageRelation(PokemonType.dark, noDamage),
        ];
      case PokemonType.bug:
        return const [
          DamageRelation(PokemonType.fighting, halfDamage),
          DamageRelation(PokemonType.flying, halfDamage),
          DamageRelation(PokemonType.poison, halfDamage),
          DamageRelation(PokemonType.ghost, halfDamage),
          DamageRelation(PokemonType.steel, halfDamage),
          DamageRelation(PokemonType.fire, halfDamage),
          DamageRelation(PokemonType.grass, doubleDamage),
          DamageRelation(PokemonType.psychic, doubleDamage),
          DamageRelation(PokemonType.dark, doubleDamage),
          DamageRelation(PokemonType.fairy, halfDamage),
        ];
      case PokemonType.rock:
        return const [
          DamageRelation(PokemonType.fighting, halfDamage),
          DamageRelation(PokemonType.flying, doubleDamage),
          DamageRelation(PokemonType.ground, halfDamage),
          DamageRelation(PokemonType.bug, doubleDamage),
          DamageRelation(PokemonType.steel, halfDamage),
          DamageRelation(PokemonType.fire, doubleDamage),
          DamageRelation(PokemonType.ice, doubleDamage),
        ];
      case PokemonType.ghost:
        return const [
          DamageRelation(PokemonType.normal, noDamage),
          DamageRelation(PokemonType.ghost, doubleDamage),
          DamageRelation(PokemonType.psychic, doubleDamage),
          DamageRelation(PokemonType.dark, halfDamage),
        ];
      case PokemonType.dragon:
        return const [
          DamageRelation(PokemonType.steel, halfDamage),
          DamageRelation(PokemonType.dragon, doubleDamage),
          DamageRelation(PokemonType.fairy, noDamage),
        ];
      case PokemonType.dark:
        return const [
          DamageRelation(PokemonType.fighting, halfDamage),
          DamageRelation(PokemonType.ghost, doubleDamage),
          DamageRelation(PokemonType.psychic, doubleDamage),
          DamageRelation(PokemonType.dark, halfDamage),
          DamageRelation(PokemonType.fairy, halfDamage),
        ];
      case PokemonType.steel:
        return const [
          DamageRelation(PokemonType.rock, doubleDamage),
          DamageRelation(PokemonType.steel, halfDamage),
          DamageRelation(PokemonType.fire, halfDamage),
          DamageRelation(PokemonType.water, halfDamage),
          DamageRelation(PokemonType.electric, halfDamage),
          DamageRelation(PokemonType.ice, doubleDamage),
          DamageRelation(PokemonType.fairy, doubleDamage),
        ];
      case PokemonType.fairy:
        return const [
          DamageRelation(PokemonType.fighting, doubleDamage),
          DamageRelation(PokemonType.poison, halfDamage),
          DamageRelation(PokemonType.steel, halfDamage),
          DamageRelation(PokemonType.fire, halfDamage),
          DamageRelation(PokemonType.dragon, doubleDamage),
          DamageRelation(PokemonType.dark, doubleDamage),
        ];
    }
  }
}
