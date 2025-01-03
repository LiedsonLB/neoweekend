import 'package:dartz/dartz.dart';
import 'package:neoweekend/core/error/movie/genre_movies_failure.dart';
import 'package:neoweekend/core/error/movie/movie_failure.dart';
import 'package:neoweekend/core/services/movie/movie_service.dart';
import 'package:neoweekend/features/data/models/movie/genre_movie_model.dart';
import 'package:neoweekend/features/data/models/movie/movie_model.dart';
import 'package:neoweekend/features/domain/repositories/movie/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository{
  MovieService movieService;

  MovieRepositoryImpl(this.movieService);

  @override
  Future<Either<MovieFailure, List<MovieModel>>> getPopularMovies({String query = '', int page = 1}) async {
    try {
      final movies = await movieService.fetchPopularMovies(query: query, page: page);
      return Right(movies);
    } catch (e) {
      return Left(MovieFailure('Erro ao obter filmes: ${e.toString()}'));
    }
  }

  @override
  Future<Either<GenreMoviesFailure, List<GenreMoviesModel>>> getGenreMovies() async {
    try {
      final genreMovies = await movieService.fetchGenreMovies();
      return Right(genreMovies);
    } catch (e) {
      return Left(GenreMoviesFailure('Erro ao obter genero de filmes: ${e.toString()}'));
    }
  }

  @override
  Future<Either<MovieFailure, List<MovieModel>>> getGenre(String genre) async {
    try {
      final movies = await movieService.fetchPopularMovies(category: genre);
      return Right(movies);
    } catch (e) {
      return Left(MovieFailure('Erro ao obter filmes por genero: ${e.toString()}'));
    }
  }

  @override
  Future<Either<MovieFailure, MovieModel>> getMovie(String id) async {
    try {
      final movie = await movieService.fetchMovie(id);
      return Right(movie);
    } catch (e) {
      return Left(MovieFailure('Erro ao obter filme: ${e.toString()}'));
    }
  }
}