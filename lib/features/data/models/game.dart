class Game {
  final int id;
  final String slug;
  final String name;
  final String? released;
  final String? backgroundImage;
  final double rating;
  final int metacritic;
  final List<String> platforms;

  Game({
    required this.id,
    required this.slug,
    required this.name,
    this.released,
    this.backgroundImage,
    required this.rating,
    required this.metacritic,
    required this.platforms,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      slug: json['slug'],
      name: json['name'],
      released: json['released'],
      backgroundImage: json['background_image'],
      rating: json['rating'].toDouble(),
      metacritic: json['metacritic'] ?? 0,
      platforms: (json['platforms'] as List<dynamic>?)
              ?.map((platform) => platform['platform']['name'] as String)
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'name': name,
      'released': released,
      'background_image': backgroundImage,
      'rating': rating,
      'metacritic': metacritic,
      'platforms': platforms,
    };
  }

  @override
  String toString() {
    return 'Game(id: $id, slug: $slug, name: $name, released: $released, backgroundImage: $backgroundImage, rating: $rating, metacritic: $metacritic, platforms: $platforms)';
  }
}