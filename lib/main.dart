import 'package:flutter/material.dart';
//import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:neoweekend/core/services/game_service.dart';
import 'package:neoweekend/features/data/repositories/genre_repository_impl.dart';
import 'package:neoweekend/features/domain/usecases/get_genres.dart';
import 'package:neoweekend/features/presentation/controllers/game_provider.dart';
import 'package:neoweekend/features/presentation/controllers/genre_provider.dart';
import 'package:neoweekend/features/presentation/pages/splash.dart';
import 'package:neoweekend/features/domain/usecases/get_games.dart';
import 'package:neoweekend/features/data/repositories/game_repository_impl.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const NeoWeekendApp());
}

class NeoWeekendApp extends StatelessWidget {
  const NeoWeekendApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => GameService()),
        Provider(create: (context) => GameRepositoryImpl(context.read<GameService>())),
        Provider(create: (context) => GenreRepositoryImpl(context.read<GameService>())),
        Provider(create: (context) => Getgames(context.read<GameRepositoryImpl>())),
        Provider(create: (context) => GetGenres(context.read<GenreRepositoryImpl>())),
        ChangeNotifierProvider(
          create: (context) => GameProvider(getgames: context.read<Getgames>()),
        ),
        ChangeNotifierProvider(
          create: (context) => GenreProvider(getgenres: context.read<GetGenres>()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NeoWeekend',
        home: SplashScreen(),
      ),
    );
  }
}
