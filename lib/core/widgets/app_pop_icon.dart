import 'package:flutter/material.dart';
import 'package:easacc_task/core/utils/app_assets.dart';
import 'package:easacc_task/core/utils/extensions.dart';
import 'package:easacc_task/core/widgets/animation/tap_bounce_effect.dart';
import 'package:easacc_task/core/widgets/package_widgets/app_svg_image.dart';

class AppPopIcon extends StatelessWidget {
  const AppPopIcon({super.key, this.onPressed});

  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    if (context.canPop()) {
      return TapBounceEffect(
        child: IconButton(
          onPressed: onPressed ?? () => context.pop(),
          style: IconButton.styleFrom(splashFactory: InkRipple.splashFactory),
          icon: Transform.rotate(
            angle: context.isArabic ? 3.14 : 0,
            child: const AppSvgImage(AppAsset.arrowBackIcon),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
