import 'package:flutter/material.dart';
import 'dart:math' as math;

class HalfCircleIndicator extends StatefulWidget {
  const HalfCircleIndicator({
    super.key,
    required this.percent,
    required this.activeColor,
    required this.inactiveColor,
    required this.title,
    required this.subtitle,
    required this.circleSize,
    required this.lineThickness,
    this.titleStyle,
    this.subtitleStyle,
    this.duration = const Duration(milliseconds: 700),
    this.curve = Curves.easeOut,
  });

  final double percent;
  final Color activeColor;
  final Color inactiveColor;
  final String title;
  final String subtitle;
  final double circleSize;
  final double lineThickness;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final Duration duration;
  final Curve curve;

  @override
  State<HalfCircleIndicator> createState() => _HalfCircleIndicatorState();
}

class _HalfCircleIndicatorState extends State<HalfCircleIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _previousValue = 0;

  @override
  void initState() {
    super.initState();
    _previousValue = widget.percent;
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation =
        Tween<double>(
            begin: _previousValue,
            end: widget.percent,
          ).animate(CurvedAnimation(parent: _controller, curve: widget.curve))
          ..addListener(() {
            setState(() {});
          });
    _controller.forward();
  }

  @override
  void didUpdateWidget(HalfCircleIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.percent != widget.percent) {
      _previousValue = _animation.value;
      _controller.reset();
      _animation = Tween<double>(
        begin: _previousValue,
        end: widget.percent,
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
    return HalfCircleIndicatorRenderWidget(
      percent: _animation.value,
      activeColor: widget.activeColor,
      inactiveColor: widget.inactiveColor,
      title: widget.title,
      subtitle: widget.subtitle,
      circleSize: widget.circleSize,
      lineThickness: widget.lineThickness,
      titleStyle: widget.titleStyle,
      subtitleStyle: widget.subtitleStyle,
    );
  }
}

class HalfCircleIndicatorRenderWidget extends LeafRenderObjectWidget {
  final double percent;
  final Color activeColor;
  final Color inactiveColor;
  final String title;
  final String subtitle;
  final double circleSize; // Diameter of the circle.
  final double lineThickness;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  const HalfCircleIndicatorRenderWidget({
    super.key,
    required this.percent,
    required this.activeColor,
    required this.inactiveColor,
    required this.title,
    required this.subtitle,
    required this.circleSize,
    this.lineThickness = 10.0,
    this.titleStyle,
    this.subtitleStyle,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return HalfCircleRenderObject(
      percent: percent,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      title: title,
      subtitle: subtitle,
      circleSize: circleSize,
      lineThickness: lineThickness,
      titleStyle: titleStyle ?? Theme.of(context).textTheme.bodyMedium!,
      subtitleStyle: subtitleStyle ?? Theme.of(context).textTheme.displayLarge!,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    HalfCircleRenderObject renderObject,
  ) {
    renderObject
      ..percent = percent
      ..activeColor = activeColor
      ..inactiveColor = inactiveColor
      ..title = title
      ..subtitle = subtitle
      ..circleSize = circleSize
      ..lineThickness = lineThickness
      ..titleStyle = titleStyle ?? Theme.of(context).textTheme.bodyMedium!
      ..subtitleStyle =
          subtitleStyle ?? Theme.of(context).textTheme.displayLarge!;
  }
}

class HalfCircleRenderObject extends RenderBox {
  double percent;
  Color activeColor;
  Color inactiveColor;
  String title;
  String subtitle;
  double circleSize;
  double lineThickness;
  TextStyle titleStyle;
  TextStyle subtitleStyle;

  HalfCircleRenderObject({
    required this.percent,
    required this.activeColor,
    required this.inactiveColor,
    required this.title,
    required this.subtitle,
    required this.circleSize,
    required this.lineThickness,
    required this.titleStyle,
    required this.subtitleStyle,
  });

  @override
  void performLayout() {
    // Use circleSize as the width and 2/3 of circleSize as the height.
    size = constraints.constrain(Size(circleSize, (circleSize * 2 / 3) + 65));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    final center = offset + Offset((size.width) / 2, (size.height - 60));
    final radius = size.width / 2;

    // Arc parameters: start at 0.9π and sweep 1.2π (216°)
    final startAngle = math.pi - (0.15 * math.pi);
    final sweepAngle = 1.3 * math.pi;

    // Draw the inactive (background) arc.
    final backgroundPaint = Paint()
      ..color = inactiveColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineThickness
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      backgroundPaint,
    );

    // Draw the active (progress) arc.
    final progressPaint = Paint()
      ..color = activeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineThickness
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle * percent,
      false,
      progressPaint,
    );

    // Use a single TextPainter to center texts as in your sample.
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    // Draw title.
    textPainter.text = TextSpan(text: title, style: titleStyle);
    textPainter.layout();
    textPainter.paint(
      canvas,
      center - Offset(textPainter.width / 2, radius / 3),
    );

    // Draw subtitle.
    textPainter.text = TextSpan(text: subtitle, style: subtitleStyle);
    textPainter.layout();
    textPainter.paint(
      canvas,
      center - Offset(textPainter.width / 2, radius / 2 - 35),
    );
  }
}
