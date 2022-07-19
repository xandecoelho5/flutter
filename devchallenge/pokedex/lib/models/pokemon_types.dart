import 'package:flutter/material.dart';

class DamageRelation {
  const DamageRelation(this.type, this.damage);

  final PokemonTypes type;
  final double damage;
}

enum PokemonTypes {
  normal('Normal', Color(0xFF9DA0AA), Color(0xFFB5B9C4)),
  fire('Fire', Color(0xFFFD7D24), Color(0xFFFFA756)),
  water('Water', Color(0xFF4A90DA), Color(0xFF58ABF6)),
  electric('Eletric', Color(0xFFEED535), Color(0xFFF2CB55)),
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

  const PokemonTypes(this.type, this.foregroundColor, this.backgroundColor);

  final String type;
  final Color foregroundColor;
  final Color backgroundColor;

  // final List<DamageRelation> damageRelations;

  List<DamageRelation> getDamageRelations(PokemonTypes type) {
    const halfDamage = 0.5;
    const doubleDamage = 2.0;
    const noDamage = 0.0;

    switch (type) {
      case PokemonTypes.normal:
        return const [
          DamageRelation(PokemonTypes.rock, halfDamage),
          DamageRelation(PokemonTypes.ghost, noDamage),
          DamageRelation(PokemonTypes.steel, halfDamage),
        ];
      case PokemonTypes.fire:
        return const [
          DamageRelation(PokemonTypes.rock, halfDamage),
          DamageRelation(PokemonTypes.bug, doubleDamage),
          DamageRelation(PokemonTypes.steel, doubleDamage),
          DamageRelation(PokemonTypes.fire, halfDamage),
          DamageRelation(PokemonTypes.water, halfDamage),
          DamageRelation(PokemonTypes.grass, doubleDamage),
          DamageRelation(PokemonTypes.ice, doubleDamage),
          DamageRelation(PokemonTypes.dragon, halfDamage),
        ];
      case PokemonTypes.water:
        return const [
          DamageRelation(PokemonTypes.ground, doubleDamage),
          DamageRelation(PokemonTypes.rock, doubleDamage),
          DamageRelation(PokemonTypes.fire, doubleDamage),
          DamageRelation(PokemonTypes.water, halfDamage),
          DamageRelation(PokemonTypes.grass, halfDamage),
          DamageRelation(PokemonTypes.dragon, halfDamage),
        ];
      case PokemonTypes.electric:
        return const [
          DamageRelation(PokemonTypes.flying, doubleDamage),
          DamageRelation(PokemonTypes.ground, noDamage),
          DamageRelation(PokemonTypes.water, doubleDamage),
          DamageRelation(PokemonTypes.grass, halfDamage),
          DamageRelation(PokemonTypes.electric, halfDamage),
          DamageRelation(PokemonTypes.dragon, halfDamage),
        ];
      case PokemonTypes.grass:
        return const [
          DamageRelation(PokemonTypes.flying, halfDamage),
          DamageRelation(PokemonTypes.poison, halfDamage),
          DamageRelation(PokemonTypes.ground, doubleDamage),
          DamageRelation(PokemonTypes.rock, doubleDamage),
          DamageRelation(PokemonTypes.bug, halfDamage),
          DamageRelation(PokemonTypes.steel, halfDamage),
          DamageRelation(PokemonTypes.fire, halfDamage),
          DamageRelation(PokemonTypes.water, doubleDamage),
          DamageRelation(PokemonTypes.grass, halfDamage),
          DamageRelation(PokemonTypes.dragon, halfDamage),
        ];
      case PokemonTypes.ice:
        return const [
          DamageRelation(PokemonTypes.flying, doubleDamage),
          DamageRelation(PokemonTypes.ground, doubleDamage),
          DamageRelation(PokemonTypes.steel, halfDamage),
          DamageRelation(PokemonTypes.fire, halfDamage),
          DamageRelation(PokemonTypes.water, halfDamage),
          DamageRelation(PokemonTypes.grass, doubleDamage),
          DamageRelation(PokemonTypes.ice, halfDamage),
          DamageRelation(PokemonTypes.dragon, doubleDamage),
        ];
      case PokemonTypes.fighting:
        return const [
          DamageRelation(PokemonTypes.normal, doubleDamage),
          DamageRelation(PokemonTypes.flying, halfDamage),
          DamageRelation(PokemonTypes.poison, halfDamage),
          DamageRelation(PokemonTypes.rock, doubleDamage),
          DamageRelation(PokemonTypes.bug, halfDamage),
          DamageRelation(PokemonTypes.ghost, noDamage),
          DamageRelation(PokemonTypes.steel, doubleDamage),
          DamageRelation(PokemonTypes.psychic, halfDamage),
          DamageRelation(PokemonTypes.ice, doubleDamage),
          DamageRelation(PokemonTypes.dark, doubleDamage),
          DamageRelation(PokemonTypes.fairy, halfDamage),
        ];
      case PokemonTypes.poison:
        return const [
          DamageRelation(PokemonTypes.poison, halfDamage),
          DamageRelation(PokemonTypes.ground, halfDamage),
          DamageRelation(PokemonTypes.rock, halfDamage),
          DamageRelation(PokemonTypes.ghost, halfDamage),
          DamageRelation(PokemonTypes.steel, noDamage),
          DamageRelation(PokemonTypes.grass, doubleDamage),
          DamageRelation(PokemonTypes.fairy, doubleDamage),
        ];
      case PokemonTypes.ground:
        return const [
          DamageRelation(PokemonTypes.flying, noDamage),
          DamageRelation(PokemonTypes.poison, doubleDamage),
          DamageRelation(PokemonTypes.rock, doubleDamage),
          DamageRelation(PokemonTypes.bug, halfDamage),
          DamageRelation(PokemonTypes.steel, doubleDamage),
          DamageRelation(PokemonTypes.fire, doubleDamage),
          DamageRelation(PokemonTypes.grass, halfDamage),
          DamageRelation(PokemonTypes.electric, doubleDamage),
        ];
      case PokemonTypes.flying:
        return const [
          DamageRelation(PokemonTypes.fighting, doubleDamage),
          DamageRelation(PokemonTypes.rock, halfDamage),
          DamageRelation(PokemonTypes.bug, doubleDamage),
          DamageRelation(PokemonTypes.steel, halfDamage),
          DamageRelation(PokemonTypes.grass, doubleDamage),
          DamageRelation(PokemonTypes.electric, halfDamage),
        ];
      case PokemonTypes.psychic:
        return const [
          DamageRelation(PokemonTypes.fighting, doubleDamage),
          DamageRelation(PokemonTypes.poison, doubleDamage),
          DamageRelation(PokemonTypes.steel, halfDamage),
          DamageRelation(PokemonTypes.psychic, halfDamage),
          DamageRelation(PokemonTypes.dark, noDamage),
        ];
      case PokemonTypes.bug:
        return const [
          DamageRelation(PokemonTypes.fighting, halfDamage),
          DamageRelation(PokemonTypes.flying, halfDamage),
          DamageRelation(PokemonTypes.poison, halfDamage),
          DamageRelation(PokemonTypes.ghost, halfDamage),
          DamageRelation(PokemonTypes.steel, halfDamage),
          DamageRelation(PokemonTypes.fire, halfDamage),
          DamageRelation(PokemonTypes.grass, doubleDamage),
          DamageRelation(PokemonTypes.psychic, doubleDamage),
          DamageRelation(PokemonTypes.dark, doubleDamage),
          DamageRelation(PokemonTypes.fairy, halfDamage),
        ];
      case PokemonTypes.rock:
        return const [
          DamageRelation(PokemonTypes.fighting, halfDamage),
          DamageRelation(PokemonTypes.flying, doubleDamage),
          DamageRelation(PokemonTypes.ground, halfDamage),
          DamageRelation(PokemonTypes.bug, doubleDamage),
          DamageRelation(PokemonTypes.steel, halfDamage),
          DamageRelation(PokemonTypes.fire, doubleDamage),
          DamageRelation(PokemonTypes.ice, doubleDamage),
        ];
      case PokemonTypes.ghost:
        return const [
          DamageRelation(PokemonTypes.normal, noDamage),
          DamageRelation(PokemonTypes.ghost, doubleDamage),
          DamageRelation(PokemonTypes.psychic, doubleDamage),
          DamageRelation(PokemonTypes.dark, halfDamage),
        ];
      case PokemonTypes.dragon:
        return const [
          DamageRelation(PokemonTypes.steel, halfDamage),
          DamageRelation(PokemonTypes.dragon, doubleDamage),
          DamageRelation(PokemonTypes.fairy, noDamage),
        ];
      case PokemonTypes.dark:
        return const [
          DamageRelation(PokemonTypes.fighting, halfDamage),
          DamageRelation(PokemonTypes.ghost, doubleDamage),
          DamageRelation(PokemonTypes.psychic, doubleDamage),
          DamageRelation(PokemonTypes.dark, halfDamage),
          DamageRelation(PokemonTypes.fairy, halfDamage),
        ];
      case PokemonTypes.steel:
        return const [
          DamageRelation(PokemonTypes.rock, doubleDamage),
          DamageRelation(PokemonTypes.steel, halfDamage),
          DamageRelation(PokemonTypes.fire, halfDamage),
          DamageRelation(PokemonTypes.water, halfDamage),
          DamageRelation(PokemonTypes.electric, halfDamage),
          DamageRelation(PokemonTypes.ice, doubleDamage),
          DamageRelation(PokemonTypes.fairy, doubleDamage),
        ];
      case PokemonTypes.fairy:
        return const [
          DamageRelation(PokemonTypes.fighting, doubleDamage),
          DamageRelation(PokemonTypes.poison, halfDamage),
          DamageRelation(PokemonTypes.steel, halfDamage),
          DamageRelation(PokemonTypes.fire, halfDamage),
          DamageRelation(PokemonTypes.dragon, doubleDamage),
          DamageRelation(PokemonTypes.dark, doubleDamage),
        ];
    }
  }
}
