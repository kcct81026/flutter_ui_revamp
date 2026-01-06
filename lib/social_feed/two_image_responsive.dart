import 'package:flutter/material.dart';
import 'package:yc_ui/social_feed/responsive_cache_image.dart';

class TwoImageResponsive extends StatefulWidget {
  final List<String> urls;
  final double borderRadius;
  final String? fallbackAssetPath;
  final void Function(int index) onTap;
  final double spacing;
  final String? heroTagPrefix;

  const TwoImageResponsive({
    Key? key,
    required this.urls,
    required this.borderRadius,
    required this.fallbackAssetPath,
    required this.onTap,
    required this.spacing,
    this.heroTagPrefix,
  }) : assert(urls.length == 2, 'TwoImageResponsive requires exactly 2 urls'),
       super(key: key);

  @override
  State<TwoImageResponsive> createState() => TwoImageResponsiveState();
}

class TwoImageResponsiveState extends State<TwoImageResponsive> {
  double? _firstWidth;
  double? _firstHeight;

  ImageStream? _imageStream;
  ImageStreamListener? _imageStreamListener;

  @override
  void initState() {
    super.initState();
    _checkFirstImage();
  }

  void _checkFirstImage() {
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

          // remove after first delivered frame
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
    final hasDims = _firstWidth != null && _firstHeight != null;
    final bool isLandscape;
    final double aspectForRow; // used when showing side-by-side

    if (!hasDims) {
      // default to square while loading (avoid jump)
      isLandscape = false;
      aspectForRow = 1.0;
    } else {
      final w = _firstWidth!;
      final h = _firstHeight!;
      if (w == h) {
        isLandscape = false;
        aspectForRow = 1.0; // square
      } else if (h > w) {
        isLandscape = false;
        aspectForRow = 1.0 / 2.0; // portrait = width/height = 0.5 (1:2)
      } else {
        isLandscape = true;
        aspectForRow = 2.0 / 1.0; // unused for column layout
      }
    }

    if (isLandscape) {
      // Column layout: two full-width 2:1 images (height = width / 2)
      return Padding(
        padding: EdgeInsets.only(top: widget.spacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final w = constraints.maxWidth;
                final h = w / (2.0 / 1.0); // width / (width/height) => w/2
                return SizedBox(
                  width: w,
                  height: h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    child: ResponsiveCachedImage(
                      url: widget.urls[0],
                      borderRadius: widget.borderRadius,
                      fallbackAssetPath: widget.fallbackAssetPath,
                      onTap: () => widget.onTap(0),
                      fit: BoxFit.cover,
                      heroTag: _heroTagFor(0),
                      width: w,
                      height: h,
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: widget.spacing),
            LayoutBuilder(
              builder: (context, constraints) {
                final w = constraints.maxWidth;
                final h = w / 2.0;
                return SizedBox(
                  width: w,
                  height: h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    child: ResponsiveCachedImage(
                      url: widget.urls[1],
                      borderRadius: widget.borderRadius,
                      fallbackAssetPath: widget.fallbackAssetPath,
                      onTap: () => widget.onTap(1),
                      fit: BoxFit.cover,
                      heroTag: _heroTagFor(1),
                      width: w,
                      height: h,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    }

    // Row layout: two side-by-side with same aspect (square or portrait 1:2)
    return Padding(
      padding: EdgeInsets.only(top: widget.spacing),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              child: AspectRatio(
                aspectRatio: aspectForRow,
                child: ResponsiveCachedImage(
                  url: widget.urls[0],
                  borderRadius: widget.borderRadius,
                  fallbackAssetPath: widget.fallbackAssetPath,
                  onTap: () => widget.onTap(0),
                  fit: BoxFit.cover,
                  heroTag: _heroTagFor(0),
                ),
              ),
            ),
          ),
          SizedBox(width: widget.spacing),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              child: AspectRatio(
                aspectRatio: aspectForRow,
                child: ResponsiveCachedImage(
                  url: widget.urls[1],
                  borderRadius: widget.borderRadius,
                  fallbackAssetPath: widget.fallbackAssetPath,
                  onTap: () => widget.onTap(1),
                  fit: BoxFit.cover,
                  heroTag: _heroTagFor(1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
