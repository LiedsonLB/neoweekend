import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neoweekend/core/constants/colors.dart';
import 'package:neoweekend/core/services/game/game_service.dart';
import 'package:neoweekend/features/data/repositories/game/game_repository_impl.dart';
import 'package:neoweekend/features/domain/entities/dto/game/game_card_dto.dart';
import 'package:neoweekend/features/domain/usecases/game/get_game.dart';
import 'package:neoweekend/features/presentation/pages/game/game_info.dart';

class GameCard extends StatefulWidget {
  final GameCardDTO gameCardDto;

  final Getgame getgame = Getgame(GameRepositoryImpl(GameService()));

  GameCard({super.key, required this.gameCardDto});

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  void _toGameInfoPage() async {
    final result = await widget.getgame.call(widget.gameCardDto.id.toString());

    result.fold(
      (failure) {
        print('Falha ao carregar o jogo: ${failure.message}');
      },
      (game) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameInfoPage(game: game),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toGameInfoPage,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.gameCardDto.backgroundImage ?? ''),
            fit: BoxFit.cover,
            onError: (_, __) => const Icon(
              Icons.error,
              size: 50,
              color: AppColors.white,
            ),
          ),
          borderRadius: BorderRadius.circular(10),
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
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.gameCardDto.name,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    for (int i = 0; i < widget.gameCardDto.rating.toInt(); i++)
                      const Icon(
                        FontAwesomeIcons.solidStar,
                        size: 14,
                        color: Colors.amber,
                      ),
                    if (widget.gameCardDto.rating % 1 != 0)
                      const Icon(
                        FontAwesomeIcons.starHalfAlt,
                        size: 14,
                        color: Colors.amber,
                      ),
                    const SizedBox(width: 5),
                    Text(
                      widget.gameCardDto.rating.toStringAsFixed(1),
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _getPlatformIcons(widget.gameCardDto.platforms),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _getPlatformIcons(List<String> platforms) {
    Set<String> displayedPlatforms = {};

    return platforms.map((platform) {
      final icon = _getPlatformIcon(platform);
      if (icon != null && !displayedPlatforms.contains(platform)) {
        displayedPlatforms.add(platform);
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: FaIcon(
            icon,
            size: 14,
            color: AppColors.lightGray,
          ),
        );
      }
      return const SizedBox();
    }).toList();
  }

  IconData? _getPlatformIcon(String platform) {
    final lowerCasePlatform = platform.toLowerCase();

    if (lowerCasePlatform.contains('playstation')) {
      return FontAwesomeIcons.playstation;
    }
    if (lowerCasePlatform.contains('xbox')) {
      return FontAwesomeIcons.xbox;
    }
    switch (lowerCasePlatform) {
      case 'pc':
        return FontAwesomeIcons.desktop;
      case 'nintendo':
        return FontAwesomeIcons.gamepad;
      case 'ios':
        return FontAwesomeIcons.mobile;
      case 'android':
        return FontAwesomeIcons.android;
      case 'app store':
        return FontAwesomeIcons.appStore;
      default:
        return null;
    }
  }
}
