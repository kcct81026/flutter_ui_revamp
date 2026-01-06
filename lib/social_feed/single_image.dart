import 'package:flutter/material.dart';
import 'package:yc_ui/social_feed/responsive_cache_image.dart';

class DynamicAspectSingleImage extends StatefulWidget {
  final String url;
  final double borderRadius;
  final String? fallbackAssetPath;
  final VoidCallback onTap;
  final String? heroTag; // optional

  const DynamicAspectSingleImage({
    required this.url,
    required this.borderRadius,
    required this.fallbackAssetPath,
    required this.onTap,
    this.heroTag,
    Key? key,
  }) : super(key: key);

  @override
  State<DynamicAspectSingleImage> createState() =>
      DynamicAspectSingleImageState();
}

class DynamicAspectSingleImageState extends State<DynamicAspectSingleImage> {
  double? _aspectRatio;

  ImageStream? _imageStream;
  ImageStreamListener? _imageStreamListener;

  @override
  void initState() {
    super.initState();
    _resolveAspectRatio();
  }

  void _resolveAspectRatio() {
    final provider = NetworkImage(widget.url);
    final stream = provider.resolve(const ImageConfiguration());
    _imageStream = stream;

    _imageStreamListener = ImageStreamListener(
      (ImageInfo info, bool _) {
        final w = info.image.width.toDouble();
        final h = info.image.height.toDouble();

        if (!mounted) return;
        setState(() {
          if (w == h) {
            _aspectRatio = 1 / 1; // square
          } else if (h > w) {
            _aspectRatio = 2 / 3; // portrait
          } else {
            _aspectRatio = 2 / 1; // landscape
          }
        });

        // We only needed the first frame to decide aspect — remove listener.
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
          _aspectRatio = 1 / 1; // fallback
        });
      },
    );

    try {
      stream.addListener(_imageStreamListener!);
    } catch (_) {
      if (mounted) {
        setState(() => _aspectRatio = 1 / 1);
      }
    }
  }

  @override
  void dispose() {
    try {
      if (_imageStream != null && _imageStreamListener != null) {
        _imageStream!.removeListener(_imageStreamListener!);
      }
    } catch (_) {
      // ignore
    } finally {
      _imageStream = null;
      _imageStreamListener = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ratio = _aspectRatio ?? 1.0; // default square while resolving

    return AspectRatio(
      aspectRatio: ratio,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: ResponsiveCachedImage(
          url: widget.url,
          borderRadius: widget.borderRadius,
          fallbackAssetPath: widget.fallbackAssetPath,
          onTap: widget.onTap,
          fit: BoxFit.cover,
          heroTag: widget.heroTag,
        ),
      ),
    );
  }
}
