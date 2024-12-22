import 'package:dartz/dartz.dart';
import 'package:neoweekend/core/error/game/game_failure.dart';
import 'package:neoweekend/features/domain/repositories/game/game_repository.dart';
import 'package:neoweekend/features/data/models/game/game.dart';

class Getgame {
  final GameRepository gameRepository;

  Getgame(this.gameRepository);

  Future<Either<GameFailure, Game>> call(String id) async {
    return await gameRepository.getGame(id);
  }
}