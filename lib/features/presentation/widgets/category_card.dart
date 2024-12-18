import 'package:flutter/material.dart';
import 'package:neoweekend/features/data/models/genre.dart'; // Supondo que você tenha a classe Genre

class CategoryCard extends StatelessWidget {
  final Genre genre;

  const CategoryCard({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      width: 150,
      height: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            genre.imageBackground != null
                ? Image.network(
                    genre.imageBackground!,
                    fit: BoxFit.cover,
                  )
                : Container(color: Colors.grey),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.black.withOpacity(0.5),
                child: Text(
                  genre.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  final List<Genre> genres;

  const CategoryList({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        itemBuilder: (context, index) {
          return CategoryCard(genre: genres[index]);
        },
      ),
    );
  }
}
