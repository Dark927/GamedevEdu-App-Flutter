import 'package:flutter/material.dart';
import '../screens/course_detail_screen.dart';

class Game3DScreen extends StatelessWidget {
  const Game3DScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CourseDetailScreen(
      courseName: '3D Game Art',
      description: 'Освойте 3D моделювання, текстуринг та анімацію для ігор.',
    );
  }
}
