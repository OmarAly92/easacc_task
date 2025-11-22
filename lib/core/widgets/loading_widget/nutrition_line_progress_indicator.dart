import 'package:flutter/material.dart';

class LineProgressIndicator extends StatefulWidget {
  const LineProgressIndicator({
    super.key,
    required this.value,
    required this.activeColor,
    this.duration = const Duration(milliseconds: 700),
    this.curve = Curves.easeOut,
    required this.backgroundColor,
  });

  final double value;
  final Color activeColor;
  final Color backgroundColor;
  final Duration duration;
  final Curve curve;

  @override
  State<LineProgressIndicator> createState() => _LineProgressIndicatorState();
}

class _LineProgressIndicatorState extends State<LineProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _previousValue = 0;

  @override
  void initState() {
    super.initState();
    _previousValue = widget.value;
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation =
        Tween<double>(begin: _previousValue, end: widget.value).animate(
          CurvedAnimation(parent: _controller, curve: widget.curve),
        )..addListener(() {
          setState(() {});
        });
    _controller.forward();
  }

  @override
  void didUpdateWidget(LineProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _previousValue = _animation.value;
      _controller.reset();
      _animation = Tween<double>(
        begin: _previousValue,
        end: widget.value,
      ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8,
      child: LinearProgressIndicator(
        value: _animation.value,
        color: widget.activeColor,
        valueColor: AlwaysStoppedAnimation<Color>(widget.activeColor),
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        backgroundColor: widget.backgroundColor,
      ),
    );
  }
}
