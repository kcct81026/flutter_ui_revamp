import 'package:flutter/material.dart';
import 'package:yc_ui/widgets/check_in_out_widget.dart';
import 'package:yc_ui/widgets/progress_widget.dart';

class CheckinDemoData {
  final String title;
  final bool isToday;
  final String arrivalStatus;
  final String checkInTime;
  final String checkOutTime;
  final double progress;
  final bool isLate;

  CheckinDemoData({
    required this.title,
    required this.isToday,
    required this.arrivalStatus,
    required this.checkInTime,
    required this.checkOutTime,
    required this.progress,
    this.isLate = false,
  });
}

class CheckinSwitcher extends StatefulWidget {
  final List<CheckinDemoData>? pages;
  const CheckinSwitcher({Key? key, this.pages}) : super(key: key);

  @override
  State<CheckinSwitcher> createState() => _CheckinSwitcherState();
}

class _CheckinSwitcherState extends State<CheckinSwitcher> {
  late final List<CheckinDemoData> _pages;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _pages =
        widget.pages ??
        [
          CheckinDemoData(
            title: 'Today',
            isToday: true,
            arrivalStatus: '30 mins late',
            checkInTime: '9:00 AM',
            checkOutTime: '',
            progress: 0.6,
            isLate: true,
          ),
          CheckinDemoData(
            title: 'Yesterday',
            isToday: false,
            arrivalStatus: 'On time',
            checkInTime: '8:30 AM',
            checkOutTime: '5:10 PM',
            progress: 0.9,
            isLate: false,
          ),
        ];
  }

  void _goNext() {
    setState(() {
      _index = (_index + 1) % _pages.length;
    });
  }

  void _goPrevious() {
    setState(() {
      _index = (_index - 1 + _pages.length) % _pages.length;
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    final vx = details.velocity.pixelsPerSecond.dx;
    const threshold = 200;
    if (vx < -threshold) {
      _goNext(); // swipe left
    } else if (vx > threshold) {
      _goPrevious(); // swipe right
    }
  }

  @override
  Widget build(BuildContext context) {
    final current = _pages[_index];

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      child: CheckinoutWidget(
        dateText: current.title,
        arrivalStatus: current.arrivalStatus,
        checkInTime: current.checkInTime,
        checkOutTime: current.checkOutTime,
        progress: ProgressBarWidget(progress: current.progress),
        islate: current.isLate,
        isToday: current.isToday,
      ),
    );
  }
}
