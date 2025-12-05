import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yc_ui/constants/app_colors.dart';
import 'package:yc_ui/constants/app_sizes.dart';

class DynamicAspectSingleImage extends StatefulWidget {
  final String url;
  final double borderRadius;
  final String? fallbackAssetPath;
  final VoidCallback onTap;

  const DynamicAspectSingleImage({
    required this.url,
    required this.borderRadius,
    required this.fallbackAssetPath,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<DynamicAspectSingleImage> createState() =>
      DynamicAspectSingleImageState();
}

class DynamicAspectSingleImageState extends State<DynamicAspectSingleImage> {
  double? _aspectRatio;

  // Keep references so we can remove the listener in dispose()
  ImageStream? _imageStream;
  ImageStreamListener? _imageStreamListener;

  @override
  void initState() {
    super.initState();
    _loadImageDimensions();
  }

  void _loadImageDimensions() {
    // Use ImageProvider.resolve (NetworkImage) to get an ImageStream we can remove later
    final provider = NetworkImage(widget.url);
    final stream = provider.resolve(const ImageConfiguration());
    _imageStream = stream;

    _imageStreamListener = ImageStreamListener(
      (ImageInfo info, bool _) {
        final width = info.image.width.toDouble();
        final height = info.image.height.toDouble();

        // Guard against calling setState when disposed
        if (!mounted) return;
        setState(() {
          _aspectRatio = height > width ? 2 / 3 : 1 / 1;
        });
      },
      onError: (dynamic _, StackTrace? __) {
        if (!mounted) return;
        setState(() {
          _aspectRatio = 1 / 1;
        });
      },
    );

    // Register listener
    try {
      stream.addListener(_imageStreamListener!);
    } catch (_) {
      // If addListener fails for any reason, set a safe default
      if (mounted) {
        setState(() {
          _aspectRatio = 1 / 1;
        });
      }
    }
  }

  @override
  void dispose() {
    // Remove listener if registered. Wrap in try/catch to avoid throwing in dispose.
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
    final ratio = _aspectRatio ?? 1.0;

    return AspectRatio(
      aspectRatio: ratio,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: GestureDetector(
          onTap: widget.onTap,
          child: CachedNetworkImage(
            imageUrl: widget.url,
            fit: BoxFit.cover,
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
                    child: const Icon(
                      Icons.broken_image,
                      size: AppSizes.size32,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
