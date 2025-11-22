import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:easacc_task/core/utils/app_assets.dart';
import 'package:easacc_task/core/utils/extensions.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage(
    this.imageUrl, {
    super.key,
    this.fit,
    this.width,
    this.height,
    this.errorWidget,
    this.placeholder,
  });

  final String imageUrl;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final LoadingErrorWidgetBuilder? errorWidget;
  final PlaceholderWidgetBuilder? placeholder;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit ?? BoxFit.contain,
      width: width ?? context.width,
      height: height ?? context.width,
      errorWidget:
          errorWidget ??
          (context, url, error) => Image.asset(
            AppAsset.logoImage,
            // fit: fit ?? BoxFit.contain,
            width: width ?? context.width,
            height: height ?? context.width,
          ),
      placeholder:
          placeholder ??
          (context, url) => Image.asset(
            AppAsset.logoImage,
            // fit: fit ?? BoxFit.contain,
            width: width ?? context.width,
            height: height ?? context.width,
          ),
    );
  }
}
