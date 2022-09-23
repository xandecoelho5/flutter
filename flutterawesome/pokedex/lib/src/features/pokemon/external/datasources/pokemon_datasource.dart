import 'package:dio/dio.dart';
import 'package:pokedex/src/features/pokemon/infra/datasources/pokemon_datasource.dart';
import 'package:pokedex/src/features/pokemon/infra/models/pokemon_response_model.dart';

class PokemonDatasource implements IPokemonDatasource {
  final Dio dio;

  PokemonDatasource(this.dio);

  @override
  Future<PokemonResponseModel> getAllPokemons() async {
    try {
      final response = await dio.get('');
      return PokemonResponseModel.fromMap(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Map> getPokemonByName(String name) async {
    try {
      final response = await dio.get('/$name');
      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }
}
