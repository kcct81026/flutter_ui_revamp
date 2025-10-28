import 'package:flutter/material.dart';
import 'package:yc_ui/constants/app_colors.dart';
import 'package:yc_ui/constants/app_sizes.dart';

class RoundedTextIconWidget extends StatelessWidget {
  final Widget child;
  final bool showBorder;
  final Color borderColor;
  final Color backgroundColor;
  final double borderRadius;
  final Color rightBackgroundColor;

  final String? leftAsset;
  final String? rightAsset;

  final double leftImageSize;

  const RoundedTextIconWidget({
    Key? key,
    required this.child,
    this.showBorder = false,
    this.borderColor = Colors.transparent,
    this.backgroundColor = AppColors.blue10,
    this.borderRadius = AppSizes.paddingEight,
    this.leftAsset,
    this.rightAsset,
    this.leftImageSize = AppSizes.paddingSixteen,
    this.rightBackgroundColor = AppColors.blue90,
  }) : super(key: key);

  bool _hasAsset(String? a) => a != null && a.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final hasLeft = _hasAsset(leftAsset);
    final hasRight = _hasAsset(rightAsset);

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: showBorder ? Border.all(color: borderColor, width: 1) : null,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // --- Centered Row (left icon + text) ---
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisSize:
                  MainAxisSize.min, // allow text to take natural width
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (hasLeft)
                  Padding(
                    padding: const EdgeInsets.only(
                      right: AppSizes.paddingEight,
                    ),
                    child: Image.asset(
                      leftAsset!,
                      height: AppSizes.paddingFourteen,
                      width: AppSizes.paddingFourteen,
                      fit: BoxFit.contain,
                    ),
                  ),
                // Text should show fully
                child,
              ],
            ),
          ),

          // --- Right icon (if any) ---
          if (hasRight)
            Positioned(
              right: 0,
              child: Container(
                width: AppSizes.size32,
                height: AppSizes.size32,
                decoration: BoxDecoration(
                  color: rightBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(AppSizes.paddingEight),
                    bottomRight: Radius.circular(AppSizes.paddingEight),
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    rightAsset!,
                    height: AppSizes.paddingFourteen,
                    width: AppSizes.paddingFourteen,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
