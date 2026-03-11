import 'package:flutter/material.dart';
import 'package:yc_ui/extensions/image_mapper.dart';
import 'package:yc_ui/social_feed/responsive_cache_image.dart';

class MediaTile extends StatelessWidget {
  final FeedImage media;
  final double borderRadius;
  final String? fallbackAssetPath;
  final VoidCallback? onTap;
  final String? heroTag;

  const MediaTile({
    super.key,
    required this.media,
    required this.borderRadius,
    this.fallbackAssetPath,
    this.onTap,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    // Video tile
    if (media.isVideo) {
      return Stack(
        alignment: Alignment.center,
        children: [
          ResponsiveCachedImage(
            url: media.thumbnail ?? media.url,
            borderRadius: borderRadius,
            fallbackAssetPath: fallbackAssetPath,
            fit: BoxFit.cover,
          ),
          const Icon(Icons.play_circle_fill, color: Colors.white, size: 48),
        ],
      );
    }

    // Image tile
    return ResponsiveCachedImage(
      url: media.url,
      borderRadius: borderRadius,
      fallbackAssetPath: fallbackAssetPath,
      onTap: onTap,
      heroTag: heroTag,
      fit: BoxFit.cover,
    );
  }
}
