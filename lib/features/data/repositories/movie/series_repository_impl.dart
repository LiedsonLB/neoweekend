import 'package:dartz/dartz.dart';
import 'package:neoweekend/core/error/movie/serie_failure.dart';
import 'package:neoweekend/core/services/movie/serie_service.dart';
import 'package:neoweekend/features/data/models/movie/serie_model.dart';
import 'package:neoweekend/features/domain/repositories/movie/series_repository.dart';

class SeriesRepositoryImpl implements SeriesRepository{
  SerieService serieService;

  SeriesRepositoryImpl(this.serieService);

  @override
  Future<Either<SerieFailure, List<SerieModel>>> getSeries({int page = 1}) async {
    try {
      final series = await serieService.fetchSeries(page: page);
      return Right(series);
    } catch (e) {
      return Left(SerieFailure('Erro ao obter séries: ${e.toString()}'));
    }
  }
}