import 'course.dart';
import 'package:flutter/material.dart';
import 'course_keys.dart';
import '../../courses/courses.dart';

class CourseConfig {
  final Course course;
  final Widget Function() builder;

  CourseConfig({required this.course, required this.builder});
}

final Map<String, Course> courses = {
  CourseKeys.unity: Course(name: 'Unity для початківців', price: 299.99),
  CourseKeys.game2d: Course(name: '2D Game Development', price: 349.99),
  CourseKeys.design: Course(name: 'Game Design Basics', price: 399.99),
  CourseKeys.ai: Course(name: 'AI у відеоіграх', price: 499.99),
  CourseKeys.vr: Course(name: 'VR/AR для розробників', price: 549.99),
  CourseKeys.art3d: Course(name: '3D Game Art & Моделювання', price: 749.99),
  CourseKeys.unrealEngine: Course(
    name: 'Unreal Engine : Основи',
    price: 749.99,
  ),
};

final Map<String, CourseConfig> courseConfigs = {
  CourseKeys.unity: CourseConfig(
    course: courses[CourseKeys.unity]!,
    builder: () => UnityCourseScreen(course: courses[CourseKeys.unity]!),
  ),
  CourseKeys.game2d: CourseConfig(
    course: courses[CourseKeys.game2d]!,
    builder: () => Game2DScreen(course: courses[CourseKeys.game2d]!),
  ),
  CourseKeys.design: CourseConfig(
    course: courses[CourseKeys.design]!,
    builder: () => GameDesignScreen(course: courses[CourseKeys.design]!),
  ),
  CourseKeys.ai: CourseConfig(
    course: courses[CourseKeys.ai]!,
    builder: () => GameAIScreen(course: courses[CourseKeys.ai]!),
  ),
  CourseKeys.vr: CourseConfig(
    course: courses[CourseKeys.vr]!,
    builder: () => GameVRScreen(course: courses[CourseKeys.vr]!),
  ),
  CourseKeys.art3d: CourseConfig(
    course: courses[CourseKeys.art3d]!,
    builder: () => Game3DScreen(course: courses[CourseKeys.art3d]!),
  ),
  CourseKeys.unrealEngine: CourseConfig(
    course: courses[CourseKeys.unrealEngine]!,
    builder:
        () => UnrealCourseScreen(course: courses[CourseKeys.unrealEngine]!),
  ),
};
