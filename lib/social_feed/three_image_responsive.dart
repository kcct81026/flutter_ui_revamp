import 'package:flutter/material.dart';
import 'package:yc_ui/social_feed/responsive_cache_image.dart';
import 'package:yc_ui/widgets/feed_image_tile.dart';

class ThreeImageResponsive extends StatefulWidget {
  final List<String> urls;
  final double borderRadius;
  final String? fallbackAssetPath;
  final void Function(int index) onTap;
  final double spacing;
  final String? heroTagPrefix;

  const ThreeImageResponsive({
    super.key,
    required this.urls,
    required this.borderRadius,
    required this.fallbackAssetPath,
    required this.onTap,
    required this.spacing,
    this.heroTagPrefix,
  }) : assert(urls.length == 3, 'ThreeImageResponsive requires exactly 3 urls');

  @override
  State<ThreeImageResponsive> createState() => _ThreeImageResponsiveState();
}

class _ThreeImageResponsiveState extends State<ThreeImageResponsive> {
  double? _firstWidth;
  double? _firstHeight;

  ImageStream? _imageStream;
  ImageStreamListener? _imageStreamListener;

  @override
  void initState() {
    super.initState();
    _resolveFirstImage();
  }

  void _resolveFirstImage() {
    try {
      final provider = NetworkImage(widget.urls.first);
      final stream = provider.resolve(const ImageConfiguration());
      _imageStream = stream;

      _imageStreamListener = ImageStreamListener(
        (info, _) {
          final w = info.image.width.toDouble();
          final h = info.image.height.toDouble();
          if (!mounted) return;

          setState(() {
            _firstWidth = w;
            _firstHeight = h;
          });

          // remove listener after first frame
          try {
            if (_imageStream != null && _imageStreamListener != null) {
              _imageStream!.removeListener(_imageStreamListener!);
            }
          } catch (_) {}
          _imageStream = null;
          _imageStreamListener = null;
        },
        onError: (dynamic _, StackTrace? __) {
          if (!mounted) return;
          setState(() {
            _firstWidth = 1;
            _firstHeight = 1;
          });
        },
      );

      stream.addListener(_imageStreamListener!);
    } catch (_) {
      if (mounted) {
        setState(() {
          _firstWidth = 1;
          _firstHeight = 1;
        });
      }
    }
  }

  @override
  void dispose() {
    try {
      if (_imageStream != null && _imageStreamListener != null) {
        _imageStream!.removeListener(_imageStreamListener!);
      }
    } catch (_) {}
    _imageStream = null;
    _imageStreamListener = null;
    super.dispose();
  }

  String? _heroTagFor(int index) {
    final p = widget.heroTagPrefix;
    if (p == null) return null;
    return '$p-$index-${widget.urls[index]}';
  }

  @override
  Widget build(BuildContext context) {
    // Determine type from resolved first image
    final hasDims = _firstWidth != null && _firstHeight != null;
    final bool isPortrait;
    final bool isSquare;
    final bool isLandscape;

    if (!hasDims) {
      // default to square (avoids super-tall placeholders before resolve)
      isSquare = true;
      isPortrait = false;
      isLandscape = false;
    } else {
      final w = _firstWidth!;
      final h = _firstHeight!;
      if (w == h) {
        isSquare = true;
        isPortrait = false;
        isLandscape = false;
      } else if (h > w) {
        isPortrait = true;
        isSquare = false;
        isLandscape = false;
      } else {
        isLandscape = true;
        isSquare = false;
        isPortrait = false;
      }
    }

    return Padding(
      padding: EdgeInsets.only(top: widget.spacing),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final totalWidth = constraints.maxWidth;
          final s = widget.spacing;

          if (isPortrait) {
            // Portrait layout:

            final numerator = 1.5 * totalWidth - 2.5 * s;
            const denom = 4.5;
            double rightWidth = numerator / denom;

            if (rightWidth <= 0 || rightWidth.isNaN || rightWidth.isInfinite) {
              rightWidth = (totalWidth - s) / 2.0;
            }

            final leftWidth = totalWidth - s - rightWidth;
            final rightImageHeight = rightWidth * 1.5; // 2:3 -> h = w * 1.5
            final totalRightHeight = rightImageHeight * 2 + s;
            final finalLeftHeight = totalRightHeight;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left large image (img0)
                SizedBox(
                  width: leftWidth,
                  height: finalLeftHeight,
                  child: buildFeedImageTile(
                    url: widget.urls[0],
                    width: leftWidth,
                    height: finalLeftHeight,
                    borderRadius: widget.borderRadius,
                    fallbackAssetPath: widget.fallbackAssetPath,
                    onTap: () => widget.onTap(0),
                    heroTag: _heroTagFor(0),
                  ),
                ),

                SizedBox(width: s),

                // Right column: two stacked 2:3 images (img1, img2)
                SizedBox(
                  width: rightWidth,
                  height: finalLeftHeight,
                  child: Column(
                    children: [
                      SizedBox(
                        width: rightWidth,
                        height: rightImageHeight,
                        child: buildFeedImageTile(
                          url: widget.urls[1],
                          width: rightWidth,
                          height: rightImageHeight,
                          borderRadius: widget.borderRadius,
                          fallbackAssetPath: widget.fallbackAssetPath,
                          onTap: () => widget.onTap(1),
                          heroTag: _heroTagFor(1),
                        ),
                      ),
                      SizedBox(height: s),
                      SizedBox(
                        width: rightWidth,
                        height: rightImageHeight,
                        child: buildFeedImageTile(
                          url: widget.urls[2],
                          width: rightWidth,
                          height: rightImageHeight,
                          borderRadius: widget.borderRadius,
                          fallbackAssetPath: widget.fallbackAssetPath,
                          onTap: () => widget.onTap(2),
                          heroTag: _heroTagFor(2),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            // Non-portrait: choose top aspect depending on square vs landscape
            final topAspect = isSquare ? (75.0 / 49.0) : (2.0 / 1.0);
            final topHeight = totalWidth / topAspect; // height = width / (w/h)
            final bottomChildWidth = (totalWidth - s) / 2.0;
            final bottomChildHeight = bottomChildWidth; // 1:1

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: totalWidth,
                  height: topHeight,
                  child: buildFeedImageTile(
                    url: widget.urls[0],
                    width: totalWidth,
                    height: topHeight,
                    borderRadius: widget.borderRadius,
                    fallbackAssetPath: widget.fallbackAssetPath,
                    onTap: () => widget.onTap(0),
                    heroTag: _heroTagFor(0),
                  ),
                ),
                SizedBox(height: s),
                Row(
                  children: [
                    SizedBox(
                      width: bottomChildWidth,
                      height: bottomChildHeight,
                      child: buildFeedImageTile(
                        url: widget.urls[1],
                        width: bottomChildWidth,
                        height: bottomChildHeight,
                        borderRadius: widget.borderRadius,
                        fallbackAssetPath: widget.fallbackAssetPath,
                        onTap: () => widget.onTap(1),
                        heroTag: _heroTagFor(1),
                      ),
                    ),
                    SizedBox(width: s),
                    SizedBox(
                      width: bottomChildWidth,
                      height: bottomChildHeight,
                      child: buildFeedImageTile(
                        url: widget.urls[2],
                        width: bottomChildWidth,
                        height: bottomChildHeight,
                        borderRadius: widget.borderRadius,
                        fallbackAssetPath: widget.fallbackAssetPath,
                        onTap: () => widget.onTap(2),
                        heroTag: _heroTagFor(2),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
