import 'package:flutter/material.dart';
import 'package:neoweekend/core/constants/colors.dart';
import 'package:neoweekend/features/data/models/movie/genre_movie_model.dart';

class GenreMoviesCard extends StatelessWidget {
  final GenreMoviesModel genre;
  final bool isSelected; // Add this parameter to check if it's selected
  final VoidCallback onTap; // Add a callback for when the genre is tapped

  const GenreMoviesCard({
    super.key,
    required this.genre,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.pink : Colors.transparent,
          border: Border.all(
            color: isSelected ? AppColors.pink : AppColors.white,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            genre.name,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
