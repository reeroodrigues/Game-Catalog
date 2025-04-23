import 'package:flutter/material.dart';
import '../models/game.dart';
import '../widgets/game_card.dart';
import 'game_details.page.dart';
import '../services/favorite_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedConsole = 'Todos';
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _allGamesScrollController = ScrollController();
  final ScrollController _favoritesScrollController = ScrollController();
  bool _showBackToTopButtonAllGames = false;
  bool _showBackToTopButtonFavorites = false;

  List<Game> _allGames = [];
  List<Game> _filteredAllGames = [];
  List<Game> _favoriteGames = [];
  final FavoriteService _favoriteService = FavoriteService();
  Set<String> _favoriteIds = {};
  Game? _lastRemovedFavorite;

  List<String> get _consoles {
    return [
      'Todos',
      ..._allGames
          .map((g) => g.console)
          .expand((c) => c.split('/'))
          .map((c) => c.trim())
          .toSet(),
    ];
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadInitialData();
    _searchController.addListener(_onSearchChanged);
    _allGamesScrollController.addListener(_onAllGamesScroll);
    _favoritesScrollController.addListener(_onFavoritesScroll);
  }

  Future<void> _loadInitialData() async {
    _allGames = [
      Game(
        id: '1',
        title: 'The Legend of Zelda: Breath of the Wild',
        console: 'Nintendo Switch',
        description: 'Explore um mundo vasto e aberto com total liberdade.',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/en/thumb/c/cc/The_Legend_of_Zelda_Breath_of_the_Wild.jpg/220px-The_Legend_of_Zelda_Breath_of_the_Wild.jpg',
        subtitle: 'A',
        isFavorite: true,
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
        isFavorite: true,
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
        isFavorite: true,
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
    _filterGames();
    await _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final favoritesIds = await _favoriteService.getFavorites();
    print('IDs de favoritos recuperados: $favoritesIds');
    setState(() {
      _favoriteIds = favoritesIds.toSet();
      _favoriteGames =
          _allGames.where((game) => _favoriteIds.contains(game.id)).toList();
      print('Número de jogos favoritos na lista: ${_favoriteGames.length}');
    });
  }

  void _onAllGamesScroll() {
    if (_allGamesScrollController.offset >= 400 &&
        !_showBackToTopButtonAllGames) {
      setState(() {
        _showBackToTopButtonAllGames = true;
      });
    } else if (_allGamesScrollController.offset < 400 &&
        _showBackToTopButtonAllGames) {
      setState(() {
        _showBackToTopButtonAllGames = false;
      });
    }
  }

  void _onFavoritesScroll() {
    if (_favoritesScrollController.offset >= 400 &&
        !_showBackToTopButtonFavorites) {
      setState(() {
        _showBackToTopButtonFavorites = true;
      });
    } else if (_favoritesScrollController.offset < 400 &&
        _showBackToTopButtonFavorites) {
      setState(() {
        _showBackToTopButtonFavorites = false;
      });
    }
  }

  void _scrollToTopAllGames() {
    _allGamesScrollController.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToTopFavorites() {
    _favoritesScrollController.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _onSearchChanged() {
    _filterGames();
  }

  void _onConsoleFilterChanged(String? selected) {
    if (selected == null) return;
    setState(() {
      _selectedConsole = selected;
    });
    _filterGames();
  }

  void _filterGames() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredAllGames =
          _allGames.where((game) {
            final matchesTitle = game.title.toLowerCase().contains(query);
            final matchesConsole =
                _selectedConsole == 'Todos' ||
                game.console.toLowerCase().contains(
                  _selectedConsole.toLowerCase(),
                );
            return matchesTitle && matchesConsole;
          }).toList();
      _favoriteGames =
          _allGames
              .where(
                (game) =>
                    _favoriteIds.contains(game.id) &&
                    game.title.toLowerCase().contains(query) &&
                    (_selectedConsole == 'Todos' ||
                        game.console.toLowerCase().contains(
                          _selectedConsole.toLowerCase(),
                        )),
              )
              .toList();
    });
  }

  void _refavorite(String gameId) async {
    await _favoriteService.addFavorite(gameId);
    await _loadFavorites(); // Recarrega a lista para refletir a mudança
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Jogo refavoritado!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _allGamesScrollController.dispose();
    _favoritesScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catálogo de Jogos'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [Tab(text: 'Todos'), Tab(text: 'Favoritos')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Aba de Todos os Jogos
          Padding(
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
                SizedBox(height: 12),
                DropdownButton<String>(
                  value: _selectedConsole,
                  onChanged: _onConsoleFilterChanged,
                  dropdownColor: Colors.grey[900],
                  iconEnabledColor: Colors.white70,
                  style: TextStyle(color: Colors.white),
                  items:
                      _consoles
                          .map(
                            (console) => DropdownMenuItem(
                              value: console,
                              child: Text(console),
                            ),
                          )
                          .toList(),
                ),
                SizedBox(height: 16),
                Expanded(
                  child:
                      _filteredAllGames.isEmpty
                          ? Center(
                            child: Text(
                              'Nenhum jogo encontrado.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                          )
                          : GridView.builder(
                            controller: _allGamesScrollController,
                            itemCount: _filteredAllGames.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                  childAspectRatio: 0.75,
                                ),
                            itemBuilder: (context, index) {
                              final game = _filteredAllGames[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) => GameDetailsPage(
                                            game: game,
                                            onFavoriteChanged: (
                                              gameId,
                                              isFavorite,
                                            ) {
                                              setState(() {
                                                final index = _allGames
                                                    .indexWhere(
                                                      (g) => g.id == gameId,
                                                    );
                                                if (index != -1) {
                                                  _allGames[index] =
                                                      _allGames[index].copyWith(
                                                        isFavorite: isFavorite,
                                                      );
                                                }
                                                if (isFavorite &&
                                                    !_favoriteGames.any(
                                                      (g) => g.id == gameId,
                                                    )) {
                                                  _favoriteGames.add(
                                                    _allGames.firstWhere(
                                                      (g) => g.id == gameId,
                                                    ),
                                                  );
                                                } else if (!isFavorite) {
                                                  _favoriteGames.removeWhere(
                                                    (g) => g.id == gameId,
                                                  );
                                                }
                                                if (isFavorite) {
                                                  _favoriteIds.add(gameId);
                                                } else {
                                                  _favoriteIds.remove(gameId);
                                                }
                                              });
                                            },
                                          ),
                                    ),
                                  ).then((value) {
                                    _loadFavorites();
                                  });
                                },
                                child: GameCard(
                                  game: game,
                                  onTap: () {},
                                  onFavoriteChanged: (
                                    gameId,
                                    isFavorite,
                                    willBeFavorite,
                                  ) {
                                    setState(() {
                                      if (isFavorite) {
                                        _favoriteIds.add(gameId);
                                        final gameToAdd = _allGames.firstWhere(
                                          (g) => g.id == gameId,
                                        );
                                        if (!_favoriteGames.any(
                                          (fav) => fav.id == gameToAdd.id,
                                        )) {
                                          _favoriteGames.add(gameToAdd);
                                        }
                                        _lastRemovedFavorite = null;
                                      } else {
                                        final removedGame = _allGames
                                            .firstWhere((g) => g.id == gameId);
                                        _favoriteIds.remove(gameId);
                                        _favoriteGames.removeWhere(
                                          (fav) => fav.id == gameId,
                                        );
                                        _lastRemovedFavorite = removedGame;
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Desfavoritado — Desfazer?',
                                            ),
                                            action: SnackBarAction(
                                              label: 'Desfazer',
                                              onPressed: () {
                                                if (_lastRemovedFavorite !=
                                                    null) {
                                                  _refavorite(
                                                    _lastRemovedFavorite!.id,
                                                  );
                                                  _lastRemovedFavorite = null;
                                                }
                                              },
                                            ),
                                            duration: Duration(seconds: 3),
                                          ),
                                        );
                                      }
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                ),
              ],
            ),
          ),
          // Aba de Favoritos
          Padding(
            padding: const EdgeInsets.all(12),
            child:
                _favoriteGames.isEmpty
                    ? Center(
                      child: Text(
                        'Nenhum jogo adicionado aos favoritos.',
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                    )
                    : GridView.builder(
                      controller: _favoritesScrollController,
                      itemCount: _favoriteGames.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        final game = _favoriteGames[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => GameDetailsPage(
                                      game: game,
                                      onFavoriteChanged: (gameId, isFavorite) {
                                        final index = _allGames.indexWhere(
                                          (g) => g.id == gameId,
                                        );
                                        if (index != -1) {
                                          setState(() {
                                            _allGames[index] = _allGames[index]
                                                .copyWith(
                                                  isFavorite: isFavorite,
                                                );
                                            if (isFavorite &&
                                                !_favoriteGames.any(
                                                  (g) => g.id == gameId,
                                                )) {
                                              _favoriteGames.add(
                                                _allGames.firstWhere(
                                                  (g) => g.id == gameId,
                                                ),
                                              );
                                              _favoriteIds.add(gameId);
                                            } else if (!isFavorite) {
                                              _favoriteGames.removeWhere(
                                                (g) => g.id == gameId,
                                              );
                                              _favoriteIds.remove(gameId);
                                            }
                                          });
                                        }
                                      },
                                    ),
                              ),
                            ).then((value) {
                              _loadFavorites();
                            });
                          },
                          child: GameCard(
                            game: game,
                            onTap: () {},
                            onFavoriteChanged: (
                              gameId,
                              isFavorite,
                              willBeFavorite,
                            ) {
                              setState(() {
                                if (isFavorite) {
                                  _favoriteIds.add(gameId);
                                  final gameToAdd = _allGames.firstWhere(
                                    (g) => g.id == gameId,
                                  );
                                  if (!_favoriteGames.any(
                                    (fav) => fav.id == gameToAdd.id,
                                  )) {
                                    _favoriteGames.add(gameToAdd);
                                  }
                                  _lastRemovedFavorite = null;
                                } else {
                                  final removedGame = _allGames.firstWhere(
                                    (g) => g.id == gameId,
                                  );
                                  _favoriteIds.remove(gameId);
                                  _favoriteGames.removeWhere(
                                    (fav) => fav.id == gameId,
                                  );
                                  _lastRemovedFavorite = removedGame;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Desfavoritado — Desfazer?',
                                      ),
                                      action: SnackBarAction(
                                        label: 'Desfazer',
                                        onPressed: () {
                                          if (_lastRemovedFavorite != null) {
                                            _refavorite(
                                              _lastRemovedFavorite!.id,
                                            );
                                            _lastRemovedFavorite = null;
                                          }
                                        },
                                      ),
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                }
                              });
                            },
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
      floatingActionButton:
          _tabController.index == 0
              ? (_showBackToTopButtonAllGames
                  ? FloatingActionButton(
                    onPressed: _scrollToTopAllGames,
                    tooltip: 'Voltar ao Topo',
                    child: Icon(Icons.arrow_upward),
                  )
                  : null)
              : (_showBackToTopButtonFavorites
                  ? FloatingActionButton(
                    onPressed: _scrollToTopFavorites,
                    tooltip: 'Voltar ao Topo',
                    child: Icon(Icons.arrow_upward),
                  )
                  : null),
    );
  }
}
