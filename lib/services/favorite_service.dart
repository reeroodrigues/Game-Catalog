import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  static const _key = 'favorite_games';

  Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_key) ?? [];
    return favorites;
  }

  Future<void> toggleFavorite(String gameId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_key) ?? [];

    if (favorites.contains(gameId)) {
      favorites.remove(gameId);
    } else {
      favorites.add(gameId);
    }

    await prefs.setStringList(_key, favorites);
  }

  Future<bool> isFavorite(String gameId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_key) ?? [];
    return favorites.contains(gameId);
  }

  Future<void> addFavorite(String gameId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_key) ?? [];
    if (!favorites.contains(gameId)) {
      favorites.add(gameId);
      await prefs.setStringList(_key, favorites);
    }
  }

  Future<void> removeFavorite(String gameId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_key) ?? [];
    favorites.remove(gameId);
    await prefs.setStringList(_key, favorites);
  }
}
