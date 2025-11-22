import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:easacc_task/core/app_themes/colors/app_colors.dart';
import 'package:easacc_task/core/app_themes/text_style/app_text_style.dart';
import 'package:easacc_task/core/helpers/localization/locale_keys.g.dart';
import 'package:easacc_task/core/utils/app_assets.dart';
import 'package:easacc_task/core/utils/app_constants.dart';
import 'package:easacc_task/core/widgets/main_widgets/app_text.dart';
import 'package:easacc_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:easacc_task/core/widgets/package_widgets/app_svg_image.dart';

class AppHeaderTitle extends StatelessWidget {
  const AppHeaderTitle({
    super.key,
    required this.title,
    this.svgIconPath,
    this.trailing,
    this.textStyle,
  }) : seeMore = false,
       iconOnPress = null;

  const AppHeaderTitle.seeMore({
    super.key,
    required this.title,
    this.svgIconPath,
    this.trailing,
    this.textStyle,
    this.iconOnPress,
  }) : seeMore = true;

  final String title;
  final String? svgIconPath;
  final TextStyle? textStyle;
  final bool seeMore;
  final Widget? trailing;
  final void Function()? iconOnPress;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          visible: svgIconPath != null,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(end: 8),
            child: AppSvgImage(svgIconPath ?? ''),
          ),
        ),
        AppText(
          title,
          style: textStyle ?? AppTextStyle.style20Medium.copyWith(color: const Color(0xff1F2937)),
        ),
        const Spacer(),
        ?trailing,
        if (seeMore)
          InkWell(
            onTap: iconOnPress,
            borderRadius: AppConstants.borderRadiusCircular,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Row(
                children: [
                  AppText(
                    LocaleKeys.seeAll.tr(),
                    style: AppTextStyle.style14Regular.copyWith(color: AppColors.zn300),
                  ),
                  const HorizontalSpace(4),
                  const AppSvgImage(AppAsset.arrowForwardIcon),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
