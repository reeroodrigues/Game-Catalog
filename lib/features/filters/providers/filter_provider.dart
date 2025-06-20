import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_catalog_app/services/api/dio_client.dart';
import 'package:game_catalog_app/features/filters/data/filter_repository.dart';
import 'package:game_catalog_app/features/filters/models/genre_model.dart';
import 'package:game_catalog_app/features/filters/models/platform_model.dart';
import 'package:game_catalog_app/features/home/data/game_api_service.dart';

final filterApiServiceProvider = Provider<GameApiService>((ref) {
  final dio = createDioClient();
  return GameApiService(dio);
});

final filterRepositoryProvider = Provider<FilterRepository>((ref) {
  return FilterRepository(ref.watch(filterApiServiceProvider));
});

final platformsProvider = FutureProvider<List<PlatformModel>>((ref) async {
  return ref.watch(filterRepositoryProvider).getPlatforms();
});

final genresProvider = FutureProvider<List<GenreModel>>((ref) async {
  return ref.watch(filterRepositoryProvider).getGenres();
});

final selectedPlatformIdProvider = StateProvider<int?>((ref) => null);
final selectedGenreIdProvider = StateProvider<int?>((ref) => null);
