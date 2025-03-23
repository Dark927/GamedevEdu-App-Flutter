import 'package:flutter/material.dart';
import '../models/course.dart';
import '../models/course_config.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: courseConfigs.keys.length,
      itemBuilder: (context, index) {
        String courseName = courseConfigs.keys.elementAt(index);
        CourseConfig config = courseConfigs[courseName]!;

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => config.builder()),
            );
          },
          child: LongPressDraggable<Course>(
            data: config.course,
            dragAnchorStrategy: pointerDragAnchorStrategy,
            feedback: Material(
              color: Colors.transparent,
              child: Opacity(
                opacity: 0.85,
                child: Card(
                  color: Colors.deepPurple.shade100,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      config.course.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            childWhenDragging: Opacity(
              opacity: 0.5,
              child: _buildCourseCard(config.course.name),
            ),
            child: _buildCourseCard(config.course.name),
          ),
        );
      },
    );
  }

  Widget _buildCourseCard(String courseName) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.school, color: Colors.deepPurple),
        title: Text(
          courseName,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
