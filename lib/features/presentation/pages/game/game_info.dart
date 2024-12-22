import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neoweekend/core/constants/colors.dart';
import 'package:neoweekend/features/data/models/game/game.dart';

class GameInfoPage extends StatefulWidget {
  final Game game;

  const GameInfoPage({super.key, required this.game});

  @override
  State<GameInfoPage> createState() => _GameInfoPageState();
}

class _GameInfoPageState extends State<GameInfoPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: Text(
          widget.game.name,
        ),
        backgroundColor: Colors.pink,
        foregroundColor: AppColors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  widget.game.backgroundImage ?? '',
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Container(height: 250, color: Colors.grey),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      widget.game.released ?? 'Data lançamento: Desconhecida',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.game.name,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Ratings
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow[700],
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.game.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(width: 16),
                      if (widget.game.metacritic > 0)
                        Row(
                          children: [
                            const Icon(
                              Icons.score,
                              color: AppColors.pink,
                              size: 20,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Metascore: ${widget.game.metacritic}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Description
                  const Text(
                    'Descrição:',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.game.descriptionRaw ?? 'Sem descrição.',
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Platforms
                  const Text(
                    'Plataformas:',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: widget.game.platforms
                        .map(
                          (platform) => Chip(
                            color: MaterialStateProperty.all(AppColors.pink),
                            shape: const RoundedRectangleBorder(
                              side: BorderSide(color: Colors.transparent),
                              borderRadius:
                                  BorderRadius.all(Radius.elliptical(5, 5)),
                            ),
                            avatar: _getPlatformIcon(platform) != null
                                ? FaIcon(
                                    _getPlatformIcon(platform),
                                    color: AppColors.white,
                                  )
                                : null,
                            label: Text(
                              platform,
                              style: const TextStyle(color: AppColors.white),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),

                  if (widget.game.requirements != null)
                    ...widget.game.requirements!.entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Card(
                          color: Colors.grey[200],
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  entry.key,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  entry.value,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData? _getPlatformIcon(String platform) {
    final lowerCasePlatform = platform.toLowerCase();

    if (lowerCasePlatform.contains('playstation')) {
      return FontAwesomeIcons.playstation;
    }
    if (lowerCasePlatform.contains('xbox')) {
      return FontAwesomeIcons.xbox;
    }

    if (lowerCasePlatform.contains('nintendo')) {
      return FontAwesomeIcons.gamepad;
    }
    switch (lowerCasePlatform) {
      case 'pc':
        return FontAwesomeIcons.desktop;
      case 'ios':
        return FontAwesomeIcons.mobile;
      case 'android':
        return FontAwesomeIcons.android;
      case 'app store':
        return FontAwesomeIcons.appStore;
      case 'linux':
        return FontAwesomeIcons.desktop;
      case 'macos':
        return FontAwesomeIcons.desktop;
      default:
        return null;
    }
  }
}
