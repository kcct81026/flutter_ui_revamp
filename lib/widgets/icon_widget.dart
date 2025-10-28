import 'package:flutter/material.dart';
import 'package:yc_ui/constants/app_colors.dart';

class AppIconBox extends StatelessWidget {
  final IconData? icon; // Material icon
  final String? assetIcon; // Asset image
  final Color? iconColor;
  final double? iconSize;
  final Color? backgroundColor;
  final double boxSize;
  final double padding;

  const AppIconBox({
    super.key,
    this.icon,
    this.assetIcon,
    this.iconColor,
    this.iconSize,
    this.backgroundColor,
    this.boxSize = 32,
    this.padding = 6,
  }) : assert(
         icon != null || assetIcon != null,
         'Either icon or assetIcon must be provided.',
       );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: boxSize,
      height: boxSize,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.iconBackgroundColor,
        shape: BoxShape.circle,
      ),
      child: Center(child: _buildIcon()),
    );
  }

  Widget _buildIcon() {
    if (assetIcon != null) {
      return Image.asset(
        assetIcon!,
        width: iconSize ?? 18,
        height: iconSize ?? 18,
        fit: BoxFit.contain,
      );
    } else {
      return Icon(
        icon,
        color: iconColor ?? Colors.black87,
        size: iconSize ?? 18,
      );
    }
  }
}
