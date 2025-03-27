import 'package:flutter/material.dart';
import '../screens/course/course_detail_screen.dart';
import '../models/courses/course.dart';

class GameVRScreen extends StatelessWidget {
  final Course course;

  const GameVRScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return CourseDetailScreen(
      courseName: 'VR/AR для розробників',
      imagePath: 'Image/vr_gameDev-0.jpg',
      price: course.price,
      description:
          '### 🕶️ VR/AR для розробників\n\n'
          'Цей курс навчить вас розробляти **віртуальну (VR) та доповнену реальність (AR)**. '
          'Ви дізнаєтесь, як створювати інтерактивні середовища, працювати з 3D-об\'єктами, '
          'оптимізувати продуктивність та реалізовувати імерсивний досвід для користувачів.\n\n'
          '### 📌 Що ви вивчите у цьому курсі?\n'
          '- ✅ **Основи VR та AR**: концепції, відмінності, використання\n'
          '- ✅ **Робота з Unity та Unreal Engine** для VR/AR проєктів\n'
          '- ✅ **Інтеграція Oculus Rift, HTC Vive, PlayStation VR** та інших гарнітур\n'
          '- ✅ **Створення доповненої реальності (AR)** за допомогою ARKit та ARCore\n'
          '- ✅ **Генерація 3D-середовищ та їх оптимізація**\n'
          '- ✅ **Реалізація взаємодії користувача (рухи, жестові контролери, погляд)**\n'
          '- ✅ **Оптимізація FPS для VR-додатків та плавний рендеринг**\n\n'
          '### 🎯 Для кого цей курс?\n'
          '- ✅ Розробники, які хочуть працювати з **VR/AR технологіями**\n'
          '- ✅ 3D-дизайнери, які створюють **віртуальні світи та інтерфейси**\n'
          '- ✅ Геймдизайнери, які хочуть впровадити **іммерсивний досвід у свої ігри**\n\n'
          '### 🚀 Після проходження курсу ви зможете:\n'
          '- 🕶️ **Створювати ігри та додатки для VR і AR**\n'
          '- 🎮 **Працювати з VR-гарнітурами** (Oculus, HTC Vive, PSVR)\n'
          '- 🌍 **Створювати інтерактивні 3D-світи та персонажів**\n'
          '- 📱 **Розробляти AR-додатки для смартфонів** (ARKit, ARCore)\n'
          '- 🎥 **Оптимізувати графіку та продуктивність у VR-додатках**\n\n'
          '🔥 **Пориньте у світ VR/AR вже сьогодні та створюйте майбутнє!**',
    );
  }
}
