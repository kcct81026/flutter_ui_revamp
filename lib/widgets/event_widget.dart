import 'package:flutter/material.dart';
import 'package:yc_ui/constants/app_colors.dart';
import 'package:yc_ui/constants/app_sizes.dart';
import 'package:yc_ui/constants/app_string.dart';
import 'package:yc_ui/widgets/app_text.dart';
import 'package:yc_ui/widgets/icon_widget.dart';

class EventWidget extends StatelessWidget {
  final EventItem item;
  final VoidCallback? onTap;
  final double iconBoxSize;

  const EventWidget({
    super.key,
    required this.item,
    this.onTap,
    this.iconBoxSize = AppSizes.iconSizeFourtyTwo,
  });

  @override
  Widget build(BuildContext context) {
    // Use InkWell inside Material to get ripple effect when clickable
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.paddingTwelve),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSizes.paddingEight,
            //horizontal: AppSizes.paddingTwelve,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left icon box (use either an IconData or an asset string)
              AppIconBox(
                assetIcon: item.assetIcon,
                boxSize: iconBoxSize,
                padding: AppSizes.paddingTwelve,
                backgroundColor: _getBackgroundColor(item.label),
              ),

              const SizedBox(width: AppSizes.paddingTwelve),

              // Middle: two-line text (title + subtitle)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    TextWidget(
                      text: item.label,
                      fontSize: AppSizes.regular,
                      maxLines: 1,
                      isBold: true,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      color: AppColors.grey50,
                    ),

                    const SizedBox(height: AppSizes.paddingFour),

                    // Subtitle / description
                    TextWidget(
                      text: item.text,
                      fontSize: AppSizes.regular,
                      isBold: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      color: AppColors.textColor,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // Right icon (chevron)
              AppIconBox(
                icon: Icons.arrow_right_alt,
                padding: AppSizes.paddingEight,
                boxSize: AppSizes.size32,
                backgroundColor: _getBackgroundColor(item.label),
                iconColor: _getArrowColor(item.label),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Color mapping based on label
  Color _getBackgroundColor(String label) {
    switch (label) {
      case AppString.brithday:
        return AppColors.birthdayBgColor;
      case AppString.anniversary:
        return AppColors.anniversaryBgColor;
      case AppString.event:
        return AppColors.eventBgColor;
      default:
        return Colors.grey.shade200;
    }
  }

  Color _getArrowColor(String label) {
    switch (label) {
      case AppString.brithday:
        return AppColors.colorPink;
      case AppString.anniversary:
        return AppColors.header;
      case AppString.event:
        return AppColors.colorGreen;
      default:
        return Colors.grey.shade200;
    }
  }
}

class EventItem {
  final String? assetIcon;
  final String label;
  final String text;

  EventItem({this.assetIcon, required this.label, required this.text});
}

EventItem eventFromMap(Map<String, dynamic> map) {
  return EventItem(
    assetIcon: map['assetIcon'],
    label: map['label'],
    text: map['text'],
  );
}
