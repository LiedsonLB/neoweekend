import 'package:dartz/dartz.dart';
import 'package:neoweekend/core/error/movie/movie_failure.dart';
import 'package:neoweekend/features/data/models/movie/movie.dart';

abstract class MovieRepository {
  Future<Either<MovieFailure, List<Movie>>> getPopularMovies({String query = '', int page = 1});
  Future<Either<MovieFailure, Movie>> getMovie(String id);
}