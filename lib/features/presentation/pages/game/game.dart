import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:neoweekend/core/constants/colors.dart';
import 'package:neoweekend/core/constants/widgets/search.dart';
import 'package:neoweekend/features/domain/entities/dto/game/game_card_dto.dart';
import 'package:neoweekend/features/presentation/controllers/game/game_controller.dart';
import 'package:neoweekend/features/presentation/controllers/game/genre_provider.dart';
import 'package:neoweekend/features/presentation/widgets/game/game_card.dart';
import 'package:neoweekend/features/presentation/widgets/game/category_card.dart';
import 'package:provider/provider.dart';

class GameSession extends StatefulWidget {
  const GameSession({super.key});

  @override
  State<GameSession> createState() => _GameSessionState();
}

class _GameSessionState extends State<GameSession> {
  late ScrollController _scrollController;
  String query = ''; // To track the search query

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    Future.microtask(() => context.read<GameController>().getGames());
    Future.microtask(() => context.read<GenreProvider>().getGenres());
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
      context.read<GameController>().getGames();
    }
  }

  @override
  Widget build(BuildContext context) {
    final gameController = context.watch<GameController>();
    final genreProvider = context.watch<GenreProvider>();

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
                      gameController.getGames(query: query, reset: true);
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
              'Todas as categorias',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: AppColors.pink,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

        if (genreProvider.genres.isNotEmpty && query.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: genreProvider.genres.length,
                itemBuilder: (context, index) {
                  final genre = genreProvider.genres[index];
                  return CategoryCard(genre: genre);
                },
              ),
            ),
          ),
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
        if (gameController.isLoading)
          const Expanded(
            child: Center(child: CircularProgressIndicator()),
          )
        else if (gameController.games.isEmpty)
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
                itemCount: gameController.games.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 3 / 4,
                ),
                itemBuilder: (context, index) {
                  final game = gameController.games[index];
                  final gameCardDTO = GameCardDTO.fromGame(game);
                  return GameCard(gameCardDto: gameCardDTO);
                },
              ),
            ),
          ),
      ],
    );
  }
}
