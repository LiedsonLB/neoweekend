import 'package:flutter/material.dart';
import 'package:neoweekend/features/data/models/movie/movie_model.dart';
import 'package:neoweekend/features/domain/usecases/movie/get_popular_movies.dart';

class MovieProvider with ChangeNotifier {
  List<MovieModel> _movies = [];
  bool _isLoading = false;

  List<MovieModel> get movies => _movies;
  bool get isLoading => _isLoading;

  final GetPopularMovies getPopularMoviesUseCase;

  MovieProvider({required this.getPopularMoviesUseCase});

  int _currentPage = 1;

  int get currentPage => _currentPage;

  Future<void> getPopularMovies({String query = '', bool reset = false}) async {
    if (reset) {
      _currentPage = 1;
      _movies = [];
    }

    _isLoading = true;
    notifyListeners();

    try {
      final result = await getPopularMoviesUseCase.call(
        query: query,
        page: _currentPage,
      );
      result.fold(
        (failure) {
          print(failure.message);
        },
        (movies) {
          _movies.addAll(movies);
          _currentPage++;
        },
      );
    } catch (e) {
      print('Error fetching movies: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
