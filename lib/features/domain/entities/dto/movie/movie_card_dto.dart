import 'package:neoweekend/features/data/models/movie/movie.dart';

class MovieCardDTO {
  final int id;
  final String? backgroundImage;
  final String name;
  final String rating;
  

 MovieCardDTO({
    required this.id,
    required this.backgroundImage,
    required this.name,
    required this.rating,
  });

  factory MovieCardDTO.fromMovie(Movie movie) {
    return MovieCardDTO(
      id: movie.id,
      backgroundImage: "https://www.themoviedb.org/t/p/w500/${movie.posterPath}",
      name: movie.title,
      rating: movie.voteAverage,
    );
  }
}