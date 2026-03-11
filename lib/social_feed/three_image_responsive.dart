import 'package:flutter/material.dart';
import 'package:yc_ui/extensions/image_mapper.dart';
import 'package:yc_ui/social_feed/responsive_cache_image.dart';

class ThreeImageResponsive extends StatelessWidget {
  final List<FeedImage> images;
  final double borderRadius;
  final String? fallbackAssetPath;
  final void Function(int index) onTap;
  final double spacing;
  final String? heroTagPrefix;

  const ThreeImageResponsive({
    super.key,
    required this.images,
    required this.borderRadius,
    required this.fallbackAssetPath,
    required this.onTap,
    required this.spacing,
    this.heroTagPrefix,
  }) : assert(images.length == 3);

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
      child: first.isPortrait
          ? _buildPortrait(context)
          : first.isLandscape
          ? _buildLandscape(context)
          : _buildSquare(context),
    );
  }

  // PORTRAIT
  Widget _buildPortrait(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;
        final s = spacing;

        final numerator = 1.5 * totalWidth - 2.5 * s;
        const denom = 4.5;

        double rightWidth = numerator / denom;

        if (rightWidth <= 0 || rightWidth.isNaN || rightWidth.isInfinite) {
          rightWidth = (totalWidth - s) / 2.0;
        }

        final leftWidth = totalWidth - s - rightWidth;

        // 2:3 portrait ratio
        final rightImageHeight = rightWidth * 1.5;

        final totalRightHeight = rightImageHeight * 2 + s;

        final leftHeight = totalRightHeight;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LEFT BIG PORTRAIT
            SizedBox(width: leftWidth, height: leftHeight, child: _image(0)),

            SizedBox(width: s),

            // RIGHT STACKED PORTRAITS
            SizedBox(
              width: rightWidth,
              height: leftHeight,
              child: Column(
                children: [
                  SizedBox(
                    width: rightWidth,
                    height: rightImageHeight,
                    child: _image(1),
                  ),
                  SizedBox(height: s),
                  SizedBox(
                    width: rightWidth,
                    height: rightImageHeight,
                    child: _image(2),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // LANDSCAPE
  Widget _buildLandscape(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;
        final s = spacing;

        final topHeight = totalWidth / (3 / 2); // 3:2 ratio
        final bottomWidth = (totalWidth - s) / 2;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(width: totalWidth, height: topHeight, child: _image(0)),
            SizedBox(height: s),
            Row(
              children: [
                SizedBox(
                  width: bottomWidth,
                  height: bottomWidth,
                  child: _image(1),
                ),
                SizedBox(width: s),
                SizedBox(
                  width: bottomWidth,
                  height: bottomWidth,
                  child: _image(2),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // SQUARE
  Widget _buildSquare(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;
        final s = spacing;

        final bottomWidth = (totalWidth - s) / 2;

        return Column(
          children: [
            SizedBox(width: totalWidth, height: totalWidth, child: _image(0)),
            SizedBox(height: s),
            Row(
              children: [
                SizedBox(
                  width: bottomWidth,
                  height: bottomWidth,
                  child: _image(1),
                ),
                SizedBox(width: s),
                SizedBox(
                  width: bottomWidth,
                  height: bottomWidth,
                  child: _image(2),
                ),
              ],
            ),
          ],
        );
      },
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
