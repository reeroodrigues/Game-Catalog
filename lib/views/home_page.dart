import 'package:flutter/material.dart';
import '../models/game.dart';
import '../widgets/game_card.dart';
import 'game_details.page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Game> _allGames = [];
  List<Game> _filteredGames = [];

  @override
  void initState() {
    super.initState();

    _allGames = [
      Game(
        id: '1',
        title: 'The Legend of Zelda: Breath of the Wild',
        console: 'Nintendo Switch',
        description: 'Explore um mundo vasto e aberto com total liberdade.',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/en/thumb/c/cc/The_Legend_of_Zelda_Breath_of_the_Wild.jpg/220px-The_Legend_of_Zelda_Breath_of_the_Wild.jpg',
        subtitle: 'A',
      ),
      Game(
        id: '2',
        title: 'God of War',
        console: 'PS4',
        description:
            'Kratos embarca em uma jornada épica com seu filho Atreus.',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/en/thumb/a/a7/God_of_War_4_cover.jpg/220px-God_of_War_4_cover.jpg',
        subtitle: 'A',
      ),
      Game(
        id: '3',
        title: 'The Last of Us',
        console: 'PS3 / PS4',
        description: 'Uma jornada emocional em um mundo pós-apocalíptico.',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/en/thumb/c/c2/The_Last_of_Us_cover.jpg/220px-The_Last_of_Us_cover.jpg',
        subtitle: 'A',
      ),
      Game(
        id: '4',
        title: 'EA FC 24',
        console: 'Multiplataforma',
        description: 'O novo futebol da EA Sports com motor Frostbite.',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/en/thumb/b/b4/EA_Sports_FC_24_cover.jpg/220px-EA_Sports_FC_24_cover.jpg',
        subtitle: 'A',
      ),
      Game(
        id: '5',
        title: 'Red Dead Redemption II',
        console: 'PS4 / Xbox / PC',
        description: 'A vida de um fora-da-lei no Velho Oeste.',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/en/thumb/4/44/Red_Dead_Redemption_II.jpg/220px-Red_Dead_Redemption_II.jpg',
        subtitle: 'A',
      ),
      Game(
        id: '6',
        title: 'Horizon Zero Dawn',
        console: 'PS4',
        description: 'Caçadora enfrenta máquinas em um mundo selvagem.',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/en/thumb/0/0d/Horizon_Zero_Dawn.jpg/220px-Horizon_Zero_Dawn.jpg',
        subtitle: 'A',
      ),
      Game(
        id: '7',
        title: 'Cyberpunk 2077',
        console: 'PS4 / Xbox / PC',
        description: 'Explore Night City como um mercenário cibernético.',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/en/thumb/9/9f/Cyberpunk_2077_box_art.jpg/220px-Cyberpunk_2077_box_art.jpg',
        subtitle: 'A',
      ),
      Game(
        id: '8',
        title: 'Minecraft',
        console: 'Multiplataforma',
        description: 'Construa, explore e sobreviva em um mundo de blocos.',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/en/thumb/5/51/Minecraft_cover.png/220px-Minecraft_cover.png',
        subtitle: 'A',
      ),
    ];

    _filteredGames = _allGames;
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredGames =
          _allGames
              .where((game) => game.title.toLowerCase().contains(query))
              .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Catálogo de Jogos')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar jogo por nome...',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white12,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: _filteredGames.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final game = _filteredGames[index];
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
          ],
        ),
      ),
    );
  }
}
