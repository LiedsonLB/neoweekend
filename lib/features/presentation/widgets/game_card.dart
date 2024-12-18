import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neoweekend/core/constants/colors.dart';
import 'package:neoweekend/features/data/models/game.dart';

class GameCard extends StatelessWidget {
  final Game game;

  const GameCard({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(game.backgroundImage ?? ''),
          fit: BoxFit.cover,
          onError: (_, __) =>
              const Icon(Icons.error, size: 50, color: AppColors.white),
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
                game.name,
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
                  for (int i = 0; i < game.rating.toInt(); i++)
                    const Icon(
                      FontAwesomeIcons.solidStar,
                      size: 14,
                      color: Colors.amber,
                    ),
                  if (game.rating % 1 != 0)
                    const Icon(
                      FontAwesomeIcons.starHalfAlt,
                      size: 14,
                      color: Colors.amber,
                    ),
                  const SizedBox(width: 5),
                  Text(
                    game.rating.toStringAsFixed(1),
                    style:
                        const TextStyle(color: AppColors.white, fontSize: 12),
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
                        children: _getPlatformIcons(game.platforms),
                      ),
                    ),
                  ),
                ],
              )
            ],
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
      case 'mobile':
        return FontAwesomeIcons.gamepad;
      default:
        return null;
    }
  }
}
