import 'package:neoweekend/features/data/models/movie/genre_movie_model.dart';
import 'package:neoweekend/features/data/models/movie/movie_model.dart';

class MovieCardDTO {
  final int id;
  final String? backdropPath;
  final String? posterPath;
  final String title;
  final String voteAverage;
  final String? releaseDate;
  final String? overview;
  final List<GenreMoviesModel> genres;

  String? get backdropImageUrl {
    return backdropPath != null
        ? "https://www.themoviedb.org/t/p/w500/$backdropPath"
        : null;
  }

  String? get posterImageUrl {
    return posterPath != null
        ? "https://www.themoviedb.org/t/p/w500/$posterPath"
        : null;
  }

  MovieCardDTO({
    required this.id,
    this.backdropPath,
    this.posterPath,
    required this.title,
    required this.voteAverage,
    this.releaseDate,
    this.overview,
    required this.genres,
  });

  factory MovieCardDTO.fromJson(Map<String, dynamic> json) {
    var genresFromJson = json['genres'] as List<dynamic>?;

    // Verifique se genresFromJson não é nulo e se contém dados
    List<GenreMoviesModel> genresList = genresFromJson != null
        ? genresFromJson
            .map((genre) => GenreMoviesModel.fromJson(genre))
            .toList()
        : [];

    return MovieCardDTO(
      id: json['id'],
      title: json['title'],
      backdropPath: json['backdrop_path'],
      posterPath: json['poster_path'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      voteAverage: json['vote_average'].toString(),
      genres: genresList,
    );
  }

  factory MovieCardDTO.fromMovie(MovieModel movie) {
    return MovieCardDTO(
      id: movie.id,
      backdropPath: movie.backdropPath,
      posterPath: movie.posterPath,
      title: movie.title,
      voteAverage: movie.voteAverage,
      releaseDate: movie.releaseDate,
      overview: movie.overview,
      genres: movie.genres
          .map((genre) => GenreMoviesModel(id: genre.id, name: genre.name))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'backdrop_path': backdropImageUrl,
      'poster_path': posterImageUrl,
      'overview': overview,
      'release_date': releaseDate,
      'vote_average': voteAverage,
      'genres': genres.map((genre) => genre.toJson()).toList(),
    };
  }
}
