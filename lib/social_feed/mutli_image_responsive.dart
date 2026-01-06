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
    Key? key,
    required this.urls,
    required this.borderRadius,
    required this.fallbackAssetPath,
    required this.onTap,
    this.spacing = AppSizes.paddingTwelve,
    this.heroTagPrefix,
  }) : assert(urls.length >= 1, 'At least one image is required'),
       super(key: key);

  @override
  State<MultipleImageResponsive> createState() =>
      _MultipleImageResponsiveState();
}

class _MultipleImageResponsiveState extends State<MultipleImageResponsive> {
  double? _firstWidth;
  double? _firstHeight;

  ImageStream? _imageStream;
  ImageStreamListener? _imageStreamListener;

  static const int maxSlots = 5;

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

  Widget _fullOverlayedTile({
    required Widget imageChild,
    required int indexToTap,
    required int totalCount,
    required double borderRadius,
  }) {
    final extras = totalCount - maxSlots;
    final shouldOverlay = totalCount > maxSlots && extras > 0;

    if (!shouldOverlay) return imageChild;

    return Stack(
      alignment: Alignment.center,
      children: [
        imageChild,
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => widget.onTap(indexToTap),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.45),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                alignment: Alignment.center,
                child: Text(
                  '+${extras}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: AppSizes.medium,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                    shadows: [
                      Shadow(
                        blurRadius: 6,
                        color: Colors.black45,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.urls.length;
    final slotsToShow = total >= maxSlots ? maxSlots : total;
    final hasDims = _firstWidth != null && _firstHeight != null;
    final bool isLandscape = hasDims ? (_firstWidth! > _firstHeight!) : false;

    return Padding(
      padding: EdgeInsets.only(top: widget.spacing),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final totalWidth = constraints.maxWidth;
          final s = widget.spacing;

          if (!isLandscape) {
            // Square / Portrait layout:
            final topW = (totalWidth - s) / 2.0;
            final topH = topW;
            final bottomChildW = (totalWidth - 2 * s) / 3.0;
            final bottomChildH = bottomChildW;

            Widget topTile(int slotIdx) {
              if (slotIdx >= slotsToShow)
                return SizedBox(width: topW, height: topH);
              final image = ResponsiveCachedImage(
                url: widget.urls[slotIdx],
                borderRadius: widget.borderRadius,
                fallbackAssetPath: widget.fallbackAssetPath,
                onTap: () => widget.onTap(slotIdx),
                fit: BoxFit.cover,
                heroTag: _heroTagFor(slotIdx),
                width: topW,
                height: topH,
              );
              if (slotIdx == 4 && total > maxSlots) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  child: _fullOverlayedTile(
                    imageChild: image,
                    indexToTap: 4,
                    totalCount: total,
                    borderRadius: widget.borderRadius,
                  ),
                );
              }
              return ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                child: image,
              );
            }

            Widget bottomTile(int slotIdx) {
              if (slotIdx >= slotsToShow)
                return SizedBox(width: bottomChildW, height: bottomChildH);
              final image = ResponsiveCachedImage(
                url: widget.urls[slotIdx],
                borderRadius: widget.borderRadius,
                fallbackAssetPath: widget.fallbackAssetPath,
                onTap: () => widget.onTap(slotIdx),
                fit: BoxFit.cover,
                heroTag: _heroTagFor(slotIdx),
                width: bottomChildW,
                height: bottomChildH,
              );
              if (slotIdx == 4 && total > maxSlots) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  child: _fullOverlayedTile(
                    imageChild: image,
                    indexToTap: 4,
                    totalCount: total,
                    borderRadius: widget.borderRadius,
                  ),
                );
              }
              return ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                child: image,
              );
            }

            return Column(
              children: [
                Row(
                  children: [
                    topTile(0),
                    SizedBox(width: s),
                    topTile(1),
                  ],
                ),
                SizedBox(height: s),
                Row(
                  children: [
                    bottomTile(2),
                    SizedBox(width: s),
                    bottomTile(3),
                    SizedBox(width: s),
                    bottomTile(4),
                  ],
                ),
              ],
            );
          } else {
            // LANDSCAPE: force left and right columns equal width = (totalWidth - s) / 2
            final columnW = (totalWidth - s) / 2.0;
            final leftTileSize = columnW; // left squares (1:1)
            // rightTileHeight chosen so total heights match:
            // 2*leftTileSize + s == 3*rightTileHeight + 2*s
            var rightTileHeight = (2.0 * leftTileSize - s) / 3.0;
            if (rightTileHeight.isNaN || rightTileHeight <= 0) {
              rightTileHeight = leftTileSize * (2.0 / 3.0); // fallback
            }

            // Right column uses images 2,3,4 (top->mid->bottom)
            Widget rightTileForSlot(int slotIndex) {
              final imgIndex = 2 + slotIndex;
              if (imgIndex >= total)
                return SizedBox(width: columnW, height: rightTileHeight);
              final image = ResponsiveCachedImage(
                url: widget.urls[imgIndex],
                borderRadius: widget.borderRadius,
                fallbackAssetPath: widget.fallbackAssetPath,
                onTap: () => widget.onTap(imgIndex),
                fit: BoxFit.cover,
                heroTag: _heroTagFor(imgIndex),
                width: columnW,
                height: rightTileHeight,
              );

              // overlay appears on right-bottom tile (slotIndex==2) when extras
              if (slotIndex == 2 && total > maxSlots) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  child: _fullOverlayedTile(
                    imageChild: image,
                    indexToTap: imgIndex, // will be 4 when total>=5
                    totalCount: total,
                    borderRadius: widget.borderRadius,
                  ),
                );
              }

              return ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                child: image,
              );
            }

            // Left column: image 0 (top) and image 1 (bottom)
            Widget leftTop() {
              final idx = 0;
              if (idx >= total)
                return SizedBox(width: columnW, height: leftTileSize);
              final image = ResponsiveCachedImage(
                url: widget.urls[idx],
                borderRadius: widget.borderRadius,
                fallbackAssetPath: widget.fallbackAssetPath,
                onTap: () => widget.onTap(idx),
                fit: BoxFit.cover,
                heroTag: _heroTagFor(idx),
                width: columnW,
                height: leftTileSize,
              );
              return ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                child: image,
              );
            }

            Widget leftBottom() {
              final idx = 1;
              if (idx >= total)
                return SizedBox(width: columnW, height: leftTileSize);
              final image = ResponsiveCachedImage(
                url: widget.urls[idx],
                borderRadius: widget.borderRadius,
                fallbackAssetPath: widget.fallbackAssetPath,
                onTap: () => widget.onTap(idx),
                fit: BoxFit.cover,
                heroTag: _heroTagFor(idx),
                width: columnW,
                height: leftTileSize,
              );
              return ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                child: image,
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left column: two squares with one spacing between -> total = 2*leftTileSize + s
                Column(
                  children: [
                    leftTop(),
                    SizedBox(height: s),
                    leftBottom(),
                  ],
                ),

                SizedBox(width: s),

                // Right column: three tiles stacked with two spacings -> total = 3*rightTileHeight + 2*s
                Column(
                  children: [
                    rightTileForSlot(0),
                    SizedBox(height: s),
                    rightTileForSlot(1),
                    SizedBox(height: s),
                    rightTileForSlot(2),
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
