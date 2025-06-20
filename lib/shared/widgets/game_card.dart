import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../features/favorites/providers/favorites_provider.dart';
import '../../features/home/data/models/game_model.dart';
import 'package:go_router/go_router.dart';

class GameCard extends ConsumerWidget {
  final GameModel game;

  const GameCard({super.key, required this.game});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final isFavorite = favorites.any((g) => g.id == game.id);

    // Debug print
    print('Game: ${game.name}, Image: ${game.backgroundImage}');

    return GestureDetector(
      onTap: () {
        context.push('/game-details', extra: game);
      },
      child: Stack(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Builder(
                    builder: (context) {
                      final imageUrl = game.backgroundImage ?? '';
                      if (imageUrl.isEmpty) {
                        return const Icon(Icons.image_not_supported);
                      }
                      print('🌄 Imagem carregada: ${game.backgroundImage}');
                      return CachedNetworkImage(
                        imageUrl: game.backgroundImage ?? '',
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) {
                          print('❌ Erro ao carregar imagem: $error');
                          return const Icon(Icons.broken_image);
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    game.name,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: () {
                ref.read(favoritesProvider.notifier).toggleFavorite(game);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(6),
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
