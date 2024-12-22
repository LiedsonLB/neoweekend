import 'package:flutter/material.dart';
import 'package:neoweekend/features/domain/entities/dto/movie/movie_card_dto.dart';
import 'package:neoweekend/features/presentation/pages/movie/movie_info_page.dart';

class MovieCard extends StatefulWidget {
  final MovieCardDTO movieCardDTO;

  const MovieCard({super.key, required this.movieCardDTO});

  @override
  _MovieCardState createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  void _toGameInfoPage() async {
    // final result = await widget.getgame.call(widget.gameCardDto.id.toString());

    // result.fold(
    //   (failure) {
    //     print('Falha ao carregar o jogo: ${failure.message}');
    //   },
    //   (game) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MovieInfoPage(),
          ),
        );
      // },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('Imagem clicada');
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