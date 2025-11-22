import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easacc_task/core/widgets/main_widgets/horizontal_padding.dart';
import 'package:easacc_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:easacc_task/feature/settings/presentation/settings_screen/ui/widgets/device_list_section.dart';
import 'package:easacc_task/feature/settings/presentation/settings_screen/ui/widgets/url_input_section.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: HorizontalPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VerticalSpace(24.h),
            const UrlInputSection(),
            VerticalSpace(32.h),
            const DeviceListSection(),
            VerticalSpace(24.h),
          ],
        ),
      ),
    );
  }
}
