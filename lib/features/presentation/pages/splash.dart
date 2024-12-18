import 'dart:async';
import 'package:flutter/material.dart';
import 'package:neoweekend/core/constants/colors.dart';
import 'package:neoweekend/features/presentation/pages/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/logo.png', width: 100),
            const SizedBox(height: 10),
            Container(
              constraints: const BoxConstraints(maxWidth: 320),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Bem-vindo ao Neoweekend',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Confira livros, jogos, séries, filmes e músicas. Para seu fim de semana',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: AppColors.lightGray),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
