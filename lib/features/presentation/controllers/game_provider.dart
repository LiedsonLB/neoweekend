import 'package:flutter/material.dart';
import 'package:neoweekend/features/data/models/game.dart';
import 'package:neoweekend/features/domain/usecases/get_games.dart';

class GameProvider with ChangeNotifier {
  List<Game> _games = [];
  bool _isLoading = false;

  List<Game> get games => _games;
  bool get isLoading => _isLoading;

  final Getgames getgames;

  GameProvider({required this.getgames});

  int _currentPage = 1;

  int get currentPage => _currentPage;

  Future<void> getGames({String query = '', bool reset = false}) async {
    if (reset) {
      _currentPage = 1;
      _games = [];
    }
    _isLoading = true;
    notifyListeners();

    try {
      final result = await getgames.call(query: query, page: _currentPage);
      result.fold(
        (failure) {
          print('Failed to fetch games: ${failure.message}');
        },
        (games) {
          _games.addAll(games);
          _currentPage++;
        },
      );
    } catch (e) {
      print('Error fetching games: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
