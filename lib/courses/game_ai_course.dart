import 'package:flutter/material.dart';
import '../screens/course_detail_screen.dart';

class GameAIScreen extends StatelessWidget {
  const GameAIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CourseDetailScreen(
      courseName: 'AI у відеоіграх',
      description:
          'Досліджуйте штучний інтелект у відеоіграх та створюйте розумних NPC.',
    );
  }
}