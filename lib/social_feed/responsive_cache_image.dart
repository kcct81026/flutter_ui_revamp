import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yc_ui/constants/app_colors.dart';
import 'package:yc_ui/constants/app_sizes.dart';
import 'package:yc_ui/widgets/shimmer_box.dart';

class ResponsiveCachedImage extends StatelessWidget {
  final String url;
  final double borderRadius;
  final String? fallbackAssetPath;
  final VoidCallback? onTap;
  final BoxFit fit;
  final String? heroTag;
  final double? width;
  final double? height;

  const ResponsiveCachedImage({
    super.key,
    required this.url,
    required this.borderRadius,
    this.fallbackAssetPath,
    this.onTap,
    this.fit = BoxFit.cover,
    this.heroTag,
    this.width,
    this.height,
  });

  Widget _placeholder() {
    return const ShimmerBox();
  }

  Widget _errorWidget() {
    if (fallbackAssetPath != null) {
      return Image.asset(
        fallbackAssetPath!,
        fit: fit,
        width: width,
        height: height,
      );
    }

    return Container(
      color: AppColors.grey20,
      alignment: Alignment.center,
      child: const Icon(Icons.broken_image, size: AppSizes.size32),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget image = CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      placeholder: (ctx, u) => _placeholder(),
      errorWidget: (ctx, u, err) => _errorWidget(),
      fadeInDuration: const Duration(milliseconds: 200),
      memCacheWidth: 800,
      memCacheHeight: 800,
    );

    if (onTap != null) {
      image = GestureDetector(onTap: onTap, child: image);
    }

    if (heroTag != null) {
      image = Hero(tag: heroTag!, child: image);
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      clipBehavior: Clip.hardEdge,
      child: image,
    );
  }
}
