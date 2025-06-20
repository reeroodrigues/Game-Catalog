import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/widgets/game_card.dart';
import '../providers/game_providers.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import '../../filters/widgets/filter_chips_row.dart';
import '../../../shared/widgets/game_card_shimmer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref.read(searchQueryProvider.notifier).state = query;
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gamesAsync = ref.watch(gamesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Jogos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              context.push('/favorites');
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Pesquisar jogos...',
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: FilterChipsRow(isPlatform: true),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: FilterChipsRow(isPlatform: false),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: gamesAsync.when(
              data: (games) => games.isEmpty
                  ? const Center(child: Text('Nenhum jogo encontrado.'))
                  : GridView.builder(
                      padding: const EdgeInsets.all(12),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.68,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: games.length,
                      itemBuilder: (context, index) {
                        return GameCard(game: games[index]);
                      },
                    ),
              loading: () => GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.of(context).size.width > 600 ? 4 : 2,
                  childAspectRatio: 0.68,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: 6,
                itemBuilder: (context, index) => const GameCardShimmer(),
              ),
              error: (error, _) => Center(child: Text('Erro: $error')),
            ),
          ),
        ],
      ),
    );
  }
}
