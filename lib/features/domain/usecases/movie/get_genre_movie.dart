import 'package:dartz/dartz.dart';
import 'package:neoweekend/core/error/movie/genre_movies_failure.dart';
import 'package:neoweekend/features/data/models/movie/genre_movie_model.dart';
import 'package:neoweekend/features/domain/repositories/movie/movie_repository.dart';

class GetGenreMovies {
  final MovieRepository repository;

  GetGenreMovies(this.repository);

  Future<Either<GenreMoviesFailure, List<GenreMoviesModel>>> call() {
    return repository.getGenreMovies();
  }
}