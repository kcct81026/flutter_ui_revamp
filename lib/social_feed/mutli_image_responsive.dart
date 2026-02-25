import 'package:flutter/material.dart';
import 'package:yc_ui/social_feed/responsive_cache_image.dart';
import 'package:yc_ui/constants/app_sizes.dart';

class MultipleImageResponsive extends StatefulWidget {
  final List<String> urls;
  final double borderRadius;
  final String? fallbackAssetPath;
  final void Function(int index) onTap;
  final double spacing;
  final String? heroTagPrefix;

  const MultipleImageResponsive({
    super.key,
    required this.urls,
    required this.borderRadius,
    required this.fallbackAssetPath,
    required this.onTap,
    this.spacing = AppSizes.paddingTwelve,
    this.heroTagPrefix,
  }) : assert(urls.length >= 1);

  @override
  State<MultipleImageResponsive> createState() =>
      _MultipleImageResponsiveState();
}

class _MultipleImageResponsiveState extends State<MultipleImageResponsive> {
  double? _firstWidth;
  double? _firstHeight;

  static const int maxSlots = 5;

  @override
  void initState() {
    super.initState();
    _resolveFirstImage();
  }

  void _resolveFirstImage() {
    final provider = NetworkImage(widget.urls.first);
    provider
        .resolve(const ImageConfiguration())
        .addListener(
          ImageStreamListener((info, _) {
            if (!mounted) return;
            setState(() {
              _firstWidth = info.image.width.toDouble();
              _firstHeight = info.image.height.toDouble();
            });
          }),
        );
  }

  String? _heroTagFor(int index) {
    final p = widget.heroTagPrefix;
    if (p == null) return null;
    return '$p-$index-${widget.urls[index]}';
  }

  Widget _tile({
    required double width,
    required double height,
    required int index,
    required int total,
  }) {
    if (index >= total) {
      return SizedBox(width: width, height: height);
    }

    final image = ResponsiveCachedImage(
      url: widget.urls[index],
      borderRadius: widget.borderRadius,
      fallbackAssetPath: widget.fallbackAssetPath,
      onTap: () => widget.onTap(index),
      heroTag: _heroTagFor(index),
      width: width,
      height: height,
    );

    // Overlay +N only on last visible tile
    if (index == 4 && total > maxSlots) {
      final extra = total - maxSlots;

      return SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            image,
            Positioned.fill(
              child: Material(
                color: Colors.black.withValues(alpha: 0.45),
                child: InkWell(
                  onTap: () => widget.onTap(index),
                  child: Center(
                    child: Text(
                      '+$extra',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return SizedBox(width: width, height: height, child: image);
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.urls.length;
    final isLandscape = _firstWidth != null && _firstHeight != null
        ? _firstWidth! > _firstHeight!
        : false;

    return Padding(
      padding: EdgeInsets.only(top: widget.spacing),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final totalWidth = constraints.maxWidth;
          final s = widget.spacing;

          // -------------------------
          // PORTRAIT / SQUARE LAYOUT
          // -------------------------
          if (!isLandscape) {
            final topW = (totalWidth - s) / 2;
            final topH = topW;

            final bottomW = (totalWidth - (2 * s)) / 3;
            final bottomH = bottomW;

            return Column(
              children: [
                Row(
                  children: [
                    _tile(width: topW, height: topH, index: 0, total: total),
                    SizedBox(width: s),
                    _tile(width: topW, height: topH, index: 1, total: total),
                  ],
                ),
                SizedBox(height: s),
                Row(
                  children: [
                    _tile(
                      width: bottomW,
                      height: bottomH,
                      index: 2,
                      total: total,
                    ),
                    SizedBox(width: s),
                    _tile(
                      width: bottomW,
                      height: bottomH,
                      index: 3,
                      total: total,
                    ),
                    SizedBox(width: s),
                    _tile(
                      width: bottomW,
                      height: bottomH,
                      index: 4,
                      total: total,
                    ),
                  ],
                ),
              ],
            );
          }

          // -------------------------
          // LANDSCAPE LAYOUT
          // -------------------------

          final columnWidth = (totalWidth - s) / 2;

          final leftTileSize = columnWidth;

          // height match math:
          // 2*left + s = 3*right + 2*s
          // => right = (2*left - s) / 3
          final rightTileHeight = (2 * leftTileSize - s) / 3;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // LEFT COLUMN
              Column(
                children: [
                  _tile(
                    width: columnWidth,
                    height: leftTileSize,
                    index: 0,
                    total: total,
                  ),
                  SizedBox(height: s),
                  _tile(
                    width: columnWidth,
                    height: leftTileSize,
                    index: 1,
                    total: total,
                  ),
                ],
              ),

              SizedBox(width: s),

              // RIGHT COLUMN
              Column(
                children: [
                  _tile(
                    width: columnWidth,
                    height: rightTileHeight,
                    index: 2,
                    total: total,
                  ),
                  SizedBox(height: s),
                  _tile(
                    width: columnWidth,
                    height: rightTileHeight,
                    index: 3,
                    total: total,
                  ),
                  SizedBox(height: s),
                  _tile(
                    width: columnWidth,
                    height: rightTileHeight,
                    index: 4,
                    total: total,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
