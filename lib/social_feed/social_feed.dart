import 'package:flutter/material.dart';
import 'package:yc_ui/constants/app_colors.dart';
import 'package:yc_ui/constants/app_icons.dart';
import 'package:yc_ui/constants/app_sizes.dart';
import 'package:yc_ui/constants/dummy.dart';
import 'package:yc_ui/social_feed/socail_feed_images.dart';
import 'package:yc_ui/social_feed/social_feed_header.dart';
import 'package:yc_ui/widgets/app_text.dart';
import 'package:yc_ui/widgets/expandable_text_widget.dart';

class SocialFeedScreen extends StatefulWidget {
  final List<FeedItemModel> items;

  const SocialFeedScreen({super.key, required this.items});

  @override
  State<SocialFeedScreen> createState() => _SocialFeedScreenState();
}

class _SocialFeedScreenState extends State<SocialFeedScreen> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();

    _controller = ScrollController();

    _controller.addListener(() {
      //debugPrint("Scroll offset: ${_controller.offset}");
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _controller,
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: false,
            expandedHeight: 120,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Feed'),
              background: Container(color: Colors.white),
            ),
          ),

          // The feed list: use SliverList.builder for performance
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final item = widget.items[index];
              // Build your full feed item widget. Here we use the header we created earlier
              return RepaintBoundary(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSizes.paddingEight,
                    horizontal: AppSizes.paddingSixteen,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _widgetHeader(item),

                      if (item.text != null)
                        Padding(
                          padding: const EdgeInsets.only(
                            top: AppSizes.paddingEight,
                          ),
                          child: ExpandableTextWidget(
                            text: item.text!,
                            fontSize: AppSizes.regular,
                            color: AppColors.textColor,
                            isBold: false,
                            maxLines: 3,
                          ),
                        ),

                      if (item.images.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: AppSizes.paddingTwelve),
                          child: FeedImageGrid(images: item.images),
                        ),

                      const SizedBox(height: 12),

                      // actions row (likes, comments)
                      Padding(
                        padding: const EdgeInsets.only(left: 56.0),
                        child: Row(
                          children: [
                            Icon(Icons.thumb_up_alt_outlined, size: 18),
                            const SizedBox(width: 8),
                            Text('${item.likes}'),
                            const SizedBox(width: 24),
                            Icon(Icons.comment_outlined, size: 18),
                            const SizedBox(width: 8),
                            Text('${item.comments}'),
                          ],
                        ),
                      ),

                      const Divider(),
                    ],
                  ),
                ),
              );
            }, childCount: widget.items.length),
          ),

          // Optional: a footer to fill remaining space
          SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  Widget _widgetHeader(FeedItemModel item) {
    return SocialFeedHeader(
      name: item.name,
      profileImageUrl: item.avatarUrl,
      isOwnPost: item.isOwnPost,
      groupName: item.groupName,
      timeAgo: item.timeAgo,
      showPromotionIcon: item.isPromoted,
      promotionChild: item.promotionText != null
          ? TextWidget(
              text: item.promotionText!,
              color: AppColors.header,
              isBold: false,
              fontSize: AppSizes.ssmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            )
          : null,
      onMorePressed: () {
        // handle more
      },
    );
  }
}
