import 'package:easacc_task/core/app_themes/colors/app_colors.dart';
import 'package:easacc_task/core/app_themes/text_style/app_text_style.dart';
import 'package:easacc_task/core/utils/app_assets.dart';
import 'package:easacc_task/core/widgets/main_widgets/app_text.dart';
import 'package:easacc_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:easacc_task/core/widgets/package_widgets/app_svg_image.dart';
import 'package:easacc_task/feature/settings/data/model/scanned_device_model.dart';
import 'package:flutter/material.dart';

class DeviceTile extends StatelessWidget {
  const DeviceTile({super.key, required this.device});

  final ScannedDeviceModel device;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.zn100),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _getIconBackgroundColor(),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: AppSvgImage(
                _getIconPath(),
                width: 20,
                height: 20,
                color: _getIconColor(),
              ),
            ),
          ),
          const HorizontalSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  device.name,
                  style: AppTextStyle.style14Medium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const VerticalSpace(4),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _getStatusColor(),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const HorizontalSpace(6),
                    AppText(
                      _getStatusText(),
                      style: AppTextStyle.style12Regular.copyWith(
                        color: AppColors.zn300,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getIconPath() {
    switch (device.type) {
      case ScannedDeviceType.wifi:
        return AppAsset.wifiIcon;
      case ScannedDeviceType.printer:
        return AppAsset.printerIcon;
      case ScannedDeviceType.bluetooth:
      case ScannedDeviceType.unknown:
        return AppAsset.bluetoothIcon;
    }
  }

  Color _getIconColor() {
    switch (device.type) {
      case ScannedDeviceType.wifi:
        return AppColors.blue200;
      case ScannedDeviceType.printer:
        return AppColors.purple;
      case ScannedDeviceType.bluetooth:
      case ScannedDeviceType.unknown:
        return AppColors.blue200;
    }
  }

  Color _getIconBackgroundColor() {
    return _getIconColor().withValues(alpha: 0.1);
  }

  Color _getStatusColor() {
    switch (device.status) {
      case DeviceConnectionStatus.connected:
        return AppColors.success;
      case DeviceConnectionStatus.disconnected:
        return AppColors.zn300;
    }
  }

  String _getStatusText() {
    switch (device.status) {
      case DeviceConnectionStatus.connected:
        return 'Connected';
      case DeviceConnectionStatus.disconnected:
        return 'Disconnected';
    }
  }
}
