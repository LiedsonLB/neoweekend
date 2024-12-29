import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neoweekend/core/constants/colors.dart';
import 'package:neoweekend/core/services/movie/movie_service.dart';
import 'package:neoweekend/core/services/movie/serie_service.dart';
import 'package:neoweekend/features/data/models/game/game.dart';
import 'package:neoweekend/features/data/models/movie/movie_model.dart';
import 'package:neoweekend/features/data/models/movie/serie_model.dart';
import 'package:neoweekend/core/services/game/game_service.dart';

class RandomPage extends StatefulWidget {
  const RandomPage({super.key});

  @override
  State<RandomPage> createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  final MovieService _movieService = MovieService();
  final SerieService _serieService = SerieService();
  final GameService _gameService = GameService();

  MovieModel? _randomMovie;
  SerieModel? _randomSerie;
  Game? _randomGame;
  bool _isLoading = false;
  bool _showResults = false;

  Future<void> _fetchRandomCombo() async {
    setState(() {
      _isLoading = true;
      _showResults = false;
    });

    bool success = false;

    while (!success) {
      try {
        final randomMoviePage =
            (List.generate(10, (index) => index + 1)..shuffle()).first;
        final randomSeriePage =
            (List.generate(10, (index) => index + 1)..shuffle()).first;
        final randomGamePage =
            (List.generate(10, (index) => index + 1)..shuffle()).first;

        final movies =
            await _movieService.fetchPopularMovies(page: randomMoviePage);
        final series = await _serieService.fetchSeries(page: randomSeriePage);
        final games = await _gameService.fetchGames(page: randomGamePage);

        if (movies.isNotEmpty && series.isNotEmpty && games.isNotEmpty) {
          final randomMovie = (movies..shuffle()).first;
          final randomSerie = (series..shuffle()).first;
          final randomGame = (games..shuffle()).first;

          setState(() {
            _randomMovie = randomMovie;
            _randomSerie = randomSerie;
            _randomGame = randomGame;
            _showResults = true;
            success = true;
          });
        } else {
          print("Dados insuficientes, tentando novamente...");
        }
      } catch (error) {
        print('Error fetching combo: $error');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }

      if (!success) {
        setState(() {
          _isLoading = true;
        });
        await Future.delayed(const Duration(seconds: 2));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _showResults
          ? _buildResultsGrid()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FaIcon(
                  FontAwesomeIcons.diceFour,
                  size: 100,
                  color: AppColors.pink,
                ),
                const SizedBox(height: 10),
                Container(
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Veja o Seu Combo NeoWeekend da semana',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.pink,
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Toda semana sorteamos um filme, um jogo, um livro e uma música para você aproveitar ao máximo este fim de semana',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 16, color: AppColors.lightGray),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.pink,
                          foregroundColor: AppColors.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 30.0),
                        ),
                        onPressed: _isLoading ? null : _fetchRandomCombo,
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.white),
                              )
                            : const Text('SORTEAR COMBO'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildResultsGrid() {
    final items = [
      {
        'imageUrl':
            'https://image.tmdb.org/t/p/w500${_randomMovie?.posterPath}',
        'label': '🎬 Filme: ${_randomMovie?.title}',
      },
      {
        'imageUrl':
            'https://image.tmdb.org/t/p/w500${_randomSerie?.posterPath}',
        'label': '📺 Série: ${_randomSerie?.name}',
      },
      {
        'imageUrl': _randomGame?.backgroundImage.toString(),
        'label': '🎮 Jogo: ${_randomGame?.name}',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 0.8,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image:
                      item['imageUrl'] != null && item['imageUrl']!.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(item['imageUrl']!),
                              fit: BoxFit.cover,
                            )
                          : null,
                ),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    Column(
                      children: [
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            item['label']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.pink,
              foregroundColor: AppColors.white,
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
            ),
            onPressed: _fetchRandomCombo,
            child: _isLoading
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                  )
                : const Text('SORTEAR NOVAMENTE'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
