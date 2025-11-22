import 'package:flutter/material.dart';
import 'package:easacc_task/core/app_themes/colors/app_colors.dart';
import 'package:easacc_task/core/app_themes/text_style/app_text_style.dart';
import 'package:easacc_task/core/widgets/main_widgets/app_text.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key, this.onTap, required this.title, this.isActive = false});

  final VoidCallback? onTap;
  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      color: isActive ? AppColors.mainColor : AppColors.white,
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppColors.mainColor),
          ),
          child: Center(
            child: AppText(
              title,
              style: AppTextStyle.style16Medium.copyWith(
                color: isActive ? AppColors.white : AppColors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
