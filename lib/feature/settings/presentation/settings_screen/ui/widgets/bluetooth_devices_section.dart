import 'package:easacc_task/core/app_themes/colors/app_colors.dart';
import 'package:easacc_task/core/app_themes/text_style/app_text_style.dart';
import 'package:easacc_task/core/utils/app_assets.dart';
import 'package:easacc_task/core/widgets/main_widgets/app_text.dart';
import 'package:easacc_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:easacc_task/core/widgets/package_widgets/app_svg_image.dart';
import 'package:easacc_task/feature/settings/data/model/scanned_device_model.dart';
import 'package:easacc_task/feature/settings/presentation/settings_screen/ui/widgets/device_tile.dart';
import 'package:flutter/material.dart';

class BluetoothDevicesSection extends StatelessWidget {
  const BluetoothDevicesSection({
    super.key,
    required this.devices,
  });

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
              width: 24,
              height: 24,
            ),
            const HorizontalSpace(8),
            AppText(
              'Bluetooth Devices',
              style: AppTextStyle.style18Bold.copyWith(color: AppColors.zn900),
            ),
          ],
        ),
        const VerticalSpace(12),
        if (devices.isEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.zn200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: AppText(
                'No devices found',
                style: AppTextStyle.style14Regular.copyWith(color: AppColors.zn400),
              ),
            ),
          )
        else
          Column(
            children: [
              for (int i = 0; i < devices.length; i++) ...[
                DeviceTile(device: devices[i]),
                if (i < devices.length - 1) const VerticalSpace(8),
              ],
            ],
          ),
      ],
    );
  }
}
