import 'package:yc_ui/constants/dummy.dart';

extension FeedImageMapper on List<String> {
  List<FeedImage> toFeedImages() {
    return map((url) {
      if (url == landscapeURL) {
        return FeedImage(url: url, width: 1200, height: 800);
      }

      if (url == portraitURL) {
        return FeedImage(url: url, width: 800, height: 1200);
      }

      return FeedImage(url: url, width: 1000, height: 1000);
    }).toList();
  }
}

class FeedImage {
  final String url;
  final double width;
  final double height;

  const FeedImage({
    required this.url,
    required this.width,
    required this.height,
  });

  bool get isPortrait => height > width;
  bool get isLandscape => width > height;
  bool get isSquare => width == height;
  double get aspectRatio => width / height;
}
