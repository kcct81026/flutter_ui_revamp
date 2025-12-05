import 'package:flutter/material.dart';
import 'package:yc_ui/constants/app_colors.dart';
import 'package:yc_ui/constants/app_sizes.dart';

class ProgressBarWidget extends StatelessWidget {
  final double progress;

  const ProgressBarWidget({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    final clampedProgress = progress.clamp(0.0, 1.0);
    final remaining = 1.0 - clampedProgress;

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSizes.paddingEight),
      child: Stack(
        children: [
          // Remaining background
          Container(
            height: AppSizes.paddingTwelve,
            color: AppColors.progressBackground,
          ),
          // Progress fill
          FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: clampedProgress,
            child: Container(
              height: AppSizes.paddingTwelve,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFADEB6),
                    Color(0xFFB2D7F9),
                    Color(0xFFB2D7F9),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
