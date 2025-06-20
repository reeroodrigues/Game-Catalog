import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'models/game_model.dart';
import 'game_api_service.dart';

class GameRepository {
  final GameApiService api;

  GameRepository(this.api);

  Future<List<GameModel>> fetchGames({
    int page = 1,
    int pageSize = 20,
    int? platformId,
    int? genreId,
  }) async {
    final key = dotenv.env['RAWG_API_KEY']!;
    final queryParams = {
      'key': key,
      'page': page,
      'page_size': pageSize,
      if (platformId != null) 'platforms': platformId.toString(),
      if (genreId != null) 'genres': genreId.toString(),
    };
    final response = await api.getGamesWithParams(
      key,
      page,
      pageSize,
      platformId,
      genreId,
    );
    return response.results;
  }

  Future<List<GameModel>> searchGames(String query,
      {int page = 1, int pageSize = 20}) async {
    final key = dotenv.env['RAWG_API_KEY']!;
    final response = await api.searchGames(key, query, page, pageSize);
    return response.results;
  }
}
