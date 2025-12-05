import 'package:flutter/material.dart';
import 'package:yc_ui/constants/app_colors.dart';
import 'package:yc_ui/constants/app_sizes.dart';

class RoundedTextViewWidget extends StatelessWidget {
  final Widget child;
  final bool showDot;
  final bool showBorder;
  final Color dotColor;
  final Color borderColor;
  final Color backgroundColor; // unselected bg
  final Color selectedBackgroundColor;
  final Color selectedTextColor;
  final Color unselectedTextColor;
  final double borderRadius;
  final bool isSelected;
  final VoidCallback? onTap;

  const RoundedTextViewWidget({
    super.key,
    required this.child,
    this.showDot = false,
    this.showBorder = true,
    this.dotColor = AppColors.colorRed,
    this.borderColor = AppColors.grey20, // default as you requested
    this.backgroundColor = Colors.transparent, // default transparent
    this.selectedBackgroundColor = AppColors.blue10,
    this.selectedTextColor = AppColors.header,
    this.unselectedTextColor = AppColors.textColor,
    this.borderRadius = AppSizes.paddingTwelve,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color bg = isSelected ? selectedBackgroundColor : backgroundColor;
    final Color txtColor = isSelected ? selectedTextColor : unselectedTextColor;
    final Border? border = showBorder
        ? Border.all(color: borderColor, width: 1)
        : null;

    // Material + InkWell for ripple; set clipBehavior to match borderRadius
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingTwelve,
            vertical: AppSizes.paddingFour,
          ),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(borderRadius),
            border: border,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Allow child to inherit text color from DefaultTextStyle.merge
              Flexible(
                fit: FlexFit.loose,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 0,
                    maxWidth: double.infinity,
                  ),
                  child: DefaultTextStyle.merge(
                    style: TextStyle(color: txtColor),
                    child: child,
                  ),
                ),
              ),

              if (showDot)
                Transform.translate(
                  offset: const Offset(0, 2),
                  child: Container(
                    width: AppSizes.paddingFour,
                    height: AppSizes.paddingFour,
                    margin: const EdgeInsets.only(
                      left: AppSizes.paddingFour,
                      top: AppSizes.paddingFour / 2,
                    ),
                    decoration: BoxDecoration(
                      color: dotColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
