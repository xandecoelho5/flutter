const String pokeAPIQuery = '''
query PokeAPIquery {
  pokemon_v2_pokemon(where: {id: {_gte: 1}, _and: {id: {_lte: 858}}}) {
    id
    name
    pokemon_v2_pokemontypes {
      pokemon_v2_type {
        name
      }
    }
    height
    weight
    pokemon_v2_pokemonabilities {
      slot
      pokemon_v2_ability {
        name
      }
      is_hidden
    }
    base_experience
    pokemon_v2_pokemonspecy {
      base_happiness
      capture_rate
      gender_rate
      hatch_counter
      pokemon_v2_pokemonspeciesflavortexts(where: {language_id: {_eq: 9}}, limit: 1) {
        flavor_text
      }
      pokemon_v2_growthrate {
        name
      }
      pokemon_v2_pokemonegggroups {
        pokemon_v2_egggroup {
          name
        }
      }
      pokemon_v2_pokemonspeciesnames(where: {language_id: {_eq: 9}}) {
        genus
      }
      evolution_chain_id
    }
    pokemon_v2_pokemongameindices {
      pokemon_v2_version {
        name
      }
    }
    pokemon_v2_pokemonstats {
      pokemon_v2_stat {
        name
      }
      base_stat
      effort
    }
    pokemon_v2_pokemonsprites {
      sprites
    }
  }
}
''';
