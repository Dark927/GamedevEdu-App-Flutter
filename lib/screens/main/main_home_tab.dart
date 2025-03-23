import 'dart:async';
import 'package:flutter/material.dart';
import '../../widgets/animated_image.dart';

class MainHomeTab extends StatefulWidget {
  const MainHomeTab({super.key});

  @override
  State<MainHomeTab> createState() => _MainHomeTabState();
}

class _MainHomeTabState extends State<MainHomeTab> {
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0.0;
  Timer? _timer;

  final List<String> images = [
    'Image/gameDev-1.jpg',
    'Image/gameDev-2.jpg',
    'Image/gameDev-3.png',
    'Image/design_gameDev-0.jpg',
  ];

  int currentIndex = 0;
  final double firstPos = 1.0;
  final double secondPos = 20.0;

  @override
  void initState() {
    super.initState();
    _startCarousel();
    _scrollController.addListener(() {
      setState(() {
        _scrollPosition = _scrollController.offset;
      });
    });
  }

  void _startCarousel() {
    _timer?.cancel();
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
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
