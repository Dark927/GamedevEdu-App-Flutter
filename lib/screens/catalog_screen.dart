import 'package:flutter/material.dart';
import '../courses/courses.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  Map<String, Widget Function()> get gameDevCourses => {
    'Unity для початківців': () => UnityCourseScreen(),
    // 'Unreal Engine: Основи': () => UnrealCourseScreen(onGoHome: onGoHome),
    // '2D Game Development': () => Game2DScreen(onGoHome: onGoHome),
    // '3D Game Art': () => Game3DScreen(onGoHome: onGoHome),
    'Game Design Basics': () => GameDesignScreen(),
    // 'AI у відеоіграх': () => GameAIScreen(onGoHome: onGoHome),
    'VR/AR для розробників': () => GameVRScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: gameDevCourses.keys.length,
      itemBuilder: (context, index) {
        String courseName = gameDevCourses.keys.elementAt(index);
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: const Icon(Icons.school, color: Colors.deepPurple),
            title: Text(
              courseName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => gameDevCourses[courseName]!(),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
