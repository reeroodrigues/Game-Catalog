import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/platform_model.dart';
import '../../filters/models/genre_model.dart';
import '../../filters/providers/filter_provider.dart';

class FilterChipsRow extends ConsumerWidget {
  final bool isPlatform;

  const FilterChipsRow({super.key, required this.isPlatform});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedId = isPlatform
        ? ref.watch(selectedPlatformIdProvider)
        : ref.watch(selectedGenreIdProvider);

    final itemsAsync =
        isPlatform ? ref.watch(platformsProvider) : ref.watch(genresProvider);

    return itemsAsync.when(
      data: (items) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: items.map<Widget>((item) {
              final int id = isPlatform
                  ? (item as PlatformModel).id
                  : (item as GenreModel).id;
              final String name = isPlatform
                  ? (item as PlatformModel).name
                  : (item as GenreModel).name;

              final isSelected = selectedId == id;

              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ChoiceChip(
                  label: Text(name),
                  selected: isSelected,
                  onSelected: (_) {
                    if (isPlatform) {
                      ref.read(selectedPlatformIdProvider.notifier).state =
                          isSelected ? null : id;
                    } else {
                      ref.read(selectedGenreIdProvider.notifier).state =
                          isSelected ? null : id;
                    }
                  },
                ),
              );
            }).toList(),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Text(
        'Erro ao carregar ${isPlatform ? 'plataformas' : 'gêneros'}: $error',
      ),
    );
  }
}
