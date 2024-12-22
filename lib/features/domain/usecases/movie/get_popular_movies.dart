import 'package:dartz/dartz.dart';
import 'package:neoweekend/core/error/movie/movie_failure.dart';
import 'package:neoweekend/features/data/models/movie/movie.dart';
import 'package:neoweekend/features/domain/repositories/movie/movie_repository.dart';

class GetPopularMovies {
  final MovieRepository repository;

  GetPopularMovies(this.repository);

  Future<Either<MovieFailure, List<Movie>>> call({
    String query = '',
    int page = 1,
  }) async {
    return await repository.getPopularMovies(query: query, page: page);
  }
}
