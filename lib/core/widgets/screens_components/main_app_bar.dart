import 'package:flutter/material.dart';
import 'package:easacc_task/core/app_routes/routes_strings.dart';
import 'package:easacc_task/core/utils/app_assets.dart';
import 'package:easacc_task/core/utils/extensions.dart';
import 'package:easacc_task/core/widgets/main_widgets/action_icon.dart';
import 'package:easacc_task/core/widgets/main_widgets/global_appbar.dart';
import 'package:easacc_task/core/widgets/main_widgets/sliver_global_appbar.dart';
import 'package:easacc_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:easacc_task/core/widgets/package_widgets/app_svg_image.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key, this.titleText, this.title});

  final String? titleText;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return GlobalAppbar(
      toolbarHeight: 96,
      titleText: titleText,
      title: title,
      actions: [
        ActionIcon(
          icon: const AppSvgImage(AppAsset.chatActionIcon),
          onTap: () {
            context.pushNamed(RoutesStrings.contactsScreen);
          },
        ),
        const HorizontalSpace(8),
        ActionIcon(
          icon: const AppSvgImage(AppAsset.notificationActionIcon),
          onTap: () {
            context.pushNamed(RoutesStrings.notificationScreen);
          },
        ),
        const HorizontalSpace(16),
      ],
    );
  }
}

class SliverMainAppBar extends StatelessWidget {
  const SliverMainAppBar({super.key, this.titleText, this.title});

  final String? titleText;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return SliverGlobalAppbar(
      toolbarHeight: 96,
      titleText: titleText,
      title: title,
      actions: [
        ActionIcon(
          icon: const AppSvgImage(AppAsset.chatActionIcon),
          onTap: () {
            context.pushNamed(RoutesStrings.contactsScreen);
          },
        ),
        const HorizontalSpace(8),
        ActionIcon(
          icon: const AppSvgImage(AppAsset.notificationActionIcon),
          onTap: () {
            context.pushNamed(RoutesStrings.notificationScreen);
          },
        ),
        const HorizontalSpace(16),
      ],
    );
  }
}
