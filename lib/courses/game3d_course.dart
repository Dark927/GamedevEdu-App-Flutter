import 'package:flutter/material.dart';
import '../screens/course/course_detail_screen.dart';
import '../models/courses/course.dart';

class Game3DScreen extends StatelessWidget {
  final Course course;

  const Game3DScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return CourseDetailScreen(
      courseName: '3D Game Art',
      imagePath: 'Image/3d_gameDev-0.jpg',
      price: course.price,
      description:
          '### 🎨 3D Game Art & Моделювання\n\n'
          'Цей курс навчить вас створювати **3D-моделі**, текстури та анімації для ігор. '
          'Ви дізнаєтесь, як працювати з інструментами, такими як **Blender**, **Maya** та **Substance Painter**, '
          'а також як імпортувати моделі у рушії, такі як **Unity** та **Unreal Engine**.\n\n'
          '### 📌 Що ви вивчите у цьому курсі?\n'
          '- ✅ **Основи 3D-моделювання (полігони, вершини, UV-розгортка)**\n'
          '- ✅ **Текстурування та матеріали (PBR, UV-мапи, шейдери)**\n'
          '- ✅ **Анімація персонажів та обʼєктів (rigging, keyframes)**\n'
          '- ✅ **Освітлення та візуальні ефекти у 3D**\n'
          '- ✅ **Експорт моделей у ігрові рушії (Unity, Unreal Engine)**\n\n'
          '### 🎯 Для кого цей курс?\n'
          '- ✅ Початківці, які хочуть розпочати карʼєру в **3D-геймдеві**\n'
          '- ✅ Художники, які хочуть перенести свої навички у **3D-графіку**\n'
          '- ✅ Гейм-дизайнери, які прагнуть створювати власні **3D-обʼєкти**\n\n'
          '### 🚀 Після проходження курсу ви зможете:\n'
          '- 🏗️ **Створювати якісні 3D-моделі для ігор**\n'
          '- 🎬 **Анімувати персонажів та предмети**\n'
          '- 🌍 **Експортувати свої роботи та використовувати в ігрових рушіях**\n\n'
          '🔥 **Розпочніть свою подорож у 3D-геймдев вже сьогодні!**',
    );
  }
}
