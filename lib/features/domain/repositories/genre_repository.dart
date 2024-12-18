import 'package:dartz/dartz.dart';
import 'package:neoweekend/core/error/genre_failure.dart';
import 'package:neoweekend/features/data/models/genre.dart';

abstract class GenreRepository {
  Future<Either<GenreFailure, List<Genre>>> getGenres();
}