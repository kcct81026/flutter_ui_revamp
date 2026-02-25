import 'package:flutter/material.dart';
import 'package:yc_ui/constants/app_colors.dart';
import 'package:yc_ui/constants/app_sizes.dart';

class ProgressBarWidget extends StatelessWidget {
  final double progress;

  const ProgressBarWidget({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    final clamped = progress.clamp(0.0, 1.0);
    final radius = BorderRadius.circular(AppSizes.paddingEight);

    return ClipRRect(
      borderRadius: radius,
      child: SizedBox(
        height: AppSizes.paddingTwelve,
        child: Stack(
          children: [
            Container(color: AppColors.progressBackground),
            Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: clamped,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFFADEB6),
                        Color(0xFFB2D7F9),
                        Color(0xFFB2D7F9),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
