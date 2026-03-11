import 'package:flutter/material.dart';
import 'package:yc_ui/constants/app_colors.dart';
import 'package:yc_ui/constants/app_icons.dart';
import 'package:yc_ui/constants/app_sizes.dart';
import 'package:yc_ui/constants/app_string.dart';
import 'package:yc_ui/widgets/app_text.dart';
import 'package:yc_ui/widgets/icon_widget.dart';
import 'package:yc_ui/widgets/rounded_text_with_icon.dart';

class SocialFeedHeader extends StatelessWidget {
  final String name;
  final String? profileImageUrl;
  final bool isOwnPost;
  final String? groupName;
  final String timeAgo;
  final bool showPromotionIcon;
  final Widget? promotionChild;
  final VoidCallback? onMorePressed;
  final double avatarRadius;

  const SocialFeedHeader({
    super.key,
    required this.name,
    this.profileImageUrl,
    this.isOwnPost = false,
    this.groupName,
    this.timeAgo = '',
    this.showPromotionIcon = false,
    this.promotionChild,
    this.onMorePressed,
    this.avatarRadius = AppSizes.iconSizeTwenty,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _widgetProfile(),
        const SizedBox(width: AppSizes.paddingTwelve),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: name,
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: AppSizes.regular,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (groupName != null && groupName!.isNotEmpty) ...[
                      const TextSpan(text: " "),
                      TextSpan(
                        text: "posted in",
                        style: TextStyle(
                          color: AppColors.subTextColor,
                          fontSize: AppSizes.regular,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const TextSpan(text: " "),
                      TextSpan(
                        text: groupName!,
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: AppSizes.regular,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: AppSizes.paddingFour),

              Row(
                children: [
                  if (timeAgo.isNotEmpty)
                    TextWidget(
                      text: timeAgo,
                      color: AppColors.subTextColor,
                      isBold: false,
                      fontSize: AppSizes.small,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                    ),

                  if (showPromotionIcon) ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: RoundedTextIconWidget(
                        leftAsset: AppIcons.promotion,
                        backgroundColor: AppColors.blue10,
                        child:
                            promotionChild ??
                            TextWidget(
                              text: AppString.promotion,
                              color: AppColors.header,
                              isBold: false,
                              fontSize: AppSizes.ssmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
        AppIconBox(
          assetIcon: AppIcons.more,
          backgroundColor: Colors.transparent,
          boxSize: AppSizes.radius24,
        ),
      ],
    );
  }

  Widget _widgetProfile() {
    final double size = avatarRadius * 2;

    // If URL is empty => show initials fallback
    if (profileImageUrl == null || profileImageUrl!.trim().isEmpty) {
      return _fallbackInitials(size);
    }

    // Validate URL
    final uri = Uri.tryParse(profileImageUrl!);
    if (uri == null || uri.scheme.isEmpty || uri.host.isEmpty) {
      // invalid url -> fallback
      return _fallbackPlaceholder(size);
    }

    return ClipOval(
      child: Image.network(
        profileImageUrl!,
        width: size,
        height: size,
        fit: BoxFit.cover,
        // while loading show placeholder
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _fallbackPlaceholder(size);
        },
        // on error show fallback
        errorBuilder: (context, error, stackTrace) {
          // optional: log the error for debugging
          debugPrint('Failed to load avatar: $profileImageUrl  error:$error');
          return _fallbackPlaceholder(size);
        },
      ),
    );
  }

  Widget _fallbackPlaceholder(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.blue10,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(Icons.person, size: size * 0.5, color: AppColors.header),
      ),
    );
  }

  Widget _fallbackInitials(double size) {
    final initials = name.trim().isNotEmpty
        ? name.trim().split(' ').map((s) => s[0]).take(2).join()
        : '?';

    return CircleAvatar(
      radius: avatarRadius,
      backgroundColor: AppColors.blue10,
      child: TextWidget(
        text: initials,
        color: AppColors.header,
        isBold: true,
        fontSize: AppSizes.small,
      ),
    );
  }
}
