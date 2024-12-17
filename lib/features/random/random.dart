import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neoweekend/core/constants/colors.dart';

class RandomPage extends StatelessWidget {
  const RandomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const FaIcon(
          FontAwesomeIcons.diceFour,
          size: 100,
          color: AppColors.pink,
        ),
        const SizedBox(height: 10),
        Container(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Veja o Seu Combo NeoWeekend da semana',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.pink,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Toda semana sorteamos um filme, um jogo, um livro e uma música para você aproveitar ao máximo este fim de semana',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: AppColors.lightGray),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColors.pink),
                  foregroundColor: MaterialStateProperty.all(AppColors.white),
                ),
                onPressed: () {},
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                  child: Text('SORTEAR COMBO'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
