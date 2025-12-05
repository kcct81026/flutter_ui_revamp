// lib/main.dart
import 'package:flutter/material.dart';
import 'package:yc_ui/constants/dummy.dart';
import 'package:yc_ui/social_feed/social_feed.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SliverList Phone Preview',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: SocialFeedScreen(items: dummyFeedItems),
      debugShowCheckedModeBanner: false,
    );
  }
}
