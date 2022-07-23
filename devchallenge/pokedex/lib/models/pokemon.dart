import 'package:pokedex/models/evolution.dart';
import 'package:pokedex/models/location.dart';
import 'package:pokedex/models/pokemon_type.dart';

import 'ability.dart';

class Pokemon {
  final int pokedexNumber;
  final String name;
  final String imageUrl;
  final List<PokemonType> types;

  // Pokédex Data
  final String description;
  final String species;
  final double height;
  final double weight;
  final List<Ability> abilities;
  final List<PokemonType> weaknesses;

  // Training
  final String evYield;
  final String catchRate;
  final int baseFriendship;
  final int baseExp;
  final String growthRate;

  // Breeding
  final String gender;
  final String eggGroups;
  final String eggCycles;

  // Location
  final List<Location> locations;

  // Base Stats
  final int hp;
  final int minHp;
  final int maxHp;
  final int attack;
  final int minAttack;
  final int maxAttack;
  final int defense;
  final int minDefense;
  final int maxDefense;
  final int specialAttack;
  final int minSpecialAttack;
  final int maxSpecialAttack;
  final int specialDefense;
  final int minSpecialDefense;
  final int maxSpecialDefense;
  final int speed;
  final int minSpeed;
  final int maxSpeed;

  // Evolution Chart
  final List<Evolution> evolutions;

  const Pokemon({
    required this.pokedexNumber,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.description,
    required this.species,
    required this.height,
    required this.weight,
    required this.abilities,
    required this.weaknesses,
    required this.evYield,
    required this.catchRate,
    required this.baseFriendship,
    required this.baseExp,
    required this.growthRate,
    required this.gender,
    required this.eggGroups,
    required this.eggCycles,
    required this.locations,
    required this.hp,
    required this.minHp,
    required this.maxHp,
    required this.attack,
    required this.minAttack,
    required this.maxAttack,
    required this.defense,
    required this.minDefense,
    required this.maxDefense,
    required this.specialAttack,
    required this.minSpecialAttack,
    required this.maxSpecialAttack,
    required this.specialDefense,
    required this.minSpecialDefense,
    required this.maxSpecialDefense,
    required this.speed,
    required this.minSpeed,
    required this.maxSpeed,
    required this.evolutions,
  });

  int get totalStats =>
      hp + attack + defense + specialAttack + specialDefense + speed;
}
