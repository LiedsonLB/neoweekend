import 'package:dartz/dartz.dart';
import 'package:neoweekend/core/error/game/genre_failure.dart';
import 'package:neoweekend/features/data/models/game/genre.dart';

abstract class GenreRepository {
  Future<Either<GenreFailure, List<Genre>>> getGenres();
}