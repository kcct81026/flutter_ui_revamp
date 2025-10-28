import 'package:flutter/material.dart';
import 'package:yc_ui/constants/app_sizes.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final bool isBold;
  final Color? color;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow overflow;
  final FontWeight fontWeight;

  const TextWidget({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.normal,
    this.fontSize = AppSizes.small,
    this.isBold = false,
    this.color,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontFamily: 'Inter',
        fontSize: fontSize,
        fontWeight: isBold ? FontWeight.bold : fontWeight,
        color: color ?? Colors.black,
        height: 1.3, // for slightly nicer spacing
      ),
    );
  }
}
