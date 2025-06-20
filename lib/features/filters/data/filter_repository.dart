import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:game_catalog_app/features/filters/models/genre_model.dart';
import 'package:game_catalog_app/features/filters/models/platform_model.dart';
import 'package:game_catalog_app/features/home/data/game_api_service.dart';

class FilterRepository {
  final GameApiService api;

  FilterRepository(this.api);

  Future<List<PlatformModel>> getPlatforms() async {
    final apiKey = dotenv.env['RAWG_API_KEY']!;
    final response = await api.getPlatforms(apiKey);
    return response.results;
  }

  Future<List<GenreModel>> getGenres() async {
    final apiKey = dotenv.env['RAWG_API_KEY']!;
    final response = await api.getGenres(apiKey);
    return response.results;
  }
}
