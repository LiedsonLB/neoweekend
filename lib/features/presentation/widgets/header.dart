import 'package:flutter/material.dart';
import 'package:neoweekend/core/constants/colors.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(image: AssetImage('assets/icons/logo.png'), width: 40),
        SizedBox(width: 5),
        Text(
          'Neoweekend',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
