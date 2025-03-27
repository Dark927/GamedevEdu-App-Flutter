import 'package:flutter/material.dart';
import '../screens/course/course_detail_screen.dart';
import '../models/courses/course.dart';

class UnrealCourseScreen extends StatelessWidget {
  final Course course;

  const UnrealCourseScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return CourseDetailScreen(
      courseName: 'Unreal Engine: Основи',
      imagePath: 'Image/unreal_course-01.jpg',
      price: course.price,
      description:
          '### 🎮 Unreal Engine: Основи\n\n'
          'Вивчіть **Unreal Engine** — один із найпотужніших рушіїв для створення ігор та візуалізацій. '
          'Цей курс допоможе вам **з нуля** зануритися в роботу з рушієм, навіть без попереднього досвіду. '
          'Почніть створювати професійні, графічно насичені 3D-сцени та інтерактивні проєкти вже сьогодні.\n\n'
          '### 📌 Що ви вивчите у цьому курсі?\n'
          '- ✅ **Інтерфейс Unreal Engine** та основи навігації\n'
          '- ✅ **Створення сцен та робота з ландшафтами**\n'
          '- ✅ **Основи Blueprints — візуального програмування**\n'
          '- ✅ **Налаштування матеріалів, світла та камер**\n'
          '- ✅ **Фізика, колізії та прості анімації**\n'
          '- ✅ **Збірка гри та експорт для Windows/macOS**\n\n'
          '### 🎯 Для кого цей курс?\n'
          '- ✅ Новачки, які хочуть увійти у світ розробки ігор\n'
          '- ✅ Дизайнери, яким потрібна візуалізація сцен\n'
          '- ✅ Розробники, які хочуть познайомитися з Unreal Engine\n\n'
          '### 🚀 Після проходження курсу ви зможете:\n'
          '- 🛠️ **Створити свою першу інтерактивну 3D-сцену**\n'
          '- 💡 **Використовувати Blueprints для реалізації логіки**\n'
          '- 🌄 **Працювати з матеріалами, текстурами та ландшафтами**\n'
          '- 🚢 **Побудувати та запустити базовий ігровий проєкт**\n\n'
          '🔥 **Відкрийте двері у світ Unreal Engine — почніть просто зараз!**',
    );
  }
}
