import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neoweekend/features/data/models/movie/serie_model.dart';

class SerieService {
  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = '5bb001c5375dd81c5afce60feb020138';

  Future<List<SerieModel>> fetchSeries({int page = 1}) async {
    final Uri url = Uri.https(_baseUrl, '/3/discover/tv', {
      'api_key': _apiKey,
      'page': page.toString(),
    });

    print('URL Series: $url');
    // https://api.themoviedb.org/3/discover/tv?api_key=5bb001c5375dd81c5afce60feb020138&page=1

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List series = data['results'];
      return series.map((serie) => SerieModel.fromJson(serie)).toList();
    } else {
      print('Failed to fetch Series: ${response.statusCode}');
      throw Exception('Failed to fetch Series');
    }
  }
}