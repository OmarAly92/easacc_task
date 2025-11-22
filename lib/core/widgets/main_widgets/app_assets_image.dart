import 'package:flutter/material.dart';

class AppAssetsImage extends StatelessWidget {
  const AppAssetsImage(
    this.imagePath, {
    super.key,
    this.height,
    this.width,
    this.fit,
    this.opacity,
  });

  final String imagePath;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Animation<double>? opacity;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      height: height,
      width: width,
      fit: fit ?? BoxFit.cover,
      opacity: opacity,
      errorBuilder: (context, error, stackTrace) {
        return const SizedBox.shrink();
      },
    );
  }
}
