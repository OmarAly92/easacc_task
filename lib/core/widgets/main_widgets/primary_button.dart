import 'package:easacc_task/core/app_themes/colors/app_colors.dart';
import 'package:easacc_task/core/app_themes/text_style/app_text_style.dart';
import 'package:easacc_task/core/utils/app_constants.dart';
import 'package:easacc_task/core/widgets/animation/tap_bounce_effect.dart';
import 'package:easacc_task/core/widgets/main_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:easacc_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:easacc_task/core/widgets/package_widgets/app_svg_image.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    this.textStyle,
    this.backgroundColor,
    this.foregroundColor,
    this.textColor,
    this.borderRadius,
    required this.onPressed,
    this.isExpand = false,
    this.padding,
    this.isLoading = false,
    this.fixedSize,
    this.svgIconPath,
    this.loadingColor,
  });

  const PrimaryButton.expand({
    super.key,
    required this.text,
    this.textStyle,
    this.backgroundColor,
    this.foregroundColor,
    this.textColor,
    this.borderRadius,
    required this.onPressed,
    this.isExpand = true,
    this.padding,
    this.isLoading = false,
    this.fixedSize,
    this.svgIconPath,
    this.loadingColor,
  });

  final String text;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? textColor;
  final Color? loadingColor;
  final Size? fixedSize;
  final bool isExpand;
  final bool isLoading;
  final BorderRadiusGeometry? borderRadius;
  final void Function()? onPressed;
  final String? svgIconPath;

  @override
  Widget build(BuildContext context) {
    if (isExpand) {
      return TapBounceEffect(
        child: Row(children: [Expanded(child: buildElevatedButton())]),
      );
    } else {
      return TapBounceEffect(child: buildElevatedButton());
    }
  }

  ElevatedButton buildElevatedButton() {
    return ElevatedButton(
      style: buildButtonStyleFrom(),
      onPressed: isLoading ? () {} : onPressed,
      child: isLoading
          ? Center(child: SpinKitThreeBounce(color: loadingColor ?? AppColors.primary, size: 35))
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (svgIconPath != null) AppSvgImage(svgIconPath!, color: AppColors.white),
                if (svgIconPath != null) const HorizontalSpace(8),

                AppText(
                  text,
                  style:
                      textStyle ??
                      AppTextStyle.style18Medium.copyWith(color: textColor ?? AppColors.white),
                ),
              ],
            ),
    );
  }

  ButtonStyle buildButtonStyleFrom() {
    return ElevatedButton.styleFrom(
      padding: padding,
      fixedSize: fixedSize ?? const Size.fromHeight(48),
      foregroundColor: foregroundColor ?? AppColors.blue400,
      backgroundColor: backgroundColor ?? AppColors.mainColor,
      disabledBackgroundColor: AppColors.zn100,
      disabledForegroundColor: AppColors.zn100,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? AppConstants.borderRadiusCircularButton,
      ),
    );
  }
}
