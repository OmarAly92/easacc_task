import 'package:flutter/material.dart';
import 'package:easacc_task/core/app_themes/colors/app_colors.dart';
import 'package:easacc_task/core/app_themes/text_style/app_text_style.dart';
import 'package:easacc_task/core/utils/app_constants.dart';
import 'package:easacc_task/core/widgets/main_widgets/app_text.dart';

class PayrollDetailsMainTitleValue extends StatelessWidget {
  const PayrollDetailsMainTitleValue({
    super.key,
    required this.title,
    required this.value,
    this.valueColor,
    this.valueStyle,
  });

  final String title;
  final String value;
  final Color? valueColor;
  final TextStyle? valueStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(title, style: AppTextStyle.style16Regular.copyWith(color: AppColors.payrollTitle)),
        AppText(
          '$value ${AppConstants.currencySymbol}',
          style:
              valueStyle ??
              AppTextStyle.style16SemiBold.copyWith(color: valueColor ?? AppColors.zn900),
        ),
      ],
    );
  }
}
