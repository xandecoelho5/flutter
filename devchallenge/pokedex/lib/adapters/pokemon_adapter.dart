import 'package:pokedex/models/ability.dart';

import '../models/pokemon_type.dart';

class PokemonAdapter {
  PokemonAdapter._();

  // static Pokemon fromPokeApiData(Map<String, dynamic> json) {
  //   final data = json['pokemon_v2_pokemon'][0];
  //   final specy = data['pokemon_v2_pokemonspecy'];
  //   return Pokemon(
  //     pokedexNumber: data['id'],
  //     name: data['name'],
  //     imageUrl: _imageUrl(data['pokemon_v2_pokemonsprites']['sprites']),
  //     types: _types(data['pokemon_v2_pokemontypes']),
  //     description: data['pokemon_v2_pokemonspeciesflavortexts'][0]
  //         ['flavor_text'],
  //     species: specy['pokemon_v2_pokemonspeciesnames'][0]['genus'],
  //     height: data['height'],
  //     weight: data['weight'],
  //     abilities: _abilities(data['pokemon_v2_pokemonabilities']),
  //     weaknesses: [],
  //     evYield: '',
  //     //calcular baseado nos status
  //     catchRate: specy['capture_rate'],
  //     baseFriendship: specy['base_happiness'],
  //     baseExp: specy['base_experience'],
  //     growthRate: specy['pokemon_v2_growthrate']['name'],
  //     gender: specy['gender_rate'],
  //     //calular o gender, o rate é 1/8
  //     eggGroups: _eggGroups(specy['pokemon_v2_pokemonegggroups']),
  //     eggCycles: _eggCycles(specy['hatch_counter']),
  //     locations: locations,
  //     hp: hp,
  //     minHp: minHp,
  //     maxHp: maxHp,
  //     attack: attack,
  //     minAttack: minAttack,
  //     maxAttack: maxAttack,
  //     defense: defense,
  //     minDefense: minDefense,
  //     maxDefense: maxDefense,
  //     specialAttack: specialAttack,
  //     minSpecialAttack: minSpecialAttack,
  //     maxSpecialAttack: maxSpecialAttack,
  //     specialDefense: specialDefense,
  //     minSpecialDefense: minSpecialDefense,
  //     maxSpecialDefense: maxSpecialDefense,
  //     speed: speed,
  //     minSpeed: minSpeed,
  //     maxSpeed: maxSpeed,
  //     evolutions: evolutions,
  //     evolutionChainId: evolutionChainId,
  //   );
  // }

  static String _imageUrl(String sprites) {
    return 'https://img.pokemondb.net/sprites/omega-ruby-alpha-sapphire/dex/normal/$sprites.png';
  }

  static List<PokemonType> _types(types) {
    return types
        .map(
          (type) => PokemonType.values
              .where((e) => type['pokemon_v2_type']['name'] == e.name)
              .first,
        )
        .toList();
  }

  static List<Ability> _abilities(abilities) {
    return abilities
        .map(
          (ability) => Ability(
            slot: abilities['slot'],
            name: abilities['pokemon_v2_ability']['name'],
            isHidden: abilities['is_Hidden'],
          ),
        )
        .toList();
  }

  static String _eggGroups(eggGroups) {
    return eggGroups
        .map((group) => group['pokemon_v2_egggroup']['name'].toUpperCase())
        .toList()
        .join(', ');
  }

  static String _eggCycles(hatchCounter) {
    return '$hatchCounter (${hatchCounter * 255} - ${(hatchCounter + 1) * 256} steps)';
  }
}
