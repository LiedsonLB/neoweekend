import 'package:flutter/material.dart';
import 'package:neoweekend/core/constants/colors.dart';

class MusicSession extends StatefulWidget {
  const MusicSession({super.key});

  @override
  State<MusicSession> createState() => _MusicSessionState();
}

class _MusicSessionState extends State<MusicSession> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Music Page',
          style: TextStyle(
            color: AppColors.pink,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Em breve',
          style: TextStyle(
            color: AppColors.lightGray,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
