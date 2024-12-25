import 'package:flutter/material.dart';
import 'package:neoweekend/features/data/models/movie/serie_model.dart';
import 'package:neoweekend/features/domain/usecases/movie/get_series.dart';

class SeriesProvider with ChangeNotifier {
  List<SerieModel> _series = [];
  bool _isLoading = false;

  List<SerieModel> get series => _series;
  bool get isLoading => _isLoading;

  final GetSeries getPopularSeriesUseCase;

  SeriesProvider({required this.getPopularSeriesUseCase});

  int _currentPage = 1;

  int get currentPage => _currentPage;

  Future<void> getPopularSeries({String query = '', bool reset = false}) async {
    if (reset) {
      _currentPage = 1;
      _series = [];
    }

    _isLoading = true;
    notifyListeners();

    try {
      final result = await getPopularSeriesUseCase.call(
        page: _currentPage,
      );
      result.fold(
        (failure) {
          print(failure.message);
        },
        (series) {
          _series.addAll(series);
          _currentPage++;
        },
      );
    } catch (e) {
      print('Error fetching series: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}