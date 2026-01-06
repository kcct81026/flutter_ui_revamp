import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yc_ui/constants/app_colors.dart';
import 'package:yc_ui/constants/app_sizes.dart';

class ResponsiveCachedImage extends StatelessWidget {
  final String url;
  final double borderRadius;
  final String? fallbackAssetPath;
  final VoidCallback? onTap;
  final BoxFit fit;
  final String? heroTag;
  final double? width;
  final double? height;

  const ResponsiveCachedImage({
    Key? key,
    required this.url,
    required this.borderRadius,
    this.fallbackAssetPath,
    this.onTap,
    this.fit = BoxFit.cover,
    this.heroTag,
    this.width,
    this.height,
  }) : super(key: key);

  Widget _placeholder() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: _ShimmerBox(),
    );
  }

  Widget _errorWidget() {
    final child = fallbackAssetPath != null
        ? Image.asset(
            fallbackAssetPath!,
            fit: fit,
            width: width,
            height: height,
          )
        : Container(
            width: width,
            height: height,
            color: AppColors.grey20,
            alignment: Alignment.center,
            child: const Icon(Icons.broken_image, size: AppSizes.size32),
          );

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget img = CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      width: width,
      height: height,
      placeholder: (ctx, u) => _placeholder(),
      errorWidget: (ctx, u, err) => _errorWidget(),
      fadeInDuration: const Duration(milliseconds: 250),
    );

    if (onTap != null) {
      img = GestureDetector(onTap: onTap, child: img);
    }

    if (heroTag != null) {
      img = Hero(tag: heroTag!, child: img);
    }

    // If width/height are provided, wrap in SizedBox to make sizing predictable.
    if (width != null || height != null) {
      img = SizedBox(width: width, height: height, child: img);
    }

    return img;
  }
}

/// Simple shimmer box used as placeholder.
class _ShimmerBox extends StatefulWidget {
  const _ShimmerBox({Key? key}) : super(key: key);

  @override
  State<_ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<_ShimmerBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
    _anim = Tween<double>(begin: -1.0, end: 2.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (context, child) {
        return CustomPaint(
          painter: _ShimmerPainter(_anim.value),
          child: Container(color: AppColors.grey20),
        );
      },
    );
  }
}

class _ShimmerPainter extends CustomPainter {
  final double slide;
  _ShimmerPainter(this.slide);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    paint.shader = LinearGradient(
      colors: [
        AppColors.grey20,
        AppColors.grey20.withValues(alpha: 0.6),
        AppColors.grey20,
      ],
      stops: const [0.0, 0.5, 1.0],
      begin: Alignment(-1 - slide, -0.3),
      end: Alignment(1 - slide, 0.3),
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant _ShimmerPainter old) => old.slide != slide;
}
