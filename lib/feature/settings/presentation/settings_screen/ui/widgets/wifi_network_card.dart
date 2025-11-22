import 'package:easacc_task/core/app_themes/colors/app_colors.dart';
import 'package:easacc_task/core/app_themes/text_style/app_text_style.dart';
import 'package:easacc_task/core/utils/app_assets.dart';
import 'package:easacc_task/core/widgets/main_widgets/app_text.dart';
import 'package:easacc_task/core/widgets/package_widgets/app_svg_image.dart';
import 'package:easacc_task/feature/settings/data/model/scanned_device_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WifiNetworkCard extends StatelessWidget {
  const WifiNetworkCard({
    super.key,
    required this.wifiInfo,
  });

  final ScannedDeviceModel wifiInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.zn200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.h,
            decoration: BoxDecoration(
              color: AppColors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: AppSvgImage(
                AppAsset.wifiIcon,
                color: AppColors.green,
                width: 24.w,
                height: 24.h,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  wifiInfo.name,
                  style: AppTextStyle.style14Medium.copyWith(
                    color: AppColors.zn900,
                  ),
                ),
                SizedBox(height: 4.h),
                AppText(
                  'IP: ${wifiInfo.macAddress ?? 'Unknown'}',
                  style: AppTextStyle.style12Regular.copyWith(
                    color: AppColors.zn400,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.zn400,
            size: 24.sp,
          ),
        ],
      ),
    );
  }
}
