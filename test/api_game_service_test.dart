import 'package:flutter_test/flutter_test.dart';
import 'package:neoweekend/core/services/game/game_service.dart';

void main() {
  group('GameService Tests', () {
    late GameService gameService;

    setUp(() {
      gameService = GameService();
    });
    test('Deve retornar uma lista de jogos', () async {
      // https://api.rawg.io/api/games
      final games = await gameService.fetchGames();

      expect(games, isNotNull);
      expect(games.isNotEmpty, true);
    });

    test('Deve retornar um jogo pelo id', () async {
      // https://api.rawg.io/api/games/1
      final game = await gameService.fetchGame("3498");

      expect(game, isNotNull);
      expect(game.id, 3498);
    });

    test('Deve retornar uma lista de jogos pelo nome', () async {
      // https://api.rawg.io/api/games?search=batman
      final games = await gameService.fetchGames(query: "grand theft auto");

      expect(games, isNotNull);
      expect(games.isNotEmpty, true);
    });

    test('Deve retornar uma lista de jogos pela categoria', () async {
      // https://api.rawg.io/api/games?genres=sports
      final games = await gameService.fetchGames(category: "sports");

      expect(games, isNotNull);
      expect(games.isNotEmpty, true);
    });

    test('Deve retornar a pagina pelo index', () async {
      // https://api.rawg.io/api/games?page=2
      final page1 = await gameService.fetchGames();
      final page2 = await gameService.fetchGames(page: 2);

      expect(page1, isNotNull);
      expect(page1.isNotEmpty, true);

      expect(page2, isNotNull);
      expect(page2.isNotEmpty, true);

      expect(page1, isNot(page2));
    });
  });
}
