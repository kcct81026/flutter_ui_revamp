import 'package:flutter/material.dart';
import 'package:yc_ui/constants/app_sizes.dart';
import 'package:yc_ui/constants/app_string.dart';
import 'package:yc_ui/widgets/app_text.dart';
import 'package:yc_ui/widgets/rounded_text_widget.dart';

class WidgetImportantdays extends StatefulWidget {
  const WidgetImportantdays({super.key});

  @override
  State<WidgetImportantdays> createState() => _WidgetImportantdaysState();
}

class _WidgetImportantdaysState extends State<WidgetImportantdays> {
  // 0 => "Event", 1 => "Upcoming Holidays"
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.paddingTwelve),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              RoundedTextViewWidget(
                showDot: false,
                isSelected: selectedIndex == 0,
                onTap: () => setState(() => selectedIndex = 0),
                child: TextWidget(
                  text: AppString.event,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: AppSizes.paddingEight),
              RoundedTextViewWidget(
                showDot: false,
                isSelected: selectedIndex == 1,
                onTap: () => setState(() => selectedIndex = 1),
                child: TextWidget(
                  text: AppString.upcomingHolidays,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
