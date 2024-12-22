class Game {
  final int id;
  final String slug;
  final String name;
  final String? released;
  final String? backgroundImage;
  final double rating;
  final int metacritic;
  final List<String> platforms;
  final String? descriptionRaw;
  final Map<String, String>? requirements;

  Game({
    required this.id,
    required this.slug,
    required this.name,
    this.released,
    this.backgroundImage,
    required this.rating,
    required this.metacritic,
    required this.platforms,
    this.descriptionRaw,
    this.requirements,
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
      descriptionRaw: json['description_raw'],
      requirements: _extractRequirements(json['platforms']),
    );
  }

  static Map<String, String>? _extractRequirements(List<dynamic>? platforms) {
    if (platforms == null) return null;

    final requirementsMap = <String, String>{};

    for (var platform in platforms) {
      final platformName = platform['platform']['name'] as String?;
      final requirements = platform['requirements_en'] as Map<String, dynamic>?;

      if (platformName != null && requirements != null) {
        requirementsMap[platformName] = '''
      Minimum:
      ${requirements['minimum'] ?? 'Not available'}

      Recommended:
      ${requirements['recommended'] ?? 'Not available'}
      ''';
      }
    }

    return requirementsMap.isEmpty ? null : requirementsMap;
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
      'descriptionRaw': descriptionRaw,
      'requirements': requirements,
    };
  }

  @override
  String toString() {
    return '''
Game(
  id: $id, 
  slug: $slug, 
  name: $name, 
  released: $released, 
  backgroundImage: $backgroundImage, 
  rating: $rating, 
  metacritic: $metacritic, 
  platforms: $platforms, 
  description: $descriptionRaw, 
  requirements: $requirements
)
''';
  }
}
