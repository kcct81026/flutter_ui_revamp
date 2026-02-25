import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yc_ui/constants/app_colors.dart';
import 'package:yc_ui/constants/app_sizes.dart';

class FullScreenGallery extends StatefulWidget {
  final List<String> urls;
  final int initialIndex;
  final String? fallbackAssetPath;

  const FullScreenGallery({
    super.key,
    required this.urls,
    required this.initialIndex,
    this.fallbackAssetPath,
  });

  @override
  State<FullScreenGallery> createState() => FullScreenGalleryState();
}

class FullScreenGalleryState extends State<FullScreenGallery> {
  late PageController _controller;
  late int _current;

  @override
  void initState() {
    super.initState();
    _current = widget.initialIndex;
    _controller = PageController(initialPage: _current);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.header,
      appBar: AppBar(
        backgroundColor: AppColors.header,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.paddingTwelve,
            ),
            child: Center(child: Text('${_current + 1}/${widget.urls.length}')),
          ),
        ],
      ),
      body: PageView.builder(
        controller: _controller,
        itemCount: widget.urls.length,
        onPageChanged: (i) => setState(() => _current = i),
        itemBuilder: (context, index) {
          final url = widget.urls[index];
          return InteractiveViewer(
            child: CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.contain,
              placeholder: (ctx, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (ctx, url, error) {
                if (widget.fallbackAssetPath != null) {
                  return Image.asset(
                    widget.fallbackAssetPath!,
                    fit: BoxFit.contain,
                  );
                }
                return Center(
                  child: Icon(
                    Icons.broken_image,
                    color: Colors.white,
                    size: AppSizes.iconSizeFourtyTwo,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
