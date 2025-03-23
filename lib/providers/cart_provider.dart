import 'package:flutter/material.dart';
import '../models/course.dart';

class CartProvider with ChangeNotifier {
  final List<Course> _items = [];

  List<Course> get items => _items;

  double get totalPrice => _items.fold(0, (sum, item) => sum + item.price);

  void add(Course course) {
    if (!_items.any((c) => c.name == course.name)) {
      _items.add(course);
      notifyListeners();
    }
  }

  void remove(Course course) {
    _items.removeWhere((c) => c.name == course.name);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
