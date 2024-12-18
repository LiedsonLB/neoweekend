import 'package:dartz/dartz.dart';
import 'package:neoweekend/core/error/genre_failure.dart';
import 'package:neoweekend/features/data/models/genre.dart';
import 'package:neoweekend/features/domain/repositories/genre_repository.dart';

class GetGenres {
  final GenreRepository genreRepository;

  GetGenres(this.genreRepository);

  Future<Either<GenreFailure, List<Genre>>> call() async {
    return await genreRepository.getGenres();
  }
}