import 'package:flutter/material.dart';
import 'package:neoweekend/features/data/models/game/genre.dart';
import 'package:neoweekend/features/domain/usecases/game/get_genres.dart';

class GenreProvider with ChangeNotifier {
  final List<Genre> _genres = [];
  bool _isLoading = false;

  List<Genre> get genres => _genres;
  bool get isLoading => _isLoading;

  final GetGenres getgenres;

  GenreProvider({required this.getgenres});

  Future<void> getGenres() async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await getgenres.call();
      result.fold(
        (failure) {
          print('Failed to fetch genres: ${failure.message}');
        },
        (genres) {
          _genres.addAll(genres);
        },
      );
    } catch (e) {
      print('Error fetching genres: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
