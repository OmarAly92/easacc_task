import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:easacc_task/core/app_themes/colors/app_colors.dart';
import 'package:easacc_task/core/app_themes/text_style/app_text_style.dart';
import 'package:easacc_task/core/widgets/package_widgets/app_svg_image.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
    required this.text,
    required this.iconPath,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.backgroundColor,
    this.textColor,
  });

  final String text;
  final String iconPath;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isDisabled;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: isLoading || isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Colors.white,
          foregroundColor: textColor ?? AppColors.zn900,
          disabledBackgroundColor: (backgroundColor ?? Colors.white).withOpacity(0.6),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
            side: backgroundColor == null
                ? BorderSide(color: AppColors.zn200, width: 1.5)
                : BorderSide.none,
          ),
        ),
        child: isLoading
            ? SpinKitThreeBounce(
                color: textColor ?? AppColors.zn900,
                size: 24.sp,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppSvgImage(
                    iconPath,
                    width: 24.w,
                    height: 24.h,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    text,
                    style: AppTextStyle.style16Medium.copyWith(
                      color: textColor ?? AppColors.zn900,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
