import 'package:neoweekend/features/data/models/game/game.dart';

class GameCardDTO {
  final int id;
  final String? backgroundImage;
  final String name;
  final double rating;
  final List<String> platforms;

  GameCardDTO({
    required this.id,
    required this.backgroundImage,
    required this.name,
    required this.rating,
    required this.platforms,
  });

  factory GameCardDTO.fromGame(Game game) {
    return GameCardDTO(
      id: game.id,
      backgroundImage: game.backgroundImage,
      name: game.name,
      rating: game.rating,
      platforms: game.platforms,
    );
  }
}