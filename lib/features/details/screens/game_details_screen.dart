import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_catalog_app/features/home/data/models/game_model.dart';
import 'package:game_catalog_app/features/reviews/models/game_review_model.dart';
import 'package:game_catalog_app/features/reviews/data/game_review_repository.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:game_catalog_app/features/favorites/providers/favorites_provider.dart';

class GameDetailsScreen extends ConsumerStatefulWidget {
  final GameModel game;

  const GameDetailsScreen({super.key, required this.game});

  @override
  ConsumerState<GameDetailsScreen> createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends ConsumerState<GameDetailsScreen> {
  double _rating = 3;
  String _comment = '';
  String _status = 'Quero jogar';
  List<GameReviewModel> _userReviews = [];

  final _statuses = ['Quero jogar', 'Jogando', 'Já joguei'];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadUserReviews();
  }

  Future<void> _loadUserReviews() async {
    final repo = ref.read(gameReviewRepositoryProvider);
    final reviews = await repo.getReviewsForGame(widget.game.id);
    setState(() {
      _userReviews = reviews;
    });
  }

  Future<void> _submitReview() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final review = GameReviewModel(
      userId: 'placeholderUser', // Substitua depois com o real ID do usuário
      gameId: widget.game.id,
      rating: _rating,
      comment: _comment,
      status: _status,
    );

    final repo = ref.read(gameReviewRepositoryProvider);
    await repo.saveReview(review);
    await _loadUserReviews();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Avaliação salva com sucesso!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final game = widget.game;
    final favorites = ref.watch(favoritesProvider);
    final isFavorite = favorites.any((g) => g.id == game.id);
    final releaseDate = game.released != null
        ? DateFormat.yMMMMd().format(DateTime.parse(game.released!))
        : 'Sem data';

    return Scaffold(
      appBar: AppBar(
        title: Text(game.name),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () {
              ref.read(favoritesProvider.notifier).toggleFavorite(game);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (game.backgroundImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(game.backgroundImage!),
              ),
            const SizedBox(height: 16),
            Text(game.name, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('Data de lançamento: $releaseDate'),
            const SizedBox(height: 8),
            if (game.rating != null)
              Text('Nota: ${game.rating!.toStringAsFixed(1)} ⭐'),
            const SizedBox(height: 12),
            if (game.genres != null && game.genres!.isNotEmpty) ...[
              Text('Gêneros:', style: Theme.of(context).textTheme.titleMedium),
              Wrap(
                spacing: 8,
                children:
                    game.genres!.map((g) => Chip(label: Text(g.name))).toList(),
              ),
            ],
            const SizedBox(height: 12),
            if (game.platforms != null && game.platforms!.isNotEmpty) ...[
              Text('Plataformas:',
                  style: Theme.of(context).textTheme.titleMedium),
              Wrap(
                spacing: 8,
                children: game.platforms!
                    .map((p) => Chip(label: Text(p.platform.name)))
                    .toList(),
              ),
            ],
            const SizedBox(height: 16),
            if (game.descriptionRaw != null)
              Text(
                game.descriptionRaw!,
                textAlign: TextAlign.justify,
              ),
            const Divider(height: 32),

            // Formulário de Avaliação
            Text('Avalie este jogo:',
                style: Theme.of(context).textTheme.titleMedium),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  RatingBar.builder(
                    initialRating: _rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemBuilder: (context, _) =>
                        const Icon(Icons.star, color: Colors.amber),
                    onRatingUpdate: (rating) {
                      setState(() => _rating = rating);
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: _status,
                    decoration: const InputDecoration(labelText: 'Status'),
                    items: _statuses
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) setState(() => _status = value);
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Comentário'),
                    maxLines: 3,
                    onSaved: (value) => _comment = value ?? '',
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _submitReview,
                    child: const Text('Salvar Avaliação'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
            if (_userReviews.isNotEmpty) ...[
              Text('Minhas avaliações anteriores:',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              ..._userReviews.map((review) => Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                          '${review.rating.toStringAsFixed(1)} ⭐ - ${review.status}'),
                      subtitle: Text(review.comment ?? 'Sem comentário'),
                    ),
                  )),
            ],
          ],
        ),
      ),
    );
  }
}
