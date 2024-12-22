import 'package:neoweekend/features/data/models/game/game.dart';

class Genre {
  final int id;
  final String name;
  final String? imageBackground;
  final List<Game> games;

  Genre({
    required this.id,
    required this.name,
    this.imageBackground,
    this.games = const [],
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
      imageBackground: json['image_background'],
      games: (json['games'] as List<dynamic>?)
              ?.map((game) => Game.fromJson(game as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
