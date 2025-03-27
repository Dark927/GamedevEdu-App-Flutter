import 'dart:async';
import 'package:flutter/material.dart';

class MainHomeTab extends StatefulWidget {
  const MainHomeTab({super.key});

  @override
  State<MainHomeTab> createState() => _MainHomeTabState();
}

class _MainHomeTabState extends State<MainHomeTab> {
  final PageController _pageController = PageController();
  Timer? _timer;

  final List<String> images = [
    'Image/gameDev-1.jpg',
    'Image/gameDev-2.jpg',
    'Image/gameDev-3.png',
    'Image/design_gameDev-0.jpg',
  ];

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startCarousel();
  }

  void _startCarousel() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted || !_pageController.hasClients) {
        timer.cancel();
        return;
      }
      setState(() {
        currentIndex = (currentIndex + 1) % images.length;
      });
      _pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 40),
      children: [
        // Карусель
        SizedBox(
          height: 250,
          child: PageView.builder(
            controller: _pageController,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return AnimatedOpacity(
                duration: const Duration(milliseconds: 600),
                opacity: currentIndex == index ? 1.0 : 0.5,
                child: Image.asset(images[index], fit: BoxFit.cover),
              );
            },
          ),
        ),

        const SizedBox(height: 20),

        // Заголовок
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: const [
              Text(
                'Ласкаво просимо до GameDev Hub',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Платформа для всіх, хто хоче розробляти ігри — від новачків до професіоналів.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),

        const SizedBox(height: 30),

        _section(
          title: '🚀 Що ви знайдете на платформі?',
          content: [
            '🎮 Онлайн-курси з Unity, Unreal, геймдизайну, 2D/3D-графіки та AI.',
            '📚 Практичні проєкти, шаблони та ресурси.',
            '🎥 Відеоуроки українською мовою.',
            '👨‍🏫 Авторські курси від досвідчених розробників.',
            '📦 Доступ до матеріалів навіть після завершення курсу.',
          ],
        ),

        _section(
          title: '👤 Для кого ця платформа?',
          content: [
            '✅ Початківці, які хочуть вивчити основи розробки ігор.',
            '✅ Студенти технічних спеціальностей.',
            '✅ Професіонали, які хочуть розширити свій стек знань.',
            '✅ Геймдизайнери, художники та розробники інтерфейсів.',
          ],
        ),

        _section(
          title: '🛠 Як розпочати?',
          content: [
            '1️⃣ Зареєструйтесь або увійдіть у свій акаунт.',
            '2️⃣ Перейдіть у розділ "Каталог курсів".',
            '3️⃣ Оберіть курс та додайте його до кошика.',
            '4️⃣ Почніть навчання в будь-який зручний час!',
          ],
        ),

        _section(
          title: '📢 Відгуки та спільнота',
          content: [
            '💬 Залишайте коментарі, діліться прогресом та ставте питання у чатах курсів.',
            '🤝 Приєднуйтесь до Discord-серверу GameDev Hub.',
            '⭐ Більше 10 000 задоволених студентів!',
          ],
        ),

        const SizedBox(height: 30),
        _section(
          title: '💡 Порада від нас:',
          content: [
            '🧠 Найкращий спосіб вчитися — робити власні проєкти. Застосовуйте знання з кожного уроку на практиці!',
          ],
        ),
      ],
    );
  }

  Widget _section({required String title, required List<String> content}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 10),
          ...content.map((text) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 16),
                ),
              )),
        ],
      ),
    );
  }
}
