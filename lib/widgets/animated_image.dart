import 'package:flutter/material.dart';

// Виділений клас для анімованих зображень
class AnimatedImage extends StatelessWidget {
  final String imagePath;
  final double scrollPosition;
  final double appearAt;

  const AnimatedImage({
    super.key,
    required this.imagePath,
    required this.scrollPosition,
    required this.appearAt,
  });

  @override
  Widget build(BuildContext context) {
    double opacity = (scrollPosition > appearAt) ? 1.0 : 0.0;
    double scale = (scrollPosition > appearAt) ? 1.0 : 0.8;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 800),
        opacity: opacity,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 800),
          scale: scale,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(imagePath, width: 300, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
