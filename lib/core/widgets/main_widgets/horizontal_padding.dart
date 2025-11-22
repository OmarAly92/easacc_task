import 'package:flutter/material.dart';
import 'package:easacc_task/core/utils/app_constants.dart';

class HorizontalPadding extends StatelessWidget {
  const HorizontalPadding({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: AppConstants.horizontalPaddingEdge, child: child);
  }
}

class SliverHorizontalPadding extends StatelessWidget {
  const SliverHorizontalPadding({super.key, required this.sliver});

  final Widget sliver;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(padding: AppConstants.horizontalPaddingEdge, sliver: sliver);
  }
}
