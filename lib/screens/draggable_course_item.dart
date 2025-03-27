import 'package:flutter/material.dart';
import '../models/courses/course.dart';

class DraggableCourseItem extends StatefulWidget {
  final String courseName;
  final VoidCallback onTap;
  final Course course;

  const DraggableCourseItem({
    super.key,
    required this.courseName,
    required this.onTap,
    required this.course,
  });

  @override
  State<DraggableCourseItem> createState() => _DraggableCourseItemState();
}

class _DraggableCourseItemState extends State<DraggableCourseItem> {
  bool _isHovered = false;
  bool _isDragging = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final Widget content = _buildAnimatedCourseCard();

    return LongPressDraggable<Course>(
      data: widget.course,
      dragAnchorStrategy: pointerDragAnchorStrategy,
      onDragStarted: () => setState(() {
        _isDragging = true;
        _isPressed = false;
      }),
      onDragEnd: (_) => setState(() => _isDragging = false),
      onDragCompleted: () => setState(() => _isDragging = false),
      onDraggableCanceled: (_, __) => setState(() => _isDragging = false),
      feedback: Material(
        color: Colors.transparent,
        child: Opacity(
          opacity: 0.85,
          child: _buildFeedbackCard(),
        ),
      ),
      childWhenDragging: _wrapWithMouseRegion(
        content,
        isChildWhenDragging: true,
      ),
      child: _wrapWithMouseRegion(content),
    );
  }

  Widget _wrapWithMouseRegion(Widget child, {bool isChildWhenDragging = false}) {
  return MouseRegion(
    onEnter: (_) => setState(() => _isHovered = true),
    onExit: (_) => setState(() {
      _isHovered = false;
      _isPressed = false;
    }),
    cursor: SystemMouseCursors.click, // Ensure cursor stays as a pointer
    child: GestureDetector(
      behavior: HitTestBehavior.opaque, // Ensures tap works across the widget
      onTapDown: (_) => setState(() {
        _isPressed = true;
      }),
      onTapUp: (_) => setState(() {
        _isPressed = false;
      }),
      onTapCancel: () => setState(() {
        _isPressed = false;
      }),
      onTap: () {
        widget.onTap();
        setState(() {
          _isPressed = true; // Apply a brief press effect
        });
        Future.delayed(const Duration(milliseconds: 150), () {
          if (mounted) {
            setState(() => _isPressed = false);
          }
        });
      },
      child: child,
    ),
  );
}

  Widget _buildAnimatedCourseCard() {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 150),
    curve: Curves.easeInOut,
    transform: Matrix4.identity()
      ..scale(
        _isPressed ? 0.95 : (_isHovered && !_isDragging ? 1.05 : 1.0),
      ),
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Card(
      elevation: _isPressed ? 4 : (_isHovered && !_isDragging ? 8 : 2),
      color: _isHovered && !_isDragging
          ? Colors.deepPurple.shade50
          : Colors.white,
      child: ListTile(
        leading: Icon(
          Icons.school,
          color: _isHovered && !_isDragging
              ? Colors.deepPurple.shade700
              : Colors.deepPurple,
        ),
        title: Text(
          widget.courseName,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: _isHovered && !_isDragging
                ? Colors.deepPurple.shade900
                : Colors.black,
          ),
        ),
      ),
    ),
  );
}

  Widget _buildFeedbackCard() {
    return Card(
      elevation: 8,
      color: Colors.deepPurple.shade100,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          widget.courseName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
