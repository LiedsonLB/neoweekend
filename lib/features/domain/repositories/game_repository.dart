import 'package:dartz/dartz.dart';
import 'package:neoweekend/core/error/game_failure.dart';
import 'package:neoweekend/features/data/models/game.dart';

abstract class GameRepository {
  Future<Either<GameFailure, List<Game>>> getGames({String query = '', int page = 1});
  Future<void> getGame(String id);
  Future<void> getSearch(String gameName);
}