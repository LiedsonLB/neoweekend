import 'package:dartz/dartz.dart';
import 'package:neoweekend/core/error/game_failure.dart';
import 'package:neoweekend/features/domain/repositories/game_repository.dart';
import 'package:neoweekend/features/data/models/game.dart';

class Getgames {
  final GameRepository gameRepository;

  Getgames(this.gameRepository);

  Future<Either<GameFailure, List<Game>>> call({String query = '', int page = 1}) async {
    return await gameRepository.getGames(query: query, page: page);
  }
}