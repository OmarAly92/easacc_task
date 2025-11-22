import 'package:flutter/material.dart';
import 'package:easacc_task/core/app_themes/colors/app_colors.dart';
import 'package:easacc_task/core/app_themes/text_style/app_text_style.dart';
import 'package:easacc_task/core/utils/extensions.dart';
import 'package:easacc_task/core/widgets/main_widgets/app_text.dart';

class LabelledContainer extends StatelessWidget {
  final String label;
  final Widget child;
  final Color? fillColor;

  final double? strokeWidth;
  final double? padding;

  const LabelledContainer({
    super.key,
    required this.label,
    required this.child,
    this.fillColor,
    this.strokeWidth,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    const backgroundColor = AppColors.zn50;
    const borderColor = AppColors.textFieldBorder;
    const borderRadius = 4.0;

    // Measure the label size
    final textPainter = TextPainter(
      text: TextSpan(
        text: label,
        style: AppTextStyle.style14Regular.copyWith(color: AppColors.labelTextColor),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();

    final labelWidth = textPainter.width; // + padding
    final labelHeight = textPainter.height;

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: CustomPaint(
            painter: LabelledContainerBorderPainter(
              borderColor: borderColor,
              borderRadius: borderRadius,
              labelWidth: labelWidth,
              labelHeight: labelHeight,
              strokeWidth: strokeWidth,
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 1),
              width: context.width,
              padding: EdgeInsets.all(padding ?? 16),
              decoration: BoxDecoration(
                color: fillColor ?? backgroundColor,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: child,
            ),
          ),
        ),
        Positioned(
          left: 16,
          top: 0,
          child: AppText(
            label,
            style: AppTextStyle.style12Regular.copyWith(color: AppColors.labelTextColor),
          ),
        ),
      ],
    );
  }
}

class LabelledContainerBorderPainter extends CustomPainter {
  final Color borderColor;
  final double borderRadius;
  final double labelWidth;
  final double labelHeight;
  final double? strokeWidth;

  LabelledContainerBorderPainter({
    required this.borderColor,
    required this.borderRadius,
    required this.labelWidth,
    required this.labelHeight,
    this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth ?? 2;

    final rRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );

    final path = Path();

    // Draw full border first
    path.addRRect(rRect);

    // Cut the top segment behind the label
    final cutStart = 14.0; // left padding for label
    final cutEnd = cutStart + labelWidth;

    final clipPath = Path()
      ..moveTo(cutStart, 0)
      ..lineTo(cutEnd, 0);

    canvas.drawPath(path, paint);

    // Cover the label area (to "erase" border line behind label)
    final eraser = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(clipPath, eraser);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
