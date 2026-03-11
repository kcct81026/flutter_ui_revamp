import 'package:yc_ui/constants/dummy.dart';

enum PostType { text, video }

class FeedItem {
  final PostType type;
  final String? text;
  final String? videoUrl;
  final String? thumbnail;

  FeedItem({required this.type, this.text, this.videoUrl, this.thumbnail});
}

List<String> videoUrls = [
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4",
];

List<String> thumbUrls = [
  mediaURL1,
  mediaURL2,
  mediaURL3,
  mediaURL5,
  mediaURL4,
  mediaURL5,
];

List<FeedItem> generateFeed(int count) {
  return List.generate(count, (index) {
    if (index % 3 == 0) {
      return FeedItem(type: PostType.text, text: "Text post $index");
    }

    return FeedItem(
      type: PostType.video,
      thumbnail: thumbUrls[index % thumbUrls.length],
      videoUrl: videoUrls[index % videoUrls.length],
    );
  });
}
