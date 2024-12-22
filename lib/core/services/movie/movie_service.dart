import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neoweekend/features/data/models/movie/movie.dart';

class MovieService {
  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = '5bb001c5375dd81c5afce60feb020138';

  Future<List<Movie>> fetchPopularMovies({
    String query = '',
    String category = '',
    int page = 1,
  }) async {
    final String endpoint = query.isNotEmpty ? '/3/search/movie' : '/3/movie/popular';

    final Map<String, String> queryParameters = {
      'api_key': _apiKey,
      'page': page.toString(),
    };

    if (query.isNotEmpty) {
      queryParameters['query'] = query;
    }

    if (category.isNotEmpty) {
      queryParameters['with_genres'] = category;
    }

    final Uri url = Uri.https(_baseUrl, endpoint, queryParameters);

    print('URL: $url');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List movies = data['results'];
      return movies.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      print('Failed to fetch Movies: ${response.statusCode}');
      throw Exception('Failed to fetch Movies');
    }
  }

  Future<List<Movie>> fetchSeries({int page = 1}) async {
    final Uri url = Uri.https(_baseUrl, '/3/discover/tv', {
      'api_key': _apiKey,
      'page': page.toString(),
    });

    print('URL: $url');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List series = data['results'];
      return series.map((serie) => Movie.fromJson(serie)).toList();
    } else {
      print('Failed to fetch Series: ${response.statusCode}');
      throw Exception('Failed to fetch Series');
    }
  }

  Future<Movie> fetchMovie(String id) async {
    final Uri url = Uri.https(_baseUrl, '/3/movie/$id', {
      'api_key': _apiKey,
    });

    print('URL: $url');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Movie.fromJson(data);
    } else {
      print('Failed to load Movie: ${response.statusCode}');
      throw Exception('Failed to load Movie');
    }
  }
}
