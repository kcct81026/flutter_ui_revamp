import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:yc_ui/constants/app_colors.dart';
import 'package:yc_ui/constants/app_sizes.dart';
import 'package:yc_ui/social_feed/full_screen_image.dart';
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
    Key? key,
    this.images,
    this.imageUrl,
    this.spacing = AppSizes.paddingFour / 2,
    this.borderRadius = AppSizes.paddingFour,
    this.fallbackAssetPath,
    this.maxGridItems = 9,
  }) : assert(
         images != null || imageUrl != null,
         'Either images or imageUrl must be provided',
       ),
       super(key: key);

  List<String> get _resolvedImages {
    if (images != null && images!.isNotEmpty) return images!;
    if (imageUrl != null) return [imageUrl!];
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final imgs = _resolvedImages;
    if (imgs.isEmpty) return const SizedBox.shrink();

    // Single image -> dynamic aspect handled by _DynamicAspectSingleImage
    if (imgs.length == 1) {
      return DynamicAspectSingleImage(
        url: imgs.first,
        borderRadius: borderRadius,
        fallbackAssetPath: fallbackAssetPath,
        onTap: () => _openFullScreen(context, imgs, 0),
      );
    }

    // Multiple images -> grid (special-case for exactly 2 images)
    final displayed = imgs.take(maxGridItems).toList();

    // Special layout when exactly two images
    if (displayed.length == 2) {
      return TwoImageResponsive(
        urls: displayed,
        borderRadius: borderRadius,
        fallbackAssetPath: fallbackAssetPath,
        onTap: (index) => _openFullScreen(context, displayed, index),
        spacing: spacing,
      );
    }

    // Special layout when exactly three images
    if (displayed.length == 3) {
      return ThreeImageResponsive(
        urls: displayed,
        borderRadius: borderRadius,
        fallbackAssetPath: fallbackAssetPath,
        onTap: (index) => _openFullScreen(context, displayed, index),
        spacing: spacing,
      );
    }

    final crossCount = displayed.length == 2 ? 2 : 3;

    return Padding(
      padding: EdgeInsets.only(top: spacing),
      child: GridView.count(
        crossAxisCount: crossCount,
        mainAxisSpacing: spacing,
        crossAxisSpacing: spacing,
        childAspectRatio: 1,
        padding:
            EdgeInsets.zero, // ensure GridView itself adds no extra padding
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
          displayed.length,
          (index) => _buildTappableImage(context, displayed, index),
        ),
      ),
    );
  }

  Widget _buildTappableImage(
    BuildContext context,
    List<String> list,
    int index,
  ) {
    final url = list[index];
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: GestureDetector(
        onTap: () => _openFullScreen(context, list, index),
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          placeholder: (ctx, url) => Container(
            color: AppColors.grey20,
            alignment: Alignment.center,
            child: const SizedBox(
              width: AppSizes.size30,
              height: AppSizes.size30,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          errorWidget: (ctx, url, error) => _fallbackWidget(),
        ),
      ),
    );
  }

  Widget _fallbackWidget() {
    if (fallbackAssetPath != null) {
      return Image.asset(fallbackAssetPath!, fit: BoxFit.cover);
    }

    return Container(
      color: AppColors.grey20,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.broken_image,
              size: AppSizes.size36,
              color: AppColors.grey50,
            ),
            const SizedBox(height: AppSizes.paddingEight),
            Text(
              'Image unavailable',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: AppSizes.regular,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
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
