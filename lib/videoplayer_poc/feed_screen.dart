import 'package:flutter/material.dart';
import 'package:yc_ui/videoplayer_poc/dummy_video_data.dart';
import 'package:yc_ui/videoplayer_poc/video_post_widget.dart';

class FeedScreen extends StatelessWidget {
  final feed = generateFeed(50); // try 50–100

  FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Video Feed POC")),
      body: ListView.builder(
        itemCount: feed.length,
        itemBuilder: (context, index) {
          final item = feed[index];

          if (item.type == PostType.video) {
            return VideoPostWidget(
              videoUrl: item.videoUrl!,
              thumbnail: item.thumbnail!,
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Text(item.text ?? ""),
          );
        },
      ),
    );
  }
}
