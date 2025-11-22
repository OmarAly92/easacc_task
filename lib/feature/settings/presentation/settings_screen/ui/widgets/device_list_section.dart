import 'package:easacc_task/core/app_themes/colors/app_colors.dart';
import 'package:easacc_task/core/app_themes/text_style/app_text_style.dart';
import 'package:easacc_task/core/widgets/main_widgets/app_text.dart';
import 'package:easacc_task/core/widgets/main_widgets/secondary_button.dart';
import 'package:easacc_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:easacc_task/feature/settings/presentation/settings_screen/logic/settings_cubit.dart';
import 'package:easacc_task/feature/settings/presentation/settings_screen/ui/widgets/bluetooth_devices_section.dart';
import 'package:easacc_task/feature/settings/presentation/settings_screen/ui/widgets/wifi_networks_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeviceListSection extends StatelessWidget {
  const DeviceListSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingsCubit>();

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final isScanning = state is DeviceScanningState;
        final wifiNetworks = cubit.wifiNetworks;
        final bluetoothDevices = cubit.devices;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (wifiNetworks.isNotEmpty || isScanning) ...[
              if (isScanning && wifiNetworks.isEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AppText('WiFi Networks', style: AppTextStyle.style18Bold),
                      ],
                    ),
                    const VerticalSpace(12),
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
                          'Scanning for WiFi...',
                          style: AppTextStyle.style14Regular.copyWith(color: AppColors.zn400),
                        ),
                      ),
                    ),
                  ],
                )
              else
                WifiNetworksSection(networks: wifiNetworks),
              const VerticalSpace(24),
            ],
            BluetoothDevicesSection(devices: bluetoothDevices),
            const VerticalSpace(24),
            BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, state) {
                return SecondaryButton.expand(
                  text: 'Logout',
                  onPressed: () => cubit.logout(),
                  textStyle: AppTextStyle.style16Medium.copyWith(color: AppColors.red),
                  backgroundColor: AppColors.red.withValues(alpha: 0.1),
                  borderColor: AppColors.red,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
