import '../models/pokemon_response_model.dart';

abstract class IPokemonDatasource {
  Future<Map> getPokemonByName(String name);
  Future<PokemonResponseModel> getAllPokemons([String? url]);
}
