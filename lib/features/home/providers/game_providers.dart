import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/api/dio_client.dart';
import '../data/game_api_service.dart';
import '../data/game_repository.dart';
import '../data/models/game_model.dart';
import 'package:game_catalog_app/features/filters/providers/filter_provider.dart';

// Estado do termo de busca
final searchQueryProvider = StateProvider<String>((ref) => '');

// API e repositório
final apiServiceProvider = Provider<GameApiService>((ref) {
  final dio = createDioClient();
  return GameApiService(dio);
});

final gameRepositoryProvider = Provider<GameRepository>((ref) {
  final api = ref.watch(apiServiceProvider);
  return GameRepository(api);
});

// Lista de jogos observada dinamicamente
final gamesProvider = FutureProvider<List<GameModel>>((ref) {
  final repo = ref.watch(gameRepositoryProvider);
  final query = ref.watch(searchQueryProvider);
  final platformId = ref.watch(selectedPlatformIdProvider);
  final genreId = ref.watch(selectedGenreIdProvider);

  if (query.isEmpty) {
    return repo.fetchGames(
      platformId: platformId,
      genreId: genreId,
    );
  } else {
    return repo.searchGames(query);
  }
});
