class Game {
  final String id;
  final String title;
  final String console;
  final String description;
  final String imageUrl;
  final String subtitle;
  bool isFavorite;

  Game({
    required this.id,
    required this.title,
    required this.console,
    required this.description,
    required this.imageUrl,
    required this.subtitle,
    this.isFavorite = false,
  });

  Game copyWith({
    String? id,
    String? title,
    String? console,
    String? description,
    String? imageUrl,
    String? subtitle,
    bool? isFavorite,
  }) {
    return Game(
      id: id ?? this.id,
      title: title ?? this.title,
      console: console ?? this.console,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      subtitle: subtitle ?? this.subtitle,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
