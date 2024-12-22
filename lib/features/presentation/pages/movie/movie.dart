import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:neoweekend/core/constants/colors.dart';
import 'package:neoweekend/core/constants/widgets/search.dart';
import 'package:neoweekend/features/domain/entities/dto/movie/movie_card_dto.dart';
import 'package:neoweekend/features/presentation/controllers/movie/movie_provider.dart';
import 'package:neoweekend/features/presentation/widgets/movie/movie_card.dart';
import 'package:provider/provider.dart';

class MovieSession extends StatefulWidget {
  const MovieSession({super.key});

  @override
  State<MovieSession> createState() => _MovieSessionState();
}

class _MovieSessionState extends State<MovieSession> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController = ScrollController()..addListener(_onScroll);
    Future.microtask(() => context.read<MovieProvider>().getPopularMovies());
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
      context.read<MovieProvider>().getPopularMovies();
    }
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = context.watch<MovieProvider>();

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
        // if (genreProvider.genres.isNotEmpty)
        //   Padding(
        //     padding: const EdgeInsets.symmetric(vertical: 10.0),
        //     child: SizedBox(
        //       height: 100,
        //       child: ListView.builder(
        //         scrollDirection: Axis.horizontal,
        //         itemCount: genreProvider.genres.length,
        //         itemBuilder: (context, index) {
        //           final genre = genreProvider.genres[index];
        //           return CategoryCard(genre: genre);
        //         },
        //       ),
        //     ),
        //   ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          child: Text(
            'Todos os jogos',
            textAlign: TextAlign.start,
            style: TextStyle(
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
                'Nenhum jogo encontrado.',
                selectionColor: AppColors.white,
              ),
            ),
          )
        else
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: GridView.builder(
                key: const PageStorageKey('game_list'),
                controller: _scrollController,
                itemCount: movieProvider.movies.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 3 / 4,
                ),
                itemBuilder: (context, index) {
                  final game = movieProvider.movies[index];
                  final movieCardDto = MovieCardDTO.fromMovie(game);
                  return MovieCard(movieCardDTO: movieCardDto);
                },
              ),
            ),
          ),
      ],
    );
  }
}
