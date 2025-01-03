import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neoweekend/features/data/models/movie/genre_movie_model.dart';
import 'package:neoweekend/features/data/models/movie/movie_model.dart';

class MovieService {
  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = '5bb001c5375dd81c5afce60feb020138';

  Future<List<MovieModel>> fetchPopularMovies({
    String query = '',
    String category = '',
    int page = 1,
  }) async {
    final String endpoint =
        query.isNotEmpty ? '/3/search/movie' : '/3/discover/movie';

    final Map<String, String> queryParameters = {
      'api_key': _apiKey,
      'page': page.toString(),
    };

    if (query.isNotEmpty) {
      queryParameters['query'] = query;
    }

    if (category.isNotEmpty) {
      queryParameters['with_genres'] =
          category;
    }

    final Uri url = Uri.https(_baseUrl, endpoint, queryParameters);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List movies = data['results'];
      return movies.map((movie) => MovieModel.fromJson(movie)).toList();
    } else {
      print('Failed to fetch Movies: ${response.statusCode}');
      throw Exception('Failed to fetch Movies');
    }
  }

  Future<List<GenreMoviesModel>> fetchGenreMovies() async {
    final Uri url = Uri.https(_baseUrl, '/3/genre/movie/list', {
      'api_key': _apiKey,
      'language': 'pt-BR',
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List genres = data['genres'];
      return genres.map((genre) => GenreMoviesModel.fromJson(genre)).toList();
    } else {
      print('Failed to fetch Genres: ${response.statusCode}');
      throw Exception('Failed to fetch Genres');
    }
  }

  Future<MovieModel> fetchMovie(String id) async {
    final Uri url = Uri.https(_baseUrl, '/3/movie/$id', {
      'api_key': _apiKey,
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return MovieModel.fromJson(data);
    } else {
      print('Failed to load Movie: ${response.statusCode}');
      throw Exception('Failed to load Movie Exception');
    }
  }

  Future<List<MovieModel>> fetchMovieVideos(int id) async {
    final Uri url = Uri.https(_baseUrl, '/3/movie/$id/videos', {
      'api_key': _apiKey,
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List videos = data['results'];
      return videos.map((video) => MovieModel.fromJson(video)).toList();
    } else {
      print('Failed to load Movie Videos: ${response.statusCode}');
      throw Exception('Failed to load Movie Videos Exception');
    }
  }
}
