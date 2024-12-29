import 'package:flutter/material.dart';
//import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:neoweekend/core/services/game/game_service.dart';
import 'package:neoweekend/core/services/movie/movie_service.dart';
import 'package:neoweekend/core/services/movie/serie_service.dart';
import 'package:neoweekend/features/data/repositories/game/genre_repository_impl.dart';
import 'package:neoweekend/features/data/repositories/movie/movie_repository_impl.dart';
import 'package:neoweekend/features/data/repositories/movie/series_repository_impl.dart';
import 'package:neoweekend/features/domain/usecases/game/get_genres.dart';
import 'package:neoweekend/features/domain/usecases/movie/get_genre.dart';
import 'package:neoweekend/features/domain/usecases/movie/get_genre_movie.dart';
import 'package:neoweekend/features/domain/usecases/movie/get_popular_movies.dart';
import 'package:neoweekend/features/domain/usecases/movie/get_series.dart';
import 'package:neoweekend/features/presentation/controllers/game/game_controller.dart';
import 'package:neoweekend/features/presentation/controllers/game/genre_provider.dart';
import 'package:neoweekend/features/presentation/controllers/movie/genres_movies_provider.dart';
import 'package:neoweekend/features/presentation/controllers/movie/movies_provider.dart';
import 'package:neoweekend/features/presentation/controllers/movie/series_provider.dart';
import 'package:neoweekend/features/presentation/pages/splash.dart';
import 'package:neoweekend/features/domain/usecases/game/get_games.dart';
import 'package:neoweekend/features/data/repositories/game/game_repository_impl.dart';

import 'package:provider/provider.dart';

void main() async {
  runApp(const NeoWeekendApp());
}

class NeoWeekendApp extends StatelessWidget {
  const NeoWeekendApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => MovieService()),
        Provider(create: (context) => MovieRepositoryImpl(context.read<MovieService>())),
        Provider(create: (context) => GetPopularMovies(context.read<MovieRepositoryImpl>())),
        Provider(create: (context) => GetGenre(context.read<MovieRepositoryImpl>())),
        Provider(create: (context) => GetGenreMovies(context.read<MovieRepositoryImpl>())),
        Provider(create: (_) => SerieService()),
        Provider(create: (context) => SeriesRepositoryImpl(context.read<SerieService>())),
        Provider(create: (context) => GetSeries(context.read<SeriesRepositoryImpl>())),
        Provider(create: (_) => GameService()),
        Provider(create: (context) => GameRepositoryImpl(context.read<GameService>())),
        Provider(create: (context) => GenreRepositoryImpl(context.read<GameService>())),
        Provider(create: (context) => Getgames(context.read<GameRepositoryImpl>())),
        Provider(create: (context) => GetGenres(context.read<GenreRepositoryImpl>())),
        ChangeNotifierProvider(
          create: (context) => MoviesProvider(getPopularMoviesUseCase: context.read<GetPopularMovies>(), getGenreUseCase: context.read<GetGenre>()),
        ),
        ChangeNotifierProvider(
          create: (context) => GenreMoviesProvider(getGenreMoviesUseCase: context.read<GetGenreMovies>()),
        ),
        ChangeNotifierProvider(
          create: (context) => GameController(getGamesUseCase: context.read<Getgames>()),
        ),
        ChangeNotifierProvider(
          create: (context) => GenreProvider(getgenres: context.read<GetGenres>()),
        ),
        ChangeNotifierProvider(
          create: (context) => SeriesProvider(getPopularSeriesUseCase: context.read<GetSeries>()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NeoWeekend',
        home: SplashScreen(),
      ),
    );
  }
}
