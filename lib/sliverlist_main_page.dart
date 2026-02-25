import 'package:flutter/material.dart';
import 'package:yc_ui/check_in_switcher.dart';
import 'package:yc_ui/constants/app_icons.dart';
import 'package:yc_ui/constants/app_sizes.dart';
import 'package:yc_ui/constants/app_string.dart';
import 'package:yc_ui/widgets/app_text.dart';
import 'package:yc_ui/widgets/category_item_widget.dart';
import 'package:yc_ui/widgets/circular_network_image.dart';
import 'package:yc_ui/widgets/event_list_widget.dart';
import 'package:yc_ui/widgets/icon_widget.dart';
import 'package:yc_ui/widgets/rounded_text_widget.dart';
import 'package:yc_ui/widgets/rounded_text_with_icon.dart';
import 'package:yc_ui/widgets/widget_importantdays.dart';
import 'constants/app_colors.dart';

class SliverListMainPage extends StatelessWidget {
  const SliverListMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _sliverAppBar(context),
          _categorySliverGrid(context),
          SliverToBoxAdapter(child: _widgetStarterCourse()),
          SliverToBoxAdapter(child: _widgetImportantDays()),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return ListTile(title: Text('Item #$index'));
            }, childCount: 20),
          ),
        ],
      ),
    );
  }
}

Widget _sliverAppBar(BuildContext context) {
  return SliverAppBar(
    pinned: false,
    floating: false,
    snap: false,
    expandedHeight: AppSizes.expandedHeight + AppSizes.toolBarHeight,
    // + MediaQuery.of(context).padding.top,
    automaticallyImplyLeading: false,
    backgroundColor: Colors.transparent,
    titleSpacing: AppSizes.paddingSixteen,
    centerTitle: false,
    title: const SizedBox.shrink(),
    flexibleSpace: LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: AppSizes.expandedHeight,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(AppSizes.radius24),
                  bottomRight: Radius.circular(AppSizes.radius24),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.header,
                    image: const DecorationImage(
                      image: AssetImage(AppIcons.header2),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),

            // toolbar row (top)
            Positioned(
              top: MediaQuery.of(context).padding.top,
              left: AppSizes.paddingTwelve,
              right: AppSizes.paddingSixteen,
              height: AppSizes.toolBarHeight,
              child: _profileWidget(context),
            ),

            // attendance card positioned using cardTop computed above
            Positioned(
              left: AppSizes.paddingTwelve,
              right: AppSizes.paddingTwelve,
              top: AppSizes.toolBarHeight + MediaQuery.of(context).padding.top,
              child: _attendanceWidgetCard(context),
            ),
          ],
        );
      },
    ),
  );
}

Widget _categorySliverGrid(BuildContext context) {
  return SliverPadding(
    padding: const EdgeInsets.symmetric(
      horizontal: AppSizes.paddingTwelve,
      vertical: AppSizes.paddingSixteen,
    ),
    sliver: SliverGrid(
      delegate: SliverChildBuilderDelegate((context, index) {
        final items = [
          {'icon': AppIcons.office, 'label': AppString.office},
          {'icon': AppIcons.payslip, 'label': AppString.payslip},
          {'icon': AppIcons.menu, 'label': AppString.menu},
          {'icon': AppIcons.knowledge, 'label': AppString.knowledge},
          {'icon': AppIcons.ferry, 'label': AppString.ferry},
          {'icon': AppIcons.other, 'label': AppString.other},
        ];
        final item = items[index % items.length];
        return CategoryItemWidget(
          iconAsset: item['icon']!,
          label: item['label']!,
        );
      }, childCount: 6),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        //mainAxisSpacing: AppSizes.paddingTwelve,
        crossAxisSpacing: AppSizes.paddingTwelve,
        //childAspectRatio: 0.95, // tweak to suit icon + text size
      ),
    ),
  );
}

Widget _profileWidget(BuildContext context) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const CircularCachedNetworkImage(
        imageUrl: 'https://example.com/avatar.jpg',
        size: AppSizes.iconBox * AppSizes.imageVisualScale,
      ),
      const Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text: "Marketing Manager",
              fontSize: AppSizes.small,
              color: AppColors.blue10,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            TextWidget(
              text: "Jay Jay",
              fontSize: AppSizes.small,
              color: AppColors.blue10,
              fontWeight: FontWeight.w600,
              maxLines: 1,
              isBold: false,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      const SizedBox(width: AppSizes.paddingEight),
      const AppIconBox(
        assetIcon: AppIcons.magnifer,
        backgroundColor: AppColors.iconBackgroundColor,
        boxSize: AppSizes.iconBox,
      ),
      const SizedBox(width: AppSizes.paddingEight),
      const AppIconBox(
        assetIcon: AppIcons.chat,
        backgroundColor: AppColors.iconBackgroundColor,
        boxSize: AppSizes.iconBox,
      ),
    ],
  );
}

Widget _attendanceWidgetCard(BuildContext context) {
  return SizedBox(
    height: AppSizes.attendanceHeight,
    child: Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.paddingTwelve),
      ),
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingEight),
        child: Column(
          // avoid forcing fixed vertical sizes — use Flexible
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(flex: 0, child: _attendanceRowWidget()),
            Flexible(flex: 0, child: _checkInCheckOutRowWidget()),
            const CheckinSwitcher(),
            Flexible(flex: 1, child: _easyCheckInWidget()),
          ],
        ),
      ),
    ),
  );
}

Widget _attendanceRowWidget() {
  return Row(
    children: [
      const AppIconBox(
        assetIcon: AppIcons.attendance,
        boxSize: AppSizes.iconSizeTwenty,
        padding: 0,
        backgroundColor: Colors.transparent,
      ),
      SizedBox(width: AppSizes.paddingEight),
      const TextWidget(
        text: AppString.textAttendance,
        fontSize: AppSizes.regular,
        fontWeight: FontWeight.w600,
        isBold: false,
      ),
      const Spacer(),
      Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingTwelve,
          vertical: AppSizes.paddingFour,
        ),
        decoration: BoxDecoration(
          color: AppColors.green10,
          borderRadius: BorderRadius.circular(
            AppSizes.paddingEight,
          ), // rounded corners
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // shrink to fit content
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextWidget(
              text: AppString.textOnTime,
              color: AppColors.colorGreen,
              fontWeight: FontWeight.w600,
            ),

            const SizedBox(width: AppSizes.paddingFour),
            // Green circle dot
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.colorGreen, // solid green dot
                shape: BoxShape.circle,
              ),
            ),
            // space between dot and text
          ],
        ),
      ),
    ],
  );
}

Widget _checkInCheckOutRowWidget() {
  return Wrap(
    spacing: AppSizes.paddingEight,
    runSpacing: AppSizes.paddingFour,
    crossAxisAlignment: WrapCrossAlignment.center,
    children: [
      // natural-size chip: will show full text if room, otherwise wrap to next line
      RoundedTextViewWidget(
        showDot: false,
        child: TextWidget(
          text: AppString.textCheckInCheckOut,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),

      RoundedTextViewWidget(
        showDot: true,
        child: TextWidget(
          text: AppString.textLeaveTaken,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}

Widget _easyCheckInWidget() {
  return SizedBox(
    height: AppSizes.size32, // keep if required
    width: double.infinity,
    child: Row(
      children: [
        Expanded(
          child: Center(
            // center vertically & horizontally
            child: RoundedTextIconWidget(
              leftAsset: AppIcons.exitApp,
              backgroundColor: AppColors.blue10,
              child: TextWidget(
                text: AppString.requestLeave,
                color: AppColors.header,
                isBold: false,
                fontSize: AppSizes.ssmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSizes.paddingEight),
        Expanded(
          child: Center(
            child: RoundedTextIconWidget(
              leftAsset: AppIcons.eventAvailable,
              backgroundColor: AppColors.header,
              rightAsset: AppIcons.downArrow,
              rightBackgroundColor: AppColors.blue90,
              child: TextWidget(
                text: "Easy Check In",
                //text: AppString.easyCheckIn,
                color: AppColors.iconBackgroundColor,
                isBold: false,
                fontSize: AppSizes.ssmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _widgetImportantDays() {
  return Container(
    padding: EdgeInsets.all(AppSizes.paddingTwelve),
    child: Card(
      elevation: AppSizes.paddingFour,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.paddingTwelve),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingTwelve),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  AppIcons.importantDaysHearts,
                  height: AppSizes.size32,
                  width: AppSizes.size32,
                  fit: BoxFit.fill,
                ),
                SizedBox(width: AppSizes.paddingEight),
                TextWidget(
                  text: AppString.importantDays,
                  color: AppColors.textBoldColor,
                  isBold: true,
                  fontSize: AppSizes.large,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            SizedBox(height: AppSizes.paddingEight),
            WidgetImportantdays(),
            EventsListView(items: eventItems),
          ],
        ),
      ),
    ),
  );
}

Widget _widgetStarterCourse() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingTwelve),
    child: Card(
      elevation: AppSizes.paddingFour,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.paddingTwelve),
      ),
      color: AppColors.header,
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingTwelve),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // vertically center the text
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: AppString.startKidTitle,
                    color: AppColors.background,
                    isBold: true,
                    fontSize: AppSizes.regular,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: AppSizes.paddingEight),
                  TextWidget(
                    text: AppString.startKidBody,
                    color: AppColors.background,
                    isBold: false,
                    maxLines: 2,
                    fontSize: AppSizes.small,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: AppSizes.paddingEight),
                  Row(
                    children: [
                      TextWidget(
                        text: "8 out of completed",
                        color: AppColors.background,
                        isBold: true,
                        fontSize: AppSizes.small,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(width: AppSizes.paddingFour),
                      Image.asset(
                        AppIcons.courseOnGoing,
                        height: AppSizes.paddingSixteen,
                        width: AppSizes.paddingSixteen,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: AppSizes.paddingFour),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                AppIcons.course,
                width: 100,
                height: 100,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
