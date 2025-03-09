import 'package:flutter/material.dart';
import '../screens/course_detail_screen.dart';

class UnrealCourseScreen extends StatelessWidget {
  const UnrealCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CourseDetailScreen(
      courseName: 'Unreal Engine: Основи',
      description:
          'Вивчіть основи Unreal Engine та навчіться створювати графічно насичені ігри.',
    );
  }
}
