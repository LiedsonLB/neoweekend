import 'package:dartz/dartz.dart';
import 'package:neoweekend/core/error/movie/serie_failure.dart';
import 'package:neoweekend/features/data/models/movie/serie_model.dart';
import 'package:neoweekend/features/domain/repositories/movie/series_repository.dart';

class GetSeries {
  final SeriesRepository _seriesRepository;

  GetSeries(this._seriesRepository);

  Future<Either<SerieFailure, List<SerieModel>>> call({
    String query = '',
    int page = 1,
  }) {
    return _seriesRepository.getSeries();
  }
}