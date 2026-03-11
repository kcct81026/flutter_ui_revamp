import 'package:flutter/material.dart';
import 'package:yc_ui/extensions/image_mapper.dart';
import 'package:yc_ui/social_feed/responsive_cache_image.dart';

class FourImageResponsive extends StatelessWidget {
  final List<FeedImage> images;
  final double borderRadius;
  final String? fallbackAssetPath;
  final void Function(int index) onTap;
  final double spacing;
  final String? heroTagPrefix;

  const FourImageResponsive({
    super.key,
    required this.images,
    required this.borderRadius,
    required this.fallbackAssetPath,
    required this.onTap,
    required this.spacing,
    this.heroTagPrefix,
  }) : assert(images.length == 4);

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
      child: first.isSquare
          ? _buildSquare()
          : first.isPortrait
          ? _buildPortrait(first)
          : _buildLandscape(first),
    );
  }

  // SQUARE
  Widget _buildSquare() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _squareImage(0)),
            SizedBox(width: spacing),
            Expanded(child: _squareImage(1)),
          ],
        ),
        SizedBox(height: spacing),
        Row(
          children: [
            Expanded(child: _squareImage(2)),
            SizedBox(width: spacing),
            Expanded(child: _squareImage(3)),
          ],
        ),
      ],
    );
  }

  Widget _squareImage(int index) {
    return AspectRatio(aspectRatio: 1, child: _buildImage(index));
  }

  // PORTRAIT
  Widget _buildPortrait(FeedImage first) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: AspectRatio(
            aspectRatio: first.aspectRatio,
            child: _buildImage(0),
          ),
        ),
        SizedBox(width: spacing),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              _squareImage(1),
              SizedBox(height: spacing),
              _squareImage(2),
              SizedBox(height: spacing),
              _squareImage(3),
            ],
          ),
        ),
      ],
    );
  }

  // LANDSCAPE
  Widget _buildLandscape(FeedImage first) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(aspectRatio: first.aspectRatio, child: _buildImage(0)),
        SizedBox(height: spacing),
        Row(
          children: [
            Expanded(child: _squareImage(1)),
            SizedBox(width: spacing),
            Expanded(child: _squareImage(2)),
            SizedBox(width: spacing),
            Expanded(child: _squareImage(3)),
          ],
        ),
      ],
    );
  }

  Widget _buildImage(int index) {
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
