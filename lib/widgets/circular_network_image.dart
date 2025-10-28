import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:yc_ui/constants/app_colors.dart';
import 'package:yc_ui/constants/app_icons.dart';

class CircularCachedNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final double? size;
  final BoxFit fit;
  final Color? borderColor;
  final double borderWidth;
  final Widget? placeholder;
  final Widget? errorWidget;
  final VoidCallback? onTap;
  final Color backgroundColor;

  const CircularCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.size,
    this.fit = BoxFit.cover,
    this.borderColor,
    this.borderWidth = 0,
    this.placeholder,
    this.errorWidget,
    this.onTap,
    this.backgroundColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    final double effectiveSize = size ?? width ?? height ?? 48.0;

    Widget child = CachedNetworkImage(
      imageUrl: imageUrl ?? '',
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider, fit: fit),
          ),
        );
      },
      placeholder: (_, __) =>
          placeholder ??
          Center(
            child: SizedBox(
              width: effectiveSize * 0.4,
              height: effectiveSize * 0.4,
              child: const CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
      errorWidget: (_, __, ___) =>
          errorWidget ??
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              AppIcons.user,
              width: effectiveSize * 0.5,
              height: effectiveSize * 0.5,
            ),
          ),
    );

    final decorated = Container(
      width: effectiveSize,
      height: effectiveSize,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: borderWidth > 0
            ? Border.all(
                color: borderColor ?? AppColors.iconBackgroundColor,
                width: borderWidth,
              )
            : null,
      ),
      clipBehavior: Clip.hardEdge,
      child: child,
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: decorated);
    }
    return decorated;
  }
}
