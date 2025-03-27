import 'package:flutter/material.dart';
import '../models/courses/course_config.dart';
import 'draggable_course_item.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: courseConfigs.keys.length,
      itemBuilder: (context, index) {
        String courseName = courseConfigs.keys.elementAt(index);
        var config = courseConfigs[courseName]!;

        return DraggableCourseItem(
          courseName: config.course.name,
          course: config.course,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => config.builder()),
            );
          },
        );
      },
    );
  }
}
