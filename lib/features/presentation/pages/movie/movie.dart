import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:neoweekend/core/constants/colors.dart';
import 'package:neoweekend/core/constants/widgets/search.dart';
import 'package:neoweekend/features/domain/entities/dto/movie/movie_card_dto.dart';
import 'package:neoweekend/features/presentation/controllers/movie/genres_movies_provider.dart';
import 'package:neoweekend/features/presentation/controllers/movie/movies_provider.dart';
import 'package:neoweekend/features/presentation/widgets/movie/genre_movie_card.dart';
import 'package:neoweekend/features/presentation/widgets/movie/movie_card.dart';
import 'package:provider/provider.dart';

class MovieSession extends StatefulWidget {
  const MovieSession({super.key});

  @override
  State<MovieSession> createState() => _MovieSessionState();
}

class _MovieSessionState extends State<MovieSession> {
  late ScrollController _scrollController;
  String query = '';
  int? selectedGenreIndex;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    Future.microtask(() => context.read<MoviesProvider>().getPopularMovies());
    Future.microtask(
        () => context.read<GenreMoviesProvider>().getGenreMovies());
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<MoviesProvider>().getPopularMovies();
    }
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = context.watch<MoviesProvider>();
    final genreMoviesProvider = context.watch<GenreMoviesProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Search(
                  onChanged: (query) {
                    setState(() {
                      this.query = query;
                    });
                    if (query.isNotEmpty) {
                      movieProvider.getPopularMovies(query: query, reset: true);
                    }
                  },
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                padding: const EdgeInsets.all(10),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(AppColors.white),
                  foregroundColor: WidgetStateProperty.all(AppColors.black),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                onPressed: () {},
                icon: const FaIcon(FontAwesomeIcons.filter),
              ),
            ],
          ),
        ),
        if (query.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            child: Text(
              'Todos as categorias',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: AppColors.pink,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        if (genreMoviesProvider.genreMovies.isNotEmpty && query.isEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Container(
              height: 80,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: genreMoviesProvider.genreMovies.length,
                  itemBuilder: (context, index) {
                    final genre = genreMoviesProvider.genreMovies[index];
                    return Row(
                      children: [
                        GenreMoviesCard(
                          genre: genre,
                          isSelected: selectedGenreIndex == index,
                          onTap: () {
                            print(genre.id.toString());
                            setState(() {
                              selectedGenreIndex = index;
                            });
                            movieProvider.getGenre(genre.id.toString());
                          },
                        ),
                        const SizedBox(width: 10),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          child: Text(
            'Todos os filmes (${movieProvider.movies.length})',
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: AppColors.pink,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (movieProvider.isLoading)
          const Expanded(
            child: Center(child: CircularProgressIndicator()),
          )
        else if (movieProvider.movies.isEmpty)
          const Expanded(
            child: Center(
              child: Text(
                'Nenhum filme encontrado.',
                selectionColor: AppColors.white,
              ),
            ),
          )
        else
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: GridView.builder(
                key: const PageStorageKey('movie_list'),
                controller: _scrollController,
                itemCount: movieProvider.movies.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 3 / 4,
                ),
                itemBuilder: (context, index) {
                  final movie = movieProvider.movies[index];
                  final movieCardDto = MovieCardDTO.fromMovie(movie);
                  return MovieCard(movieCardDTO: movieCardDto);
                },
              ),
            ),
          ),
      ],
    );
  }
}