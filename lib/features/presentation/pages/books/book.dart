import 'package:flutter/material.dart';
import 'package:neoweekend/core/constants/colors.dart';

class BookSession extends StatefulWidget {
  const BookSession({super.key});

  @override
  State<BookSession> createState() => _BookSessionState();
}

class _BookSessionState extends State<BookSession> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Book Page',
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
