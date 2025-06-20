import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/widgets/game_card.dart';
import '../providers/favorites_provider.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteGames = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Meus Favoritos')),
      body: favoriteGames.isEmpty
          ? const Center(
              child: Text(
                'Você ainda não favoritou nenhum jogo.',
                style: TextStyle(fontSize: 16),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.68,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: favoriteGames.length,
              itemBuilder: (context, index) {
                return GameCard(game: favoriteGames[index]);
              },
            ),
    );
  }
}
