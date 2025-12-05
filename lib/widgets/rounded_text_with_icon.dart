import 'package:flutter/material.dart';
import 'package:yc_ui/constants/app_colors.dart';
import 'package:yc_ui/constants/app_sizes.dart';

class RoundedTextIconWidget extends StatelessWidget {
  final Widget child;
  final bool showBorder;
  final Color borderColor;
  final Color backgroundColor;
  final double borderRadius;

  final String? leftAsset;
  final String? rightAsset;
  final double leftImageSize;
  final Color rightBackgroundColor;

  const RoundedTextIconWidget({
    super.key,
    required this.child,
    this.showBorder = false,
    this.borderColor = Colors.transparent,
    this.backgroundColor = AppColors.blue10,
    this.borderRadius = AppSizes.paddingEight,
    this.leftAsset,
    this.rightAsset,
    this.leftImageSize = AppSizes.paddingSixteen,
    this.rightBackgroundColor = AppColors.blue90,
  });

  static const double _rightIconBoxSize = AppSizes.size32;

  bool _hasAsset(String? a) => a != null && a.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final hasLeft = _hasAsset(leftAsset);
    final hasRight = _hasAsset(rightAsset);

    // base horizontal padding on the left side (you can tweak)
    const double horizontalLeftPadding = AppSizes.paddingTwelve;

    // If we have a right icon we want it flush to the container's right edge,
    // therefore container.right padding is 0. But we still must reserve space
    // inside the centered area so text won't go under the right icon. We do that
    // by adding an inner right padding equal to _rightIconBoxSize on the centered child.
    final EdgeInsets containerPadding = EdgeInsets.only(
      left: horizontalLeftPadding,
      right: hasRight ? 0 : horizontalLeftPadding,
      top: 4,
      bottom: 4,
    );

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: showBorder ? Border.all(color: borderColor, width: 1) : null,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // apply padding ONLY around centered area
          Padding(
            padding: EdgeInsets.only(
              left: horizontalLeftPadding,
              right: hasRight ? _rightIconBoxSize : horizontalLeftPadding,
              top: 4,
              bottom: 4,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (hasLeft)
                    Padding(
                      padding: const EdgeInsets.only(
                        right: AppSizes.paddingEight,
                      ),
                      child: Image.asset(
                        leftAsset!,
                        height: leftImageSize,
                        width: leftImageSize,
                        fit: BoxFit.contain,
                      ),
                    ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 0,
                        maxWidth: double.infinity,
                      ),
                      child: child,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Right icon stays flush — no padding now
          if (hasRight)
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: _rightIconBoxSize,
                decoration: BoxDecoration(
                  color: rightBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(borderRadius),
                    bottomRight: Radius.circular(borderRadius),
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
