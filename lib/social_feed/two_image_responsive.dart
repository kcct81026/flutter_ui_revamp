import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yc_ui/constants/app_colors.dart';
import 'package:yc_ui/constants/app_sizes.dart';

class TwoImageResponsive extends StatefulWidget {
  final List<String> urls;
  final double borderRadius;
  final String? fallbackAssetPath;
  final void Function(int index) onTap;
  final double spacing;

  const TwoImageResponsive({
    Key? key,
    required this.urls,
    required this.borderRadius,
    required this.fallbackAssetPath,
    required this.onTap,
    required this.spacing,
  }) : super(key: key);

  @override
  State<TwoImageResponsive> createState() => TwoImageResponsiveState();
}

class TwoImageResponsiveState extends State<TwoImageResponsive> {
  bool? _firstIsPortrait;

  // Keep references so we can remove the listener in dispose()
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
            _firstIsPortrait = h > w;
          });
        },
        onError: (dynamic _, StackTrace? __) {
          if (!mounted) return;
          setState(() {
            _firstIsPortrait = false; // default to landscape on error
          });
        },
      );

      stream.addListener(_imageStreamListener!);
    } catch (_) {
      // Safe fallback if something goes wrong when resolving the image
      if (mounted) {
        setState(() {
          _firstIsPortrait = false;
        });
      }
    }
  }

  @override
  void dispose() {
    // Remove listener if registered
    try {
      if (_imageStream != null && _imageStreamListener != null) {
        _imageStream!.removeListener(_imageStreamListener!);
      }
    } catch (_) {
      // ignore errors removing listener
    } finally {
      _imageStream = null;
      _imageStreamListener = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // until we know, show square placeholders to avoid layout jump
    final isPortrait = _firstIsPortrait ?? false;
    final aspect = isPortrait ? (1 / 2) : 1.0; // 1:2 -> 0.5, else 1:1

    return Padding(
      padding: EdgeInsets.only(top: widget.spacing),
      child: Row(
        children: [
          // first image
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              child: AspectRatio(
                aspectRatio: aspect,
                child: GestureDetector(
                  onTap: () => widget.onTap(0),
                  child: CachedNetworkImage(
                    imageUrl: widget.urls[0],
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
                    errorWidget: (ctx, url, error) =>
                        widget.fallbackAssetPath != null
                        ? Image.asset(
                            widget.fallbackAssetPath!,
                            fit: BoxFit.cover,
                          )
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
            ),
          ),

          // spacing between the two images
          SizedBox(width: widget.spacing),

          // second image
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              child: AspectRatio(
                aspectRatio: aspect,
                child: GestureDetector(
                  onTap: () => widget.onTap(1),
                  child: CachedNetworkImage(
                    imageUrl: widget.urls[1],
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
                    errorWidget: (ctx, url, error) =>
                        widget.fallbackAssetPath != null
                        ? Image.asset(
                            widget.fallbackAssetPath!,
                            fit: BoxFit.cover,
                          )
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
            ),
          ),
        ],
      ),
    );
  }
}
