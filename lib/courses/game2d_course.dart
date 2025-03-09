import 'package:flutter/material.dart';
import '../screens/course_detail_screen.dart';

class Game2DScreen extends StatelessWidget {
  const Game2DScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CourseDetailScreen(
      courseName: '2D Game Development',
      description:
          'Дізнайтеся, як створювати 2D ігри з використанням популярних рушіїв.',
    );
  }
}
