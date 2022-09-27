import 'package:i_nime/models/anime.dart';

import '../services/anime_service.dart';

abstract class IAnimeRepository {
  Future<List<Anime>> getTrendingAnimes();
  Future<List<Anime>> getAnimesBySearch(String query);
}

class AnimeRepository implements IAnimeRepository {
  final IAnimeService animeService;

  AnimeRepository(this.animeService);

  @override
  Future<List<Anime>> getTrendingAnimes() async {
    try {
      var response = await animeService.getTrendingAnimes();
      return response.map((e) => Anime.fromMap(e)).toList();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<List<Anime>> getAnimesBySearch(String query) async {
    try {
      var response = await animeService.getAnimesBySearch(query);
      return response.map((e) => Anime.fromMap(e)).toList();
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
