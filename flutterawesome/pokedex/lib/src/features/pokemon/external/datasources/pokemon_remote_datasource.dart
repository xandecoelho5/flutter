import 'package:dio/dio.dart';
import 'package:pokedex/src/features/pokemon/infra/datasources/pokemon_remote_datasource.dart';
import 'package:pokedex/src/features/pokemon/infra/models/pokemon_response_model.dart';

class PokemonRemoteDatasource implements IPokemonRemoteDataSource {
  final Dio dio;

  PokemonRemoteDatasource(this.dio);

  @override
  Future<PokemonResponseModel> getAllPokemons([String? url]) async {
    try {
      final response = await dio.get(url ?? '');
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
