import 'dart:math';
import 'package:flutter/material.dart';
import 'package:yc_ui/extensions/image_mapper.dart';
import 'package:yc_ui/social_feed/responsive_cache_image.dart';
import 'package:yc_ui/constants/app_sizes.dart';

class MultipleImageResponsive extends StatelessWidget {
  final List<FeedImage> images;
  final double borderRadius;
  final String? fallbackAssetPath;
  final void Function(int index) onTap;
  final double spacing;
  final String? heroTagPrefix;

  static const int maxSlots = 5;

  const MultipleImageResponsive({
    super.key,
    required this.images,
    required this.borderRadius,
    required this.fallbackAssetPath,
    required this.onTap,
    this.spacing = AppSizes.paddingTwelve,
    this.heroTagPrefix,
  });

  String? _heroTag(int index) {
    if (heroTagPrefix == null) return null;
    return '$heroTagPrefix-$index-${images[index].url}';
  }

  @override
  Widget build(BuildContext context) {
    final first = images.first;

    return Padding(
      padding: EdgeInsets.only(top: spacing),
      child: first.isLandscape
          ? _buildLandscape(context)
          : _buildPortrait(context),
    );
  }

  // LANDSCAPE FIRST IMAGE
  Widget _buildLandscape(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final s = spacing;

        final columnWidth = (width - s) / 2;
        final leftHeight = columnWidth;
        final rightHeight = (leftHeight * 2 - s) / 3;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                _tileSized(0, columnWidth, leftHeight),
                SizedBox(height: s),
                _tileSized(1, columnWidth, leftHeight),
              ],
            ),
            SizedBox(width: s),
            Column(
              children: [
                _tileSized(2, columnWidth, rightHeight),
                SizedBox(height: s),
                _tileSized(3, columnWidth, rightHeight),
                SizedBox(height: s),
                _tileSized(4, columnWidth, rightHeight),
              ],
            ),
          ],
        );
      },
    );
  }

  // PORTRAIT / SQUARE FIRST IMAGE
  Widget _buildPortrait(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final s = spacing;

        final topWidth = (width - s) / 2;
        final bottomWidth = (width - 2 * s) / 3;

        return Column(
          children: [
            Row(
              children: [
                _tileSized(0, topWidth, topWidth),
                SizedBox(width: s),
                _tileSized(1, topWidth, topWidth),
              ],
            ),
            SizedBox(height: s),
            Row(
              children: [
                _tileSized(2, bottomWidth, bottomWidth),
                SizedBox(width: s),
                _tileSized(3, bottomWidth, bottomWidth),
                SizedBox(width: s),
                _tileSized(4, bottomWidth, bottomWidth),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _tileSized(int index, double w, double h) {
    final displayCount = min(images.length, maxSlots);

    if (index >= displayCount) {
      return SizedBox(width: w, height: h);
    }

    return SizedBox(width: w, height: h, child: _tile(index));
  }

  Widget _tile(int index) {
    final image = ResponsiveCachedImage(
      url: images[index].url,
      borderRadius: borderRadius,
      fallbackAssetPath: fallbackAssetPath,
      fit: BoxFit.cover,
      heroTag: _heroTag(index),
      onTap: () => onTap(index),
    );

    /// +N overlay
    if (index == 4 && images.length > maxSlots) {
      final extra = images.length - maxSlots;

      return Stack(
        children: [
          Positioned.fill(child: image),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.45),
              alignment: Alignment.center,
              child: Text(
                '+$extra',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return image;
  }
}
