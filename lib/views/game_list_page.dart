import 'package:catalogo_de_jogos/models/game.dart';
import 'package:catalogo_de_jogos/views/game_details.page.dart';
import 'package:catalogo_de_jogos/widgets/game_card.dart';
import 'package:flutter/material.dart';

class GameListPage extends StatelessWidget {
  final List<Game> games;
  final String title;

  const GameListPage({super.key, required this.games, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child:
            games.isEmpty
                ? Center(child: Text('Nenhum jogo encontrado'))
                : GridView.builder(
                  itemCount: games.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    final game = games[index];
                    return GameCard(
                      game: game,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => GameDetailsPage(game: game),
                          ),
                        );
                      },
                    );
                  },
                ),
      ),
    );
  }
}
