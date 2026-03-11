import 'package:flutter/material.dart';
import 'package:yc_ui/social_feed/responsive_cache_image.dart';
import 'package:yc_ui/extensions/image_mapper.dart';

class TwoImageResponsive extends StatelessWidget {
  final List<FeedImage> images;
  final double borderRadius;
  final String? fallbackAssetPath;
  final void Function(int index) onTap;
  final double spacing;
  final String? heroTagPrefix;

  const TwoImageResponsive({
    super.key,
    required this.images,
    required this.borderRadius,
    required this.fallbackAssetPath,
    required this.onTap,
    required this.spacing,
    this.heroTagPrefix,
  }) : assert(images.length == 2);

  String? _heroTagFor(int index) {
    final p = heroTagPrefix;
    if (p == null) return null;
    return '$p-$index-${images[index].url}';
  }

  @override
  Widget build(BuildContext context) {
    final first = images.first;

    return Padding(
      padding: EdgeInsets.only(top: spacing),
      child: first.isLandscape
          ? _buildLandscape(context)
          : _buildSideBySide(first),
    );
  }

  // LANDSCAPE
  Widget _buildLandscape(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;
        final height = totalWidth / 2; // 2:1 ratio

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(width: totalWidth, height: height, child: _image(0)),
            SizedBox(height: spacing),
            SizedBox(width: totalWidth, height: height, child: _image(1)),
          ],
        );
      },
    );
  }

  // PORTRAIT or SQUARE
  Widget _buildSideBySide(FeedImage first) {
    double aspect;

    if (first.isPortrait) {
      aspect = 1 / 2; // portrait (1:2)
    } else {
      aspect = 1; // square
    }

    return Row(
      children: [
        Expanded(
          child: AspectRatio(aspectRatio: aspect, child: _image(0)),
        ),
        SizedBox(width: spacing),
        Expanded(
          child: AspectRatio(aspectRatio: aspect, child: _image(1)),
        ),
      ],
    );
  }

  Widget _image(int index) {
    return ResponsiveCachedImage(
      url: images[index].url,
      borderRadius: borderRadius,
      fallbackAssetPath: fallbackAssetPath,
      onTap: () => onTap(index),
      fit: BoxFit.cover,
      heroTag: _heroTagFor(index),
    );
  }
}
