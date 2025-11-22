import 'package:easacc_task/core/app_themes/colors/app_colors.dart';
import 'package:easacc_task/core/app_themes/text_style/app_text_style.dart';
import 'package:easacc_task/core/utils/app_assets.dart';
import 'package:easacc_task/core/widgets/main_widgets/app_text.dart';
import 'package:easacc_task/core/widgets/package_widgets/app_svg_image.dart';
import 'package:easacc_task/feature/settings/data/model/scanned_device_model.dart';
import 'package:easacc_task/feature/settings/presentation/settings_screen/ui/widgets/device_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpandableBluetoothSection extends StatelessWidget {
  const ExpandableBluetoothSection({
    super.key,
    required this.isExpanded,
    required this.onToggle,
    required this.devices,
  });

  final bool isExpanded;
  final VoidCallback onToggle;
  final List<ScannedDeviceModel> devices;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AppSvgImage(
              AppAsset.bluetoothIcon,
              color: AppColors.blue200,
              width: 24.w,
              height: 24.h,
            ),
            SizedBox(width: 8.w),
            AppText(
              'Bluetooth Devices',
              style: AppTextStyle.style18Bold.copyWith(color: AppColors.zn900),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        GestureDetector(
          onTap: devices.isEmpty ? null : onToggle,
          child: Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AppText(
                        devices.isEmpty
                            ? 'No devices found'
                            : '${devices.length} device${devices.length == 1 ? '' : 's'} found',
                        style: AppTextStyle.style14Regular.copyWith(color: AppColors.zn400),
                      ),
                    ),
                    if (devices.isNotEmpty)
                      AnimatedRotation(
                        turns: isExpanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: Icon(Icons.keyboard_arrow_down, color: AppColors.zn400, size: 24.sp),
                      ),
                  ],
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  child: isExpanded && devices.isNotEmpty
                      ? Column(
                          children: [
                            SizedBox(height: 16.h),
                            ...devices.map((device) => DeviceTile(device: device)),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
