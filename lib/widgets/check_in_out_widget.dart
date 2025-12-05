import 'package:flutter/material.dart';
import 'package:yc_ui/constants/app_colors.dart';
import 'package:yc_ui/constants/app_sizes.dart';
import 'package:yc_ui/constants/app_string.dart';
import 'package:yc_ui/widgets/app_text.dart';
import 'package:yc_ui/widgets/rounded_text_widget.dart';

class CheckinoutWidget extends StatelessWidget {
  final String dateText;
  final bool isToday;
  final bool islate;
  final String arrivalStatus;
  final String checkInTime;
  final String checkOutTime;
  final Widget progress;

  const CheckinoutWidget({
    super.key,
    required this.dateText,
    required this.arrivalStatus,
    required this.checkInTime,
    required this.checkOutTime,
    required this.progress,
    required this.isToday,
    this.islate = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color leftDotColor = isToday
        ? AppColors.indicatorInactive
        : AppColors.header;
    final Color rightDotColor = isToday
        ? AppColors.header
        : AppColors.indicatorInactive;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TextWidget(text: dateText, fontSize: AppSizes.small, isBold: false),
            const Spacer(),
            Visibility(
              visible: islate,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: RoundedTextViewWidget(
                backgroundColor: AppColors.orange10,
                borderColor: AppColors.colorOrange,
                borderRadius: AppSizes.paddingFour,
                child: TextWidget(
                  text: arrivalStatus,
                  fontSize: AppSizes.ssmall,
                  color: AppColors.colorOrange,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSizes.paddingFour),

        progress,

        const SizedBox(height: AppSizes.paddingFour),

        SizedBox(
          height: AppSizes.size32,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // --- Left (AM) ---
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextWidget(
                      text: AppString.textAM,
                      color: AppColors.textColor,
                      fontSize: AppSizes.ssmall,
                      isBold: false,
                    ),
                    const SizedBox(width: 4),
                    if (checkInTime.isNotEmpty)
                      TextWidget(
                        text: "($checkInTime)",
                        color: AppColors.colorOrange,
                        fontSize: AppSizes.ssmall,
                        isBold: false,
                      ),
                  ],
                ),
              ),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: AppSizes.iconPadding,
                    height: AppSizes.iconPadding,
                    decoration: BoxDecoration(
                      color: leftDotColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: AppSizes.paddingFour),
                  Container(
                    width: AppSizes.iconPadding,
                    height: AppSizes.iconPadding,
                    decoration: BoxDecoration(
                      color: rightDotColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),

              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextWidget(
                      text: AppString.textPM,
                      color: AppColors.textColor,
                      fontSize: AppSizes.ssmall,
                      isBold: false,
                    ),
                    const SizedBox(width: AppSizes.paddingFour),
                    if (checkOutTime.isNotEmpty)
                      TextWidget(
                        text: "($checkOutTime)",
                        color: AppColors.colorOrange,
                        fontSize: AppSizes.ssmall,
                        isBold: false,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
