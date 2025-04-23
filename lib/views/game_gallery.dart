import 'package:catalogo_de_jogos/models/game.dart';
import 'package:flutter/material.dart';

class GameGallery extends StatefulWidget {
  final List<Game> games;

  const GameGallery({super.key, required this.games});

  @override
  State<GameGallery> createState() => _GameGalleryState();
}

class _GameGalleryState extends State<GameGallery> {
  String selectedConsole = 'Todos';

  List<String> get consoles {
    final allConsoles = widget.games.map((g) => g.console).toSet().toList();
    return ['Todos', ...allConsoles];
  }

  @override
  Widget build(BuildContext context) {
    final filterGames =
        selectedConsole == 'Todos'
            ? widget.games
            : widget.games.where((g) => g.console == selectedConsole).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          child: Row(
            children: [
              const Icon(Icons.filter_alt, color: Colors.deepPurple),
              const SizedBox(width: 10),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: selectedConsole,
                  decoration: InputDecoration(
                    labelText: "Filtrar por console",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.arrow_drop_down),
                  items:
                      consoles.map((console) {
                        return DropdownMenuItem(
                          value: console,
                          child: Text(console),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedConsole = value!;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: filterGames.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              final game = filterGames[index];
              return _buildGameCard(game);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGameCard(Game game) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      shadowColor: Colors.deepPurple,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              game.imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, _, __) => const Icon(Icons.broken_image, size: 60),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              game.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            game.console,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
