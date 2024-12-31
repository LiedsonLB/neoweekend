import 'package:flutter_test/flutter_test.dart';
import 'package:neoweekend/core/services/movie/movie_service.dart';

void main() {
  group('MovieServiceTest ', () {
    late MovieService movieService;

    setUp(() {
      movieService = MovieService();
    });
    test('deve retornar uma lista de filmes', () async {
      // https://api.themoviedb.org/3/movie/popular
      final movies = await movieService.fetchPopularMovies();

      expect(movies, isNotNull);
      expect(movies.isNotEmpty, true);
    });

    test('deve retornar um filme com ID válido', () async {
      const validId = "335983";

      final movie = await movieService.fetchMovie(validId);

      expect(movie, isNotNull);
      expect(movie.id.toString(), validId.toString());
    });

    test('deve lançar uma exceção quando o filme não for encontrado', () async {
      const invalidId = "9999999999"; 

      expect(
        () async => await movieService.fetchMovie(invalidId),
        throwsA(isA<Exception>()),
      );
    });

    test('deve retornar uma lista de filmes pelo nome', () async {
      //https://api.themoviedb.org/3/search/movie?query=batman
      final movies = await movieService.fetchPopularMovies(query: "batman");

      expect(movies, isNotNull);
      expect(movies.isNotEmpty, true);
    });

    test('deve retornar uma lista de filmes pelo gênero', () async {
      //https://api.themoviedb.org/3/discover/movie?with_genres=28
      final movies = await movieService.fetchPopularMovies(category: "28");

      expect(movies, isNotNull);
      expect(movies.isNotEmpty, true);
    });
  });
}
