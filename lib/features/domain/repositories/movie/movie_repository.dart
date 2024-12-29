import 'package:dartz/dartz.dart';
import 'package:neoweekend/core/error/movie/genre_movies_failure.dart';
import 'package:neoweekend/core/error/movie/movie_failure.dart';
import 'package:neoweekend/features/data/models/movie/genre_movie_model.dart';
import 'package:neoweekend/features/data/models/movie/movie_model.dart';

abstract class MovieRepository {
  Future<Either<MovieFailure, List<MovieModel>>> getPopularMovies({String query = '', int page = 1});
  Future<Either<GenreMoviesFailure, List<GenreMoviesModel>>> getGenreMovies();
  Future<Either<MovieFailure, List<MovieModel>>> getGenre(String genre);
  Future<Either<MovieFailure, MovieModel>> getMovie(String id);
}