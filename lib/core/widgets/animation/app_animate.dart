import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AppAnimate extends StatelessWidget {
  const AppAnimate({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.synchronized(
      duration: const Duration(milliseconds: 1000),
      child: SlideAnimation(
        duration: const Duration(milliseconds: 600),
        horizontalOffset: 80,
        child: FadeInAnimation(
          duration: const Duration(milliseconds: 1000),
          child: child,
        ),
      ),
    );
  }
}
