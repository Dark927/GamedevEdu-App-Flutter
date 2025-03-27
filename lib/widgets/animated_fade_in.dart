import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AnimatedFadeIn extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double offsetScale;

  const AnimatedFadeIn({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.offsetScale = 0.8,
  });

  @override
  State<AnimatedFadeIn> createState() => _AnimatedFadeInState();
}

class _AnimatedFadeInState extends State<AnimatedFadeIn> {
  bool _visible = false;
  
  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('fade-in-${widget.hashCode}'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0 && !_visible) {
          setState(() {
            _visible = true;
          });
        }
      },
      child: AnimatedOpacity(
        duration: widget.duration,
        opacity: _visible ? 1.0 : 0.0,
        child: AnimatedScale(
          duration: widget.duration,
          scale: _visible ? 1.0 : widget.offsetScale,
          child: widget.child,
        ),
      ),
    );
  }
}
