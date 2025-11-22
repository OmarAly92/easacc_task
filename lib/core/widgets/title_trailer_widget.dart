import 'package:flutter/material.dart';
import 'package:easacc_task/core/app_themes/colors/app_colors.dart';
import 'package:easacc_task/core/app_themes/text_style/app_text_style.dart';
import 'package:easacc_task/core/widgets/main_widgets/app_text.dart';

class TitleTrailerTextWidget extends StatelessWidget {
  const TitleTrailerTextWidget({super.key, required this.title, required this.trailerText});

  final String title;
  final String trailerText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(title, style: AppTextStyle.style16Regular.copyWith(color: AppColors.zn300)),
        AppText(trailerText, style: AppTextStyle.style16Regular.copyWith(color: AppColors.zn200)),
      ],
    );
  }
}
