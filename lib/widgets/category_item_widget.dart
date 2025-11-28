import 'package:flutter/material.dart';
import 'package:yc_ui/constants/app_colors.dart';
import 'package:yc_ui/constants/app_sizes.dart';
import 'package:yc_ui/widgets/app_text.dart';

class CategoryItemWidget extends StatelessWidget {
  final String label;
  final String iconAsset;
  final Color backgroundColor;
  final double cornerRadius;
  final VoidCallback? onTap;

  const CategoryItemWidget({
    Key? key,
    required this.label,
    required this.iconAsset,
    this.backgroundColor = Colors.white,
    this.cornerRadius = AppSizes.paddingEight,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // --- Icon Box ---
          Container(
            width: AppSizes.size60,
            height: AppSizes.size60,
            padding: const EdgeInsets.all(AppSizes.paddingTwelve),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(cornerRadius),
            ),
            child: Image.asset(
              iconAsset,
              height: AppSizes.iconSizeTwenty,
              width: AppSizes.iconSizeTwenty,
            ),
          ),

          const SizedBox(height: AppSizes.paddingFour),
          SizedBox(
            height: AppSizes.iconSizeFourtyTwo,
            width: AppSizes.toolBarHeight,
            child: Align(
              alignment: Alignment.topCenter,
              child: TextWidget(
                text: label,
                fontSize: AppSizes.small,
                color: AppColors.textColor,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
