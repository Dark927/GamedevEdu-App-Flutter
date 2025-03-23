import '../models/course.dart';
import 'package:flutter/material.dart';
import '../courses/courses.dart';

class CourseConfig {
  final Course course;
  final Widget Function() builder;

  CourseConfig({required this.course, required this.builder});
}

final Map<String, CourseConfig> courseConfigs = {
  'Unity для початківців': CourseConfig(
    course: Course(name: 'Unity для початківців', price: 299.0),
    builder:
        () => UnityCourseScreen(
          course: Course(name: 'Unity для початківців', price: 299.0),
        ),
  ),
  '2D Game Development': CourseConfig(
    course: Course(name: '2D Game Development', price: 349.99),
    builder:
        () => Game2DScreen(
          course: Course(name: '2D Game Development', price: 349.99),
        ),
  ),
  'Game Design Basics': CourseConfig(
    course: Course(name: 'Game Design Basics', price: 399.99),
    builder:
        () => GameDesignScreen(
          course: Course(name: 'Game Design Basics', price: 399.99),
        ),
  ),
  'AI у відеоіграх': CourseConfig(
    course: Course(name: 'AI у відеоіграх', price: 499.99),
    builder:
        () => GameAIScreen(
          course: Course(name: 'AI у відеоіграх', price: 499.99),
        ),
  ),
  'VR/AR для розробників': CourseConfig(
    course: Course(name: 'VR/AR для розробників', price: 549.99),
    builder:
        () => GameVRScreen(
          course: Course(name: 'VR/AR для розробників', price: 549.99),
        ),
  ),
};
