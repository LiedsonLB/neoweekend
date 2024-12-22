import 'package:dartz/dartz.dart';
import 'package:neoweekend/core/error/game/game_failure.dart';
import 'package:neoweekend/features/data/models/game/game.dart';

abstract class GameRepository {
  Future<Either<GameFailure, List<Game>>> getGames({String query = '', int page = 1});
  Future<Either<GameFailure, Game>> getGame(String id);
}