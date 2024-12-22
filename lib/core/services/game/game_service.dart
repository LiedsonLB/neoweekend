import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neoweekend/features/data/models/game/genre.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../../features/data/models/game/game.dart';

class GameService {
  final baseUrlGames = 'https://api.rawg.io/api/games';
  final baseUrlGenres = 'https://api.rawg.io/api/genres';
  // final apiKey = dotenv.env['API_GAME_KEY'];
  final apiKey = 'e5d611d3169d4d49b5ebf091177a2c35';

  Future<List<Game>> fetchGames(
      {String query = '', String category = '', int page = 1}) async {
    
    // if (apiKey == null) {
    //   print('API Key not found in .env');
    //   throw Exception('API Key not found in .env');
    // }

    final Uri url = Uri.parse(
      '$baseUrlGames?key=$apiKey'
      '&search=${Uri.encodeComponent(query)}'
      '${category != '' ? '&genres=${Uri.encodeComponent(category)}' : ''}'
      '&page=$page',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List games = data['results'];
      return games.map((game) => Game.fromJson(game)).toList();
    } else {
      print('Failed to fetch games');
      throw Exception('Failed to fetch games');
    }
  }

  Future<List<Genre>> fetchCategories() async {
    // if (apiKey == null) {
    //   throw Exception('API Key not found in .env');
    // }

    final url = Uri.parse('$baseUrlGenres?key=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List genres = data['results'];
      return genres.map((genre) => Genre.fromJson(genre)).toList();
    } else {
      throw Exception('Failed to fetch genres');
    }
  }

  Future<Game> fetchGame(String id) async {
    final url = Uri.parse('$baseUrlGames/$id?key=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Game.fromJson(data);
    } else {
      throw Exception('Failed to load game');
    }
  }
}
