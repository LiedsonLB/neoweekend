import 'package:dartz/dartz.dart';
import 'package:neoweekend/core/error/game/genre_failure.dart';
import 'package:neoweekend/features/data/models/game/genre.dart';
import 'package:neoweekend/features/domain/repositories/game/genre_repository.dart';

class GetGenres {
  final GenreRepository genreRepository;

  GetGenres(this.genreRepository);

  Future<Either<GenreFailure, List<Genre>>> call() async {
    return await genreRepository.getGenres();
  }
}