import 'package:flutter/material.dart';
import 'package:neoweekend/features/data/models/movie/genre_movie_model.dart';
import 'package:neoweekend/features/domain/usecases/movie/get_genre_movie.dart';

class GenreMoviesProvider with ChangeNotifier{
   List<GenreMoviesModel> _genreMovies = [];
   bool _isLoading = false;

  List<GenreMoviesModel> get genreMovies => _genreMovies;
  bool get isLoading => _isLoading;

  final GetGenreMovies getGenreMoviesUseCase;

  GenreMoviesProvider({required this.getGenreMoviesUseCase});

  Future<void> getGenreMovies() async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await getGenreMoviesUseCase.call();
      print('result GetGenreMovies: $result');
      result.fold(
        (failure) {
          print(failure.message);
        },
        (genreMovies) {
          _genreMovies = genreMovies;
        },
      );
    } catch (e) {
      print('Error fetching genre movies: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}