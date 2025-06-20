import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:game_catalog_app/features/home/data/models/game_model.dart';

final favoritesBoxProvider = Provider<Box<GameModel>>((ref) {
  return Hive.box<GameModel>('favorites');
});

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<GameModel>>((ref) {
  final box = ref.watch(favoritesBoxProvider);
  return FavoritesNotifier(box);
});

class FavoritesNotifier extends StateNotifier<List<GameModel>> {
  final Box<GameModel> box;

  FavoritesNotifier(this.box) : super(box.values.toList());

  void toggleFavorite(GameModel game) {
    if (box.containsKey(game.id)) {
      box.delete(game.id);
    } else {
      box.put(game.id, game);
    }
    state = box.values.toList();
  }

  bool isFavorite(int gameId) {
    return box.containsKey(gameId);
  }
}
