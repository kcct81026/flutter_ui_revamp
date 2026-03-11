import 'package:flutter/material.dart';
import 'package:yc_ui/constants/app_sizes.dart';
import 'package:yc_ui/extensions/image_mapper.dart';
import 'package:yc_ui/social_feed/four_image_responsive.dart';
import 'package:yc_ui/social_feed/full_screen_image.dart';
import 'package:yc_ui/social_feed/mutli_image_responsive.dart';
import 'package:yc_ui/social_feed/single_image.dart';
import 'package:yc_ui/social_feed/three_image_responsive.dart';
import 'package:yc_ui/social_feed/two_image_responsive.dart';

class FeedImageGrid extends StatelessWidget {
  final List<String>? images;
  final String? imageUrl;
  final double spacing;
  final double borderRadius;
  final String? fallbackAssetPath; // e.g. 'assets/image_placeholder.png'
  final int maxGridItems;

  const FeedImageGrid({
    super.key,
    this.images,
    this.imageUrl,
    this.spacing = AppSizes.paddingFour / 2,
    this.borderRadius = AppSizes.paddingFour,
    this.fallbackAssetPath,
    this.maxGridItems = 9,
  }) : assert(
         images != null || imageUrl != null,
         'Either images or imageUrl must be provided',
       );

  List<String> get _resolvedImages {
    if (images != null && images!.isNotEmpty) return images!;
    if (imageUrl != null) return [imageUrl!];
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final imgs = _resolvedImages;
    if (imgs.isEmpty) return const SizedBox.shrink();

    // Single image
    if (imgs.length == 1) {
      return DynamicAspectSingleImage(
        url: imgs.first,
        borderRadius: borderRadius,
        fallbackAssetPath: fallbackAssetPath,
        onTap: () => _openFullScreen(context, imgs, 0),
      );
    }

    // Multiple images
    final displayed = imgs.take(maxGridItems).toList();

    // Special layout when exactly two images
    if (displayed.length == 2) {
      return TwoImageResponsive(
        images: displayed.toFeedImages(),
        borderRadius: borderRadius,
        fallbackAssetPath: fallbackAssetPath,
        onTap: (index) => _openFullScreen(context, displayed, index),
        spacing: spacing,
      );
    }

    // Special layout when exactly three images
    if (displayed.length == 3) {
      return ThreeImageResponsive(
        images: displayed.toFeedImages(),
        borderRadius: borderRadius,
        fallbackAssetPath: fallbackAssetPath,
        onTap: (index) => _openFullScreen(context, displayed, index),
        spacing: spacing,
      );
    }

    // Special layout when exactly four images
    if (displayed.length == 4) {
      return FourImageResponsive(
        images: displayed.toFeedImages(),
        borderRadius: borderRadius,
        fallbackAssetPath: fallbackAssetPath,
        onTap: (index) => _openFullScreen(context, displayed, index),
        spacing: spacing,
      );
    }

    return MultipleImageResponsive(
      images: displayed.toFeedImages(),
      borderRadius: borderRadius,
      fallbackAssetPath: fallbackAssetPath,
      onTap: (index) => _openFullScreen(context, displayed, index),
      spacing: spacing,
    );
  }

  void _openFullScreen(
    BuildContext context,
    List<String> urls,
    int startIndex,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FullScreenGallery(
          urls: urls,
          initialIndex: startIndex,
          fallbackAssetPath: fallbackAssetPath,
        ),
      ),
    );
  }
}
