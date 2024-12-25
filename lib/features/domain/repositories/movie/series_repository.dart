import 'package:dartz/dartz.dart';
import 'package:neoweekend/core/error/movie/serie_failure.dart';
import 'package:neoweekend/features/data/models/movie/serie_model.dart';

abstract class SeriesRepository {
  Future<Either<SerieFailure, List<SerieModel>>> getSeries({int page = 1});
}