import 'package:flutter/material.dart';
import 'package:yc_ui/social_feed/responsive_cache_image.dart';

Widget buildFeedImageTile({
  required String url,
  required double width,
  required double height,
  required double borderRadius,
  required VoidCallback onTap,
  String? fallbackAssetPath,
  String? heroTag,
  String? overlayText,
  bool showOverlay = false,
}) {
  return SizedBox(
    width: width,
    height: height,
    child: Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          clipBehavior: Clip.hardEdge,
          child: ResponsiveCachedImage(
            url: url,
            borderRadius: borderRadius,
            fallbackAssetPath: fallbackAssetPath,
            onTap: onTap,
            heroTag: heroTag,
            width: width,
            height: height,
          ),
        ),

        if (showOverlay)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: Colors.black.withValues(alpha: 0.6),
            ),
            alignment: Alignment.center,
            child: Text(
              overlayText ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    ),
  );
}
