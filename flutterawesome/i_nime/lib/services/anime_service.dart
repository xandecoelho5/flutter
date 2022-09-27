import 'package:dio/dio.dart';

abstract class IAnimeService {
  Future<List> getTrendingAnimes();

  Future<List> getAnimesBySearch(String query);
}

const String baseUrl = 'https://kitsu.io/api/edge';

class AnimeService implements IAnimeService {
  final Dio dio;

  AnimeService(this.dio);

  @override
  Future<List> getTrendingAnimes() async {
    try {
      var response = await dio.get('$baseUrl/trending/anime');
      return response.data['data'];
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<List> getAnimesBySearch(String query) async {
    try {
      var response = await dio.get('$baseUrl/anime?filter[text]=$query');
      return response.data['data'];
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
