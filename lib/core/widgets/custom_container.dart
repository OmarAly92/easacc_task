import 'package:flutter/material.dart';
import 'package:easacc_task/core/app_themes/colors/app_colors.dart';
import 'package:easacc_task/core/utils/app_constants.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.color,
    this.constraints,
  });

  final Widget child;
  final Color? color;

  final double? width, height;

  final EdgeInsetsGeometry? padding, margin;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: constraints,
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? AppColors.zn800,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: child,
    );
  }
}
