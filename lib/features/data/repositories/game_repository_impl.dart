import 'package:dartz/dartz.dart';
import 'package:neoweekend/core/error/game_failure.dart';
import 'package:neoweekend/features/data/models/game.dart';
import 'package:neoweekend/core/services/game_service.dart';
import 'package:neoweekend/features/domain/repositories/game_repository.dart';

class GameRepositoryImpl implements GameRepository {
  final GameService gameService;

  GameRepositoryImpl(this.gameService);

  @override
  Future<Either<GameFailure, List<Game>>> getGames({String query = '', int page = 1}) async {
    try {
      final games = await gameService.fetchGames(query: query, page: page);
      return Right(games);
    } catch (e) {
      return Left(GameFailure('Erro ao obter jogos: ${e.toString()}'));
    }
  }

  @override
  Future<Game> getGame(String id) async {
    return gameService.fetchGame(id);
  }

  @override
  Future<List<Game>> getSearch(String gameName) async {
    return gameService.fetchGames(query: gameName);
  }
}
