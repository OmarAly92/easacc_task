import 'package:flutter/material.dart';
import 'package:easacc_task/core/app_themes/text_style/app_text_style.dart';
import 'package:easacc_task/core/utils/app_assets.dart';
import 'package:easacc_task/core/utils/app_constants.dart';
import 'package:easacc_task/core/widgets/package_widgets/app_svg_image.dart';

class Toaster {
  Toaster._();

  static final Toaster _i = Toaster._();

  factory Toaster() => _i;

  OverlayEntry? _entry;
  bool _showing = false;

  Future<void> show(
    BuildContext context, {
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) async {
    if (_showing) {
      // If already showing, replace it
      _entry?.remove();
      _entry = null;
      _showing = false;
    }

    final overlay = Overlay.of(context);

    final controller = AnimationController(
      vsync: Navigator.of(context),
      duration: const Duration(milliseconds: 220),
    );

    final curved = CurvedAnimation(parent: controller, curve: Curves.easeOut);

    _entry = OverlayEntry(
      builder: (ctx) => _ToastWidget(animation: curved, title: title, message: message),
    );

    overlay.insert(_entry!);
    _showing = true;

    // animate in
    await controller.forward();

    // wait on screen
    await Future.delayed(duration);

    // animate out
    await controller.reverse();

    // cleanup
    _entry?.remove();
    _entry = null;
    _showing = false;
    controller.dispose();
  }
}

class _ToastWidget extends StatelessWidget {
  const _ToastWidget({required this.animation, required this.title, required this.message});

  final Animation<double> animation;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        ignoring: true,
        child: SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter, // 👈 bottom instead of top
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
              child: AnimatedBuilder(
                animation: animation,
                builder: (_, child) => Opacity(
                  opacity: animation.value,
                  child: Transform.translate(
                    offset: Offset(0, 40 * (1 - animation.value)), // 👈 slide UP
                    child: child,
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 460),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF4E5),
                      borderRadius: AppConstants.borderRadiusCircular,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppSvgImage(AppAsset.warningIcon),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: AppTextStyle.style16Medium.copyWith(
                                  color: const Color(0xff663C00),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                message,
                                style: AppTextStyle.style14Regular.copyWith(
                                  color: const Color(0xff663C00),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
