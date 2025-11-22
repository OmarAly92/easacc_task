import 'package:flutter/material.dart';
import 'package:easacc_task/core/widgets/animation/tap_bounce_effect.dart';

class AppInkWell extends StatelessWidget {
  const AppInkWell({
    super.key,
    this.child,
    this.onTap,
    this.borderRadius,
    this.overlayColor,
    this.splashColor,
    this.noTapBounceEffect = false,
  });

  final Widget? child;
  final void Function()? onTap;
  final BorderRadius? borderRadius;
  final WidgetStateProperty<Color?>? overlayColor;
  final Color? splashColor;
  final bool noTapBounceEffect;

  @override
  Widget build(BuildContext context) {
    if (noTapBounceEffect) {
      return InkWell(
        splashFactory: InkRipple.splashFactory,
        onTap: onTap,
        borderRadius: borderRadius,
        splashColor: splashColor,
        overlayColor: overlayColor,
        child: child,
      );
    }
    return TapBounceEffect(
      child: InkWell(
        splashFactory: InkRipple.splashFactory,
        onTap: onTap,
        borderRadius: borderRadius,
        splashColor: splashColor,
        overlayColor: overlayColor,
        child: child,
      ),
    );
  }
}
