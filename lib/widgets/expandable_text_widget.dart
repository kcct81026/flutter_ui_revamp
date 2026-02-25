import 'package:flutter/material.dart';
import 'package:yc_ui/constants/app_colors.dart';
import 'package:yc_ui/constants/app_sizes.dart';
import 'package:yc_ui/widgets/app_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final bool isBold;
  final int maxLines;
  final String seeMoreText;

  const ExpandableTextWidget({
    super.key,
    required this.text,
    this.fontSize = AppSizes.regular,
    this.color,
    this.isBold = false,
    this.maxLines = 3,
    this.seeMoreText = 'See more',
  });

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  bool _isExpanded = false;

  TextStyle _baseStyle(BuildContext context) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: widget.fontSize,
      fontWeight: widget.isBold ? FontWeight.bold : FontWeight.normal,
      color: widget.color ?? DefaultTextStyle.of(context).style.color,
      height: 1.2,
    );
  }

  // binary search trimming helper (keeps words whole)
  String _binaryTrim(
    String text,
    double maxWidth,
    TextStyle style,
    TextScaler scaler,
    int maxLines,
    String suffix,
  ) {
    int low = 0;
    int high = text.length;
    String result = '';

    while (low <= high) {
      final mid = (low + high) >> 1;
      String candidate = text.substring(0, mid).trimRight();

      if (mid < text.length && mid > 0 && text[mid].trim().isNotEmpty) {
        final lastSpace = candidate.lastIndexOf(' ');
        if (lastSpace > 0) candidate = candidate.substring(0, lastSpace);
      }

      final tp = TextPainter(
        text: TextSpan(text: candidate + suffix, style: style),
        maxLines: maxLines,
        textScaler: scaler,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: maxWidth);

      if (tp.didExceedMaxLines) {
        high = mid - 1;
      } else {
        result = candidate;
        low = mid + 1;
      }
    }

    if (result.trim().isEmpty && text.isNotEmpty) {
      int take = (text.length * 0.25).ceil().clamp(1, text.length);
      String candidate = text.substring(0, take);
      final lastSpace = candidate.lastIndexOf(' ');
      if (lastSpace > 0) candidate = candidate.substring(0, lastSpace);
      return candidate.trimRight();
    }

    return result.trimRight();
  }

  @override
  Widget build(BuildContext context) {
    final scaler = MediaQuery.textScalerOf(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.of(context).size.width;

        final baseStyle = _baseStyle(context);

        // check if full text overflows with the configured maxLines
        final fullTp = TextPainter(
          text: TextSpan(text: widget.text, style: baseStyle),
          maxLines: widget.maxLines,
          textScaler: scaler,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: availableWidth);

        final bool isOverflow = fullTp.didExceedMaxLines;

        // Non-overflow: always render full text and still toggle on tap
        if (!isOverflow) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              // toggle even for short text if you want; currently toggling collapses/expands
              setState(() => _isExpanded = !_isExpanded);
            },
            child: TextWidget(
              text: widget.text,
              fontSize: widget.fontSize,
              isBold: widget.isBold,
              color: widget.color,
              maxLines: null,
              overflow: TextOverflow.visible,
            ),
          );
        }

        // Expanded: show full text (allow collapse by tapping anywhere)
        if (_isExpanded) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => setState(() => _isExpanded = false),
            child: TextWidget(
              text: widget.text,
              fontSize: widget.fontSize,
              isBold: widget.isBold,
              color: widget.color,
              maxLines: null,
              overflow: TextOverflow.visible,
            ),
          );
        }

        // Collapsed & overflowed: compute trimmed string and show inline "... See more"
        final suffix = '… ${widget.seeMoreText}';
        final trimmed = _binaryTrim(
          widget.text,
          availableWidth,
          baseStyle,
          scaler,
          widget.maxLines,
          suffix,
        );

        final seeStyle = TextStyle(
          fontFamily: 'Inter',
          fontSize: AppSizes.small,
          fontWeight: FontWeight.bold,
          color: AppColors.textColor,
          height: 1.2,
        );

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => setState(() => _isExpanded = true),
          child: RichText(
            textScaler: scaler,
            text: TextSpan(
              children: [
                TextSpan(text: '$trimmed ', style: baseStyle),
                TextSpan(text: '… ', style: baseStyle),
                TextSpan(text: widget.seeMoreText, style: seeStyle),
              ],
            ),
            maxLines: widget.maxLines,
            overflow: TextOverflow.clip,
          ),
        );
      },
    );
  }
}
