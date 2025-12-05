import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yc_ui/constants/app_colors.dart';
import 'package:yc_ui/constants/app_sizes.dart';

class ThreeImageResponsive extends StatefulWidget {
  final List<String> urls;
  final double borderRadius;
  final String? fallbackAssetPath;
  final void Function(int index) onTap;
  final double spacing;

  const ThreeImageResponsive({
    Key? key,
    required this.urls,
    required this.borderRadius,
    required this.fallbackAssetPath,
    required this.onTap,
    required this.spacing,
  }) : assert(urls.length == 3, 'ThreeImageResponsive requires exactly 3 urls'),
       super(key: key);

  @override
  State<ThreeImageResponsive> createState() => _ThreeImageResponsiveState();
}

class _ThreeImageResponsiveState extends State<ThreeImageResponsive> {
  bool? _firstIsPortrait;

  ImageStream? _imageStream;
  ImageStreamListener? _imageStreamListener;

  @override
  void initState() {
    super.initState();
    _checkFirstImage();
  }

  void _checkFirstImage() {
    final provider = NetworkImage(widget.urls.first);
    final stream = provider.resolve(const ImageConfiguration());
    _imageStream = stream;

    _imageStreamListener = ImageStreamListener(
      (ImageInfo info, bool _) {
        final w = info.image.width.toDouble();
        final h = info.image.height.toDouble();
        if (!mounted) return;
        setState(() => _firstIsPortrait = h > w);
      },
      onError: (dynamic _, StackTrace? __) {
        if (!mounted) return;
        setState(() => _firstIsPortrait = false);
      },
    );

    stream.addListener(_imageStreamListener!);
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

  Widget _buildCached(String url, int index, {BoxFit fit = BoxFit.cover}) {
    return GestureDetector(
      onTap: () => widget.onTap(index),
      child: CachedNetworkImage(
        imageUrl: url,
        fit: fit,
        placeholder: (ctx, url) => Container(
          color: AppColors.grey20,
          alignment: Alignment.center,
          child: const SizedBox(
            width: AppSizes.size28,
            height: AppSizes.size28,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
        errorWidget: (ctx, url, error) => widget.fallbackAssetPath != null
            ? Image.asset(widget.fallbackAssetPath!, fit: BoxFit.cover)
            : Container(
                color: AppColors.grey20,
                alignment: Alignment.center,
                child: const Icon(Icons.broken_image, size: AppSizes.size36),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait = _firstIsPortrait ?? false;

    final topLandscapeAspect = 75.0 / 49.0; // width/height
    final portraitAspect = 2.0 / 3.0; // width/height (0.666..)
    final squareAspect = 1.0;

    return Padding(
      padding: EdgeInsets.only(top: widget.spacing),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final totalWidth = constraints.maxWidth;
          final s = widget.spacing;

          if (isPortrait) {
            final numerator = 1.5 * totalWidth - 2.5 * s;
            final denom = 4.5;
            double rightWidth = numerator / denom;

            // safety fallback if available width small — use half-and-half
            if (rightWidth <= 0 || rightWidth.isNaN || rightWidth.isInfinite) {
              final half = (totalWidth - s) / 2.0;
              rightWidth = half;
            }

            final leftWidth = totalWidth - s - rightWidth;

            final rightImageHeight = rightWidth * 1.5;
            final totalRightHeight = rightImageHeight * 2 + s;
            final leftHeight = leftWidth * 1.5;

            final finalLeftHeight = totalRightHeight;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // LEFT (img0)
                SizedBox(
                  width: leftWidth,
                  height: finalLeftHeight,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    child: _buildCached(widget.urls[0], 0),
                  ),
                ),

                SizedBox(width: s),

                // RIGHT column: two 2:3 images stacked
                SizedBox(
                  width: rightWidth,
                  height: finalLeftHeight,
                  child: Column(
                    children: [
                      SizedBox(
                        height: rightImageHeight,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius,
                          ),
                          child: _buildCached(widget.urls[1], 1),
                        ),
                      ),
                      SizedBox(height: s),
                      SizedBox(
                        height: rightImageHeight,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius,
                          ),
                          child: _buildCached(widget.urls[2], 2),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            // landscape case unchanged
            final topHeight = totalWidth / topLandscapeAspect;
            final bottomChildWidth = (totalWidth - s) / 2.0;
            final bottomChildHeight = bottomChildWidth; // square

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: totalWidth,
                  height: topHeight,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    child: _buildCached(widget.urls[0], 0),
                  ),
                ),
                SizedBox(height: s),
                Row(
                  children: [
                    SizedBox(
                      width: bottomChildWidth,
                      height: bottomChildHeight,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          widget.borderRadius,
                        ),
                        child: _buildCached(widget.urls[1], 1),
                      ),
                    ),
                    SizedBox(width: s),
                    SizedBox(
                      width: bottomChildWidth,
                      height: bottomChildHeight,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          widget.borderRadius,
                        ),
                        child: _buildCached(widget.urls[2], 2),
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
