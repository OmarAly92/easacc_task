import 'package:easacc_task/core/app_themes/colors/app_colors.dart';
import 'package:easacc_task/core/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:easacc_task/core/widgets/animation/tap_bounce_effect.dart';
import 'package:easacc_task/core/widgets/main_widgets/app_ink_well.dart';

class AppContainer extends StatelessWidget {
  const AppContainer({
    super.key,
    required this.child,
    this.constraints,
    this.onTap,
    this.padding,
    this.margin,
    this.disable = false,
    this.border,
    this.borderRadius,
    this.width,
    this.height,
    this.backgroundColor,
    this.noTapBounceEffect = false,
    this.splashColor,
    this.overlayColor,
  });

  final Widget child;
  final BoxConstraints? constraints;
  final void Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool disable;
  final BoxBorder? border;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final bool noTapBounceEffect;
  final Color? splashColor;
  final WidgetStateProperty<Color?>? overlayColor;

  @override
  Widget build(BuildContext context) {
    return TapBounceEffect(
      child: Opacity(
        opacity: disable ? .5 : 1,
        child: Padding(
          padding: margin ?? EdgeInsets.zero,
          child: Material(
            color: backgroundColor ?? AppColors.secondary,
            borderRadius: borderRadius ?? AppConstants.borderRadiusCircular,
            child: AppInkWell(
              noTapBounceEffect: noTapBounceEffect,
              borderRadius: borderRadius ?? AppConstants.borderRadiusCircular,
              onTap: onTap,
              splashColor: splashColor,
              overlayColor: splashColor != null
                  ? WidgetStatePropertyAll<Color>(splashColor!)
                  : null,
              child: Container(
                width: width,
                height: height,
                padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                constraints: constraints,
                decoration: BoxDecoration(
                  borderRadius: borderRadius ?? AppConstants.borderRadiusCircular,
                  border: border,
                ),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
