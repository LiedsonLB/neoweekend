import 'package:dartz/dartz.dart';
import 'package:neoweekend/core/error/movie/movie_failure.dart';
import 'package:neoweekend/features/data/models/movie/movie_model.dart';
import 'package:neoweekend/features/domain/repositories/movie/movie_repository.dart';

class GetMovie {
  final MovieRepository _repository;

  GetMovie(this._repository);

  Future<Either<MovieFailure, MovieModel>> call(int id) {
    return _repository.getMovie(id.toString());
  }
}