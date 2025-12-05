import 'package:flutter/material.dart';
import 'package:yc_ui/constants/app_icons.dart';
import 'package:yc_ui/constants/app_sizes.dart';
import 'package:yc_ui/constants/app_string.dart';
import 'package:yc_ui/widgets/event_widget.dart';

class EventsListView extends StatelessWidget {
  final List<EventItem> items;
  final void Function(EventItem)? onItemTap;

  const EventsListView({super.key, required this.items, this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // ← let it size to its children
      physics: NeverScrollableScrollPhysics(), // ← no internal scrolling
      padding: const EdgeInsets.symmetric(vertical: AppSizes.paddingEight),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final it = items[index];
        return EventWidget(item: it, onTap: () => onItemTap?.call(it));
      },
    );
  }
}

final List<EventItem> eventItems = [
  eventFromMap({
    'assetIcon': AppIcons.birthday,
    'label': AppString.brithday,
    'text': 'Jay and 14 others have their birthday today. Wish them well ',
  }),
  eventFromMap({
    'assetIcon': AppIcons.anniversary,
    'label': AppString.anniversary,
    'text': 'Jay and 14 others have their anniversary today. Wish them well ',
  }),
  eventFromMap({
    'assetIcon': AppIcons.event,
    'label': AppString.event,
    'text': 'Aws Training Program 2025 and 2 others are on their way.',
  }),
];
