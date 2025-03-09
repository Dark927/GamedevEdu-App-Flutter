import 'package:flutter/material.dart';
import 'dart:async';
import 'catalog_screen.dart';
import '../widgets/animated_image.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0.0;
  Timer? _timer;

  List<String> images = [
    'Image/gameDev-1.jpg',
    'Image/gameDev-2.jpg',
    'Image/gameDev-3.png',
  ];

  int currentIndex = 0;
  double firstPos = 1.0;
  double secondPos = 20.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Автоматична зміна каруселі
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
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

    // Відстеження скролу
    _scrollController.addListener(() {
      if (mounted) {
        setState(() {
          _scrollPosition = _scrollController.offset;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  // Функція для перемикання на головну вкладку
  void goToHomeTab() {
    _tabController.animateTo(0);
    Navigator.pop(context); // Закриваємо Drawer після переходу
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: const Text('GameDev Courses')),
        drawer: _buildDrawer(), // Додаємо бургер-меню
        body: Column(
          children: [
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(icon: Icon(Icons.home), text: 'Головна'),
                Tab(icon: Icon(Icons.list), text: 'Каталог'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [_buildHomeScreen(), CatalogScreen()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Бургер-меню (Drawer)
  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurple),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.gamepad, size: 50, color: Colors.white),
                SizedBox(height: 10),
                Text(
                  'GameDev Hub',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Навчання геймдеву',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.deepPurple),
            title: const Text('Головна'),
            onTap: goToHomeTab, // Викликаємо зміну вкладки
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.deepPurple),
            title: const Text('Профіль'),
            onTap: () {
              // Поки профіль нічого не робить
              Navigator.pop(context); // Просто закриваємо Drawer
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHomeScreen() {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
          AnimatedOpacity(
            duration: const Duration(milliseconds: 800),
            opacity: _scrollPosition > firstPos ? 1.0 : 0.0,
            child: AnimatedScale(
              duration: const Duration(milliseconds: 800),
              scale: _scrollPosition > firstPos ? 1.0 : 0.8,
              child: const Text(
                'Ласкаво просимо до GameDev Hub',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 1000),
              opacity: _scrollPosition > secondPos ? 1.0 : 0.0,
              child: AnimatedScale(
                duration: const Duration(milliseconds: 1000),
                scale: _scrollPosition > secondPos ? 1.0 : 0.9,
                child: const Text(
                  'На цій платформі ви зможете освоїти основи та просунуті технології розробки ігор. '
                  'Від створення персонажів до програмування штучного інтелекту!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          AnimatedImage(
            imagePath: 'Image/gameDev-1.jpg',
            scrollPosition: _scrollPosition,
            appearAt: 250,
          ),
          AnimatedImage(
            imagePath: 'Image/gameDev-2.jpg',
            scrollPosition: _scrollPosition,
            appearAt: 450,
          ),
          AnimatedImage(
            imagePath: 'Image/gameDev-3.png',
            scrollPosition: _scrollPosition,
            appearAt: 650,
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
