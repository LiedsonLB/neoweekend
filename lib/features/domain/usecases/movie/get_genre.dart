import 'package:dartz/dartz.dart';
import 'package:neoweekend/core/error/movie/movie_failure.dart';
import 'package:neoweekend/features/data/models/movie/movie_model.dart';
import 'package:neoweekend/features/domain/repositories/movie/movie_repository.dart';

class GetGenre {
  final MovieRepository repository;

  GetGenre(this.repository);

  Future<Either<MovieFailure, List<MovieModel>>> call(String genre) {
    return repository.getGenre(genre);
  }
}