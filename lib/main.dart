import 'package:flutter/material.dart';
import 'package:neoweekend/features/initial/splash.dart';

void main() {
  runApp(NeoWeekendApp());
}

class NeoWeekendApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Neoweekend',
      home: SplashScreen(),
    );
  }
}