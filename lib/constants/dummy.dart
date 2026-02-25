List<FeedItemModel> generateFeed(int count) {
  return List.generate(count, (index) {
    return dummyFeedItems[index % dummyFeedItems.length];
  });
}

final List<FeedItemModel> dummyFeedItems = [
  FeedItemModel(
    name: "Kcct",
    avatarUrl: profileURL,
    isOwnPost: true,
    timeAgo: "2 hours ago",
    text: "Five Photos International Meow day",
    images: [
      landscapeURL,
      mediaURL7,
      mediaURL1,
      mediaURL2,
      mediaURL3,
      mediaURL4,
    ],
    likes: 20,
    comments: 5,
  ),
  FeedItemModel(
    name: "Kitty",
    avatarUrl: profileURL,
    isOwnPost: false,
    groupName: "Meow World",
    timeAgo: "11 minutes ago",
    isPromoted: true,
    promotionText: "Promotion",
    text: "Team, please check today’s sales summary. 💙",
    images: [squareURL],
    likes: 12,
    comments: 3,
  ),
  FeedItemModel(
    name: "Kitty",
    avatarUrl: profileURL,
    isOwnPost: false,
    groupName: "Meow World",
    timeAgo: "11 minutes ago",
    isPromoted: true,
    promotionText: "Promotion",
    text: "Team, please check today’s sales summary. 💙",
    images: [landscapeURL],
    likes: 12,
    comments: 3,
  ),
  FeedItemModel(
    name: "Kitty",
    avatarUrl: profileURL,
    isOwnPost: false,
    groupName: "Meow World",
    timeAgo: "11 minutes ago",
    isPromoted: true,
    promotionText: "Promotion",
    text: "Team, please check today’s sales summary. 💙",
    images: [portraitURL],
    likes: 12,
    comments: 3,
  ),
  FeedItemModel(
    name: "Mike Cooper",
    avatarUrl: profileURL,
    isOwnPost: false,
    groupName: "Group Sales",
    timeAgo: "11 minutes ago",
    isPromoted: true,
    promotionText: "Promotion",
    text: "Team, please check today’s sales summary. 💙",
    images: [squareURL, mediaURL1],
    likes: 12,
    comments: 3,
  ),

  FeedItemModel(
    name: "Mike Cooper",
    avatarUrl: profileURL,
    isOwnPost: false,
    groupName: "Group Sales",
    timeAgo: "11 minutes ago",
    isPromoted: true,
    promotionText: "Promotion",
    text: "Team, please check today’s sales summary. 💙",
    images: [portraitURL, mediaURL2],
    likes: 12,
    comments: 3,
  ),

  FeedItemModel(
    name: "Mike Cooper",
    avatarUrl: profileURL,
    isOwnPost: false,
    groupName: "Group Sales",
    timeAgo: "11 minutes ago",
    isPromoted: true,
    promotionText: "Promotion",
    text: "Team, please check today’s sales summary. 💙",
    images: [landscapeURL, mediaURL3],
    likes: 12,
    comments: 3,
  ),

  FeedItemModel(
    name: "Black Cat",
    avatarUrl: profileURL,
    isOwnPost: false,
    groupName: "Meow World",
    timeAgo: "11 minutes ago",
    isPromoted: true,
    promotionText: "Promotion",
    text:
        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
    images: [squareURL, mediaURL4, mediaURL5],
    likes: 12,
    comments: 3,
  ),
  FeedItemModel(
    name: "Black Cat",
    avatarUrl: profileURL,
    isOwnPost: false,
    groupName: "Meow World",
    timeAgo: "11 minutes ago",
    isPromoted: true,
    promotionText: "Promotion",
    text:
        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
    images: [portraitURL, mediaURL7, mediaURL1],
    likes: 12,
    comments: 3,
  ),
  FeedItemModel(
    name: "Black Cat",
    avatarUrl: profileURL,
    isOwnPost: false,
    groupName: "Meow World",
    timeAgo: "11 minutes ago",
    isPromoted: true,
    promotionText: "Promotion",
    text:
        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
    images: [landscapeURL, mediaURL8, mediaURL1],
    likes: 12,
    comments: 3,
  ),
  FeedItemModel(
    name: "Four Images",
    avatarUrl: profileURL,
    isOwnPost: false,
    groupName: "Meow World",
    timeAgo: "11 minutes ago",
    isPromoted: true,
    promotionText: "Promotion",
    text: "Four image landscape",
    images: [squareURL, mediaURL7, mediaURL1, mediaURL8],
    likes: 12,
    comments: 3,
  ),
  FeedItemModel(
    name: "Four Images",
    avatarUrl: profileURL,
    isOwnPost: false,
    groupName: "Meow World",
    timeAgo: "11 minutes ago",
    isPromoted: true,
    promotionText: "Promotion",
    text: "Four image landscape",
    images: [landscapeURL, mediaURL1, mediaURL8, mediaURL6],
    likes: 12,
    comments: 3,
  ),

  FeedItemModel(
    name: "Four Images",
    avatarUrl: profileURL,
    isOwnPost: false,
    groupName: "Meow World",
    timeAgo: "11 minutes ago",
    isPromoted: true,
    promotionText: "Promotion",
    text: "Four image portrait",
    images: [portraitURL, mediaURL8, mediaURL5, mediaURL7],
    likes: 12,
    comments: 3,
  ),

  FeedItemModel(
    name: "Kcct",
    avatarUrl: profileURL,
    isOwnPost: true,
    timeAgo: "2 hours ago",
    text: "Five Photos International Meow day",
    images: [portraitURL, mediaURL1, mediaURL2, mediaURL3, mediaURL4],
    likes: 20,
    comments: 5,
  ),
  FeedItemModel(
    name: "Kcct",
    avatarUrl: profileURL,
    isOwnPost: true,
    timeAgo: "2 hours ago",
    text: "Five Photos International Meow day",
    images: [
      portraitURL,
      mediaURL8,
      mediaURL1,
      mediaURL2,
      mediaURL3,
      mediaURL4,
    ],
    likes: 20,
    comments: 5,
  ),
  FeedItemModel(
    name: "Kcct",
    avatarUrl: profileURL,
    isOwnPost: true,
    timeAgo: "2 hours ago",
    text: "Five Photos International Meow day",
    images: [landscapeURL, mediaURL1, mediaURL2, mediaURL3, mediaURL4],
    likes: 20,
    comments: 5,
  ),
  FeedItemModel(
    name: "Kcct",
    avatarUrl: profileURL,
    isOwnPost: true,
    timeAgo: "2 hours ago",
    text: "Five Photos International Meow day",
    images: [
      landscapeURL,
      mediaURL8,
      mediaURL1,
      mediaURL2,
      mediaURL3,
      mediaURL4,
    ],
    likes: 20,
    comments: 5,
  ),
  FeedItemModel(
    name: "Kcct",
    avatarUrl: profileURL,
    isOwnPost: true,
    timeAgo: "2 hours ago",
    text: "Five Photos International Meow day",
    images: [squareURL, mediaURL1, mediaURL2, mediaURL3, mediaURL4],
    likes: 20,
    comments: 5,
  ),
  FeedItemModel(
    name: "Kcct",
    avatarUrl: profileURL,
    isOwnPost: true,
    timeAgo: "2 hours ago",
    text: "Five Photos International Meow day",
    images: [
      squareURL,
      mediaURL8,
      mediaURL1,
      mediaURL2,
      mediaURL3,
      mediaURL4,
      landscapeURL,
    ],
    likes: 20,
    comments: 5,
  ),
  FeedItemModel(
    name: "DevOps Team",
    avatarUrl: profileURL,
    groupName: "Engineering Team",
    timeAgo: "Yesterday",
    text: "Reminder: Scheduled maintenance tonight at 11 PM.",
    images: [mediaURL7, mediaURL1],
    likes: 8,
    comments: 1,
  ),

  FeedItemModel(
    name: "Hnin Pwint",
    avatarUrl: profileURL,
    timeAgo: "2 days ago",
    isPromoted: true,
    promotionText: "Promotion",
    text:
        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout...",
    images: [mediaURL1, mediaURL2, mediaURL3],
    likes: 45,
    comments: 14,
  ),

  FeedItemModel(
    name: "Sarah",
    avatarUrl: profileURL,
    timeAgo: "1 hour ago",
    isPromoted: false,
    text: "Loving our new office design! 💙",
    images: [mediaURL2, mediaURL1],
    likes: 30,
    comments: 10,
  ),

  FeedItemModel(
    name: "KC",
    avatarUrl: profileURL,
    isOwnPost: true,
    timeAgo: "2 hours ago",
    text: "Today’s deployment went smoothly 🚀",
    images: [],
    likes: 20,
    comments: 5,
  ),
];

const String squareURL =
    "https://i.pinimg.com/474x/3f/b7/33/3fb7335fc67dcfb9e2ef621df2a33bc6.jpg";

const String portraitURL =
    "https://i.pinimg.com/736x/d6/38/9b/d6389b57a52869bded4bf77285f40e08.jpg";

const String landscapeURL =
    "https://i.pinimg.com/1200x/dd/ab/4a/ddab4a3ffe09ef37b96fca38b568bbba.jpg";

const String profileURL =
    "https://i.pinimg.com/736x/ed/1e/7b/ed1e7b36793209743a5c215a14cb83ec.jpg";

const String mediaURL1 =
    "https://i.pinimg.com/1200x/93/df/3d/93df3d6eefe218bb05c7ef460d20cf16.jpg";
const String mediaURL2 =
    "https://i.pinimg.com/736x/17/84/76/178476ee1dd0a9b936260d03e0ae983d.jpg";

const String mediaURL3 =
    "https://i.pinimg.com/1200x/25/99/46/259946128b9208b0c08fc74fbcf4488d.jpg";

const String mediaURL4 =
    "https://i.pinimg.com/736x/aa/f8/21/aaf82163ba2a3352ab6cf5b4a3a54a9c.jpg";

const String mediaURL5 =
    "https://i.pinimg.com/1200x/09/cb/40/09cb400244179dccea54a8df1c91d605.jpg";

const String mediaURL6 =
    "https://i.pinimg.com/736x/8a/53/f2/8a53f265f50fe2da77fe58d2f2d75b67.jpg";

const String mediaURL7 =
    "https://i.pinimg.com/1200x/bd/90/a6/bd90a6c8ea07dc7390e461b655a8b1c6.jpg";
const String mediaURL8 =
    "https://i.pinimg.com/736x/72/93/2d/72932d894f9597da42aee5cb4f34683e.jpg";

/// Updated feed item model with image list
class FeedItemModel {
  final String name;
  final String? avatarUrl;
  final bool isOwnPost;
  final String? groupName;
  final String timeAgo;
  final bool isPromoted;
  final String? promotionText;
  final String? text;
  final List<String> images;
  final int likes;
  final int comments;

  FeedItemModel({
    required this.name,
    this.avatarUrl,
    this.isOwnPost = false,
    this.groupName,
    this.timeAgo = '',
    this.isPromoted = false,
    this.promotionText,
    this.text,
    this.images = const [],
    this.likes = 0,
    this.comments = 0,
  });
}
