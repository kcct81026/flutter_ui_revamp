import 'package:flutter/material.dart';
import 'package:yc_ui/constants/app_colors.dart';
import 'package:yc_ui/constants/app_sizes.dart';

class RoundedTextViewWidget extends StatelessWidget {
  final Widget child;
  final bool showDot;
  final bool showBorder;
  final Color dotColor;
  final Color borderColor;
  final Color backgroundColor;
  final double borderRadius;

  const RoundedTextViewWidget({
    Key? key,
    required this.child,
    this.showDot = false,
    this.showBorder = false,
    this.dotColor = AppColors.colorRed,
    this.borderColor = Colors.transparent,
    this.backgroundColor = AppColors.blue10,
    this.borderRadius = AppSizes.paddingTwelve,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: showBorder ? Border.all(color: borderColor, width: 1) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          child,
          if (showDot)
            Transform.translate(
              offset: const Offset(0, 2),
              child: Container(
                width: AppSizes.paddingFour,
                height: AppSizes.paddingFour,
                margin: const EdgeInsets.only(
                  left: AppSizes.paddingFour,
                  top: 2,
                ),
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
