import 'package:flutter/material.dart';
import 'package:neoweekend/core/services/movie/movie_service.dart';
import 'package:neoweekend/features/data/repositories/movie/movie_repository_impl.dart';
import 'package:neoweekend/features/domain/entities/dto/movie/movie_card_dto.dart';
import 'package:neoweekend/features/domain/usecases/movie/get_genre_movie.dart';

class MovieCard extends StatefulWidget {
  final MovieCardDTO movieCardDTO;

  final GetGenreMovies get_genre_movie = GetGenreMovies( MovieRepositoryImpl(MovieService()));

  MovieCard({super.key, required this.movieCardDTO});

  @override
  _MovieCardState createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  void _toMovieInfoPage() async {
    //final result = await widget.get_genre_movie.call(widget.movieCardDTO.id.toString());

    // result.fold(
    //   (failure) {
    //     print('Falha ao carregar o jogo: ${failure.message}');
    //   },
    //   (movie) {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => MovieInfoPage(movie: widget.movieCardDTO),
    //       ),
    //     );
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _toMovieInfoPage();
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.movieCardDTO.backgroundImage ?? ''),
            fit: BoxFit.cover,
            onError: (_, __) => const Icon(
              Icons.error,
              size: 50,
              color: Colors.white,
            ),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.1),
                Colors.black.withOpacity(0.7),
              ],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}