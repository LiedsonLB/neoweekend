import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neoweekend/core/constants/colors.dart';
import 'package:neoweekend/features/presentation/pages/books/book.dart';
import 'package:neoweekend/features/presentation/pages/game/game.dart';
import 'package:neoweekend/features/presentation/pages/movie/movie.dart';
import 'package:neoweekend/features/presentation/pages/musics/music.dart';
import 'package:neoweekend/features/presentation/pages/random/random.dart';
import 'package:neoweekend/core/constants/widgets/header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 2;

  final List<Widget> _screens = const [
    Center(child: MovieSession()),
    Center(child: BookSession()),
    Center(child: RandomPage()),
    Center(child: GameSession()),
    Center(child: MusicSession()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: const Header(),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.userCircle,
                color: AppColors.pink,
                size: 30,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.black,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.pink,
        unselectedItemColor: AppColors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.clapperboard),
            label: 'Filmes',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.book),
            label: 'Livros',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.dice),
            label: 'Sortear',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.gamepad),
            label: 'Jogos',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.music),
            label: 'Músicas',
          ),
        ],
      ),
    );
  }
}
