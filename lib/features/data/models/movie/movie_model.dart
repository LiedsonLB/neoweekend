import 'package:neoweekend/features/data/models/movie/genre_movie_model.dart';

class MovieModel {
  final int id;
  final String title;
  final String releaseDate;
  final String? backdropPath;
  final String? posterPath;
  final String? overview;
  final String voteAverage;
  final String year;
  final List<GenreMoviesModel> genres;

  MovieModel({
    required this.id,
    required this.title,
    required this.releaseDate,
    this.backdropPath,
    this.posterPath,
    this.overview,
    required this.voteAverage,
    required this.year,
    required this.genres,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      releaseDate: json['release_date'],
      backdropPath: json['backdrop_path'],
      posterPath: json['poster_path'],
      overview: json['overview'],
      voteAverage: json['vote_average'].toString(),
      year: json['year'].toString(),
      genres: (json['genres'] as List<dynamic>?)
              ?.map((genreJson) => GenreMoviesModel.fromJson(genreJson))
              .toList() ??
          [],
    );
  }
}
