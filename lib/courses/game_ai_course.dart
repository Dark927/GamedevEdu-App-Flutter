import 'package:flutter/material.dart';
import '../screens/course/course_detail_screen.dart';
import '../models/course.dart';

class GameAIScreen extends StatelessWidget {
  final Course course;

  const GameAIScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return CourseDetailScreen(
      courseName: 'AI у відеоіграх',
      imagePath: 'Image/ai_gameDev-0.jpg',
      price: course.price,
      description:
          '### 🤖 AI у відеоіграх\n\n'
          'Цей курс навчить вас створювати **штучний інтелект** для відеоігор — '
          'від простих NPC до складних систем поведінки. Ви дізнаєтесь, як зробити ігровий світ '
          'реалістичнішим, а геймплей — динамічнішим і цікавішим.\n\n'
          '### 📌 Що ви вивчите у цьому курсі?\n'
          '- ✅ **Основи AI в іграх**: правила, скрипти, дерева рішень\n'
          '- ✅ **Системи станів (Finite State Machines)**\n'
          '- ✅ **Патрулювання, переслідування та втеча**\n'
          '- ✅ **Pathfinding з алгоритмами A\* і Dijkstra**\n'
          '- ✅ **Реалістична поведінка ворогів та союзників**\n'
          '- ✅ **AI для стратегій, RPG та шутерів**\n'
          '- ✅ **Планування, реактивність і адаптація**\n\n'
          '### 🎯 Для кого цей курс?\n'
          '- ✅ Розробники, які хочуть додати **розумних NPC** у свої ігри\n'
          '- ✅ Геймдизайнери, які хочуть зрозуміти **логіку AI**\n'
          '- ✅ Ті, хто прагне **покращити геймплей за допомогою інтелектуальної поведінки**\n\n'
          '### 🚀 Після проходження курсу ви зможете:\n'
          '- 🤖 **Створювати NPC з продуманими реакціями на дії гравця**\n'
          '- 🧠 **Писати власні AI-алгоритми та логіку поведінки**\n'
          '- 🗺️ **Реалізовувати навігацію та прийняття рішень**\n'
          '- 🧩 **Інтегрувати AI у складні ігрові системи**\n\n'
          '🔥 **Зробіть свої ігри живими та інтелектуальними — почніть прямо зараз!**',
    );
  }
}
