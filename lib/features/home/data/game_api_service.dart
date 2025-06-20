import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:game_catalog_app/features/home/data/models/game_list_response.dart';
import 'package:game_catalog_app/features/filters/models/genre_model.dart';
import 'package:game_catalog_app/features/filters/models/platform_model.dart';

part 'game_api_service.g.dart';

@RestApi(baseUrl: "https://api.rawg.io/api/")
abstract class GameApiService {
  factory GameApiService(Dio dio, {String baseUrl}) = _GameApiService;

  @GET("games")
  Future<GameListResponse> getGames(
    @Query("key") String apiKey,
    @Query("page") int page,
    @Query("page_size") int pageSize,
  );

  @GET("games")
  Future<GameListResponse> searchGames(
    @Query("key") String apiKey,
    @Query("search") String query,
    @Query("page") int page,
    @Query("page_size") int pageSize,
  );

  @GET("games")
  Future<GameListResponse> getGamesWithParams(
    @Query("key") String apiKey,
    @Query("page") int page,
    @Query("page_size") int pageSize,
    @Query("platforms") int? platformId,
    @Query("genres") int? genreId,
  );

  @GET("genres")
  Future<GenreListResponse> getGenres(@Query("key") String apiKey);

  @GET("platforms")
  Future<PlatformListResponse> getPlatforms(@Query("key") String apiKey);
}
