import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neoweekend/core/constants/colors.dart';
import 'package:neoweekend/features/data/models/movie/movie_model.dart';

class MovieInfoPage extends StatefulWidget {
  final MovieModel movie;

  const MovieInfoPage({super.key, required this.movie});

  @override
  State<MovieInfoPage> createState() => _MovieInfoPageState();
}

class _MovieInfoPageState extends State<MovieInfoPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: Text(
          widget.movie.title,
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
                  widget.movie.backdropPath ?? '',
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
                      widget.movie.year,
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
                    widget.movie.title,
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
                        widget.movie.voteAverage,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(width: 16),
                        Row(
                          children: [
                            Icon(
                              const FaIcon(FontAwesomeIcons.solidStar).icon,
                              color: AppColors.pink,
                              size: 20,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Metascore: ${widget.movie.voteAverage}',
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
                    widget.movie.overview ?? 'Sem descrição.',
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
                    children: widget.movie.genres
                        .map(
                          (platform) => Chip(
                            color: MaterialStateProperty.all(AppColors.pink),
                            shape: const RoundedRectangleBorder(
                              side: BorderSide(color: Colors.transparent),
                              borderRadius:
                                  BorderRadius.all(Radius.elliptical(5, 5)),
                            ),
                            label: Text(
                              platform.toString(),
                              style: const TextStyle(color: AppColors.white),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
