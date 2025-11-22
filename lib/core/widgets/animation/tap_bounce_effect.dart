import 'package:flutter/material.dart';

class TapBounceEffect extends StatefulWidget {
  const TapBounceEffect({super.key, required this.child});

  final Widget child;

  @override
  State<TapBounceEffect> createState() => _TapBounceEffectState();
}

class _TapBounceEffectState extends State<TapBounceEffect>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Durations.short4,
      reverseDuration: Durations.short4,
    );
    _animation = Tween(end: .97, begin: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        reverseCurve: Curves.ease,
        curve: Curves.bounceInOut,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void onTap() {
    if (_controller.isAnimating) _controller.reset();
    _controller.forward().then((_) => _controller.reverse());
  }

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      child: ScaleTransition(scale: _animation, child: widget.child),
      onTapInside: (_) {
        onTap();
      },
      onTapUpInside: (_) {},
    );
  }
}
