import 'package:dartz/dartz.dart';
import 'package:neoweekend/core/error/game/genre_failure.dart';
import 'package:neoweekend/core/services/game/game_service.dart';
import 'package:neoweekend/features/data/models/game/genre.dart';
import 'package:neoweekend/features/domain/repositories/game/genre_repository.dart';

class GenreRepositoryImpl extends GenreRepository{
  final GameService gameService;

  GenreRepositoryImpl(this.gameService);
  
  @override
  Future<Either<GenreFailure, List<Genre>>> getGenres() async{
    try {
      final genres = await gameService.fetchCategories();
      return Right(genres);
    } catch (e) {
      return Left(GenreFailure('Erro ao obter jogos: ${e.toString()}'));
    }
  }
}