import 'package:flutter/material.dart';
import 'package:yc_ui/check_in_switcher.dart';
import 'package:yc_ui/constants/app_icons.dart';
import 'package:yc_ui/constants/app_sizes.dart';
import 'package:yc_ui/constants/app_string.dart';
import 'package:yc_ui/widgets/app_text.dart';
import 'package:yc_ui/widgets/check_in_out_widget.dart';
import 'package:yc_ui/widgets/circular_network_image.dart';
import 'package:yc_ui/widgets/icon_widget.dart';
import 'package:yc_ui/widgets/progress_widget.dart';
import 'package:yc_ui/widgets/rounded_text_widget.dart';
import 'package:yc_ui/widgets/rounded_text_with_icon.dart';
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingTwelve),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _attendanceRowWidget(),
            _checkInCheckOutRowWidget(),
            const CheckinSwitcher(),
            _easyCheckInWidget(),
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
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      RoundedTextViewWidget(
        showDot: false,
        showBorder: false,
        backgroundColor: AppColors.blue10,
        child: TextWidget(
          text: AppString.textCheckInCheckOut,
          fontSize: AppSizes.small,
          isBold: false,
          color: AppColors.header,
        ),
      ),
      SizedBox(width: AppSizes.paddingEight),
      RoundedTextViewWidget(
        showDot: true,
        showBorder: true,
        borderColor: AppColors.grey20,
        backgroundColor: AppColors.colorGrey,
        child: TextWidget(
          text: AppString.textLeaveTaken,
          fontSize: AppSizes.small,
          isBold: false,
          color: AppColors.textColor,
        ),
      ),
    ],
  );
}

Widget _easyCheckInWidget() {
  return SizedBox(
    height: AppSizes.size32,
    width: double.infinity, // make it take full available width
    child: Row(
      children: [
        // First widget (equal width)
        Expanded(
          child: RoundedTextIconWidget(
            leftAsset: AppIcons.exitApp,
            backgroundColor: AppColors.blue10,
            child: TextWidget(
              text: AppString.requestLeave,
              color: AppColors.header,
              isBold: false,
              fontSize: AppSizes.ssmall,
            ),
          ),
        ),

        const SizedBox(width: 8), // spacing between the two boxes
        // Second widget (equal width)
        Expanded(
          child: RoundedTextIconWidget(
            leftAsset: AppIcons.eventAvailable,
            backgroundColor: AppColors.header,
            rightAsset: AppIcons.downArrow,
            rightBackgroundColor: AppColors.blue90,
            child: TextWidget(
              text: AppString.easyCheckIn,
              color: AppColors.iconBackgroundColor,
              isBold: false,
              fontSize: AppSizes.ssmall,
            ),
          ),
        ),
      ],
    ),
  );
}
