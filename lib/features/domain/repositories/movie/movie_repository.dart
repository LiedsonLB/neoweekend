import 'package:dartz/dartz.dart';
import 'package:neoweekend/core/error/movie/movie_failure.dart';
import 'package:neoweekend/features/data/models/movie/movie_model.dart';

abstract class MovieRepository {
  Future<Either<MovieFailure, List<MovieModel>>> getPopularMovies({String query = '', int page = 1});
  Future<Either<MovieFailure, MovieModel>> getMovie(String id);
}