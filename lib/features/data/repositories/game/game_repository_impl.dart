import 'package:dartz/dartz.dart';
import 'package:neoweekend/core/error/game/game_failure.dart';
import 'package:neoweekend/features/data/models/game/game.dart';
import 'package:neoweekend/core/services/game/game_service.dart';
import 'package:neoweekend/features/domain/repositories/game/game_repository.dart';

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
  Future<Either<GameFailure, Game>> getGame(String id) async {
    try {
      final game = await gameService.fetchGame(id);
      return Right(game);
    } catch (e) {
      return Left(GameFailure('Erro ao obter jogo: ${e.toString()}'));
    }
  }

}
