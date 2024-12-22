import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neoweekend/features/data/models/movie/movie.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

class MovieService {
  final baseUrlMovies = 'https://api.themoviedb.org/3/movie/popular';
  final baseUrlSeries = 'https://api.themoviedb.org/3/discover/tv';
  // final apiKey = dotenv.env['API_GAME_KEY'];
  final apiKey = '5bb001c5375dd81c5afce60feb020138';

  Future<List<Movie>> fetchPopularMovies(
      {String query = '', String category = '', int page = 1}) async {
    // if (apiKey == null) {
    //   print('API Key not found in .env');
    //   throw Exception('API Key not found in .env');
    // }

    final Uri url = Uri.parse(
      '$baseUrlMovies?api_key=$apiKey'
      '&search=${Uri.encodeComponent(query)}'
      '${category != '' ? '&genres=${Uri.encodeComponent(category)}' : ''}'
      '&page=$page',
    );

    final response = await http.get(url);

    print(response.body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List movies = data['results'];
      print(movies);
      return movies.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      print('Failed to fetch Movie');
      throw Exception('Failed to fetch Movies');
    }
  }

  Future<List<Movie>> fetchSeries() async {
    // if (apiKey == null) {
    //   throw Exception('API Key not found in .env');
    // }

    final url = Uri.parse('$baseUrlSeries?key=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List series = data['results'];
      return series.map((serie) => Movie.fromJson(serie)).toList();
    } else {
      throw Exception('Failed to fetch series');
    }
  }

  Future<Movie> fetchMovie(String id) async {
    final url = Uri.parse('$baseUrlMovies/$id?key=$apiKey');
    final response = await http.get(url);

    print(response.body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Movie.fromJson(data);
    } else {
      throw Exception('Failed to load game');
    }
  }
}
