import 'package:flutter/material.dart';
import 'package:easacc_task/core/app_themes/colors/app_colors.dart';
import 'package:easacc_task/core/app_themes/text_style/app_text_style.dart';
import 'package:easacc_task/core/widgets/main_widgets/app_text.dart';
import 'package:easacc_task/core/widgets/main_widgets/space_widgets.dart';

class BulletText extends StatelessWidget {
  const BulletText(this.text, {super.key, this.style, this.maxLines, this.isExpanded = false});

  final String text;
  final TextStyle? style;
  final int? maxLines;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(radius: 2, backgroundColor: AppColors.zn300),
        const HorizontalSpace(4),
        if (isExpanded)
          Expanded(
            child: AppText(
              text,
              maxLines: maxLines,
              style: style ?? AppTextStyle.style16Regular.copyWith(color: AppColors.zn300),
            ),
          )
        else
          AppText(
            text,
            maxLines: maxLines,
            style: style ?? AppTextStyle.style16Regular.copyWith(color: AppColors.zn300),
          ),
      ],
    );
  }
}
