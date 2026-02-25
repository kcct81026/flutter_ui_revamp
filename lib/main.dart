// lib/main.dart
import 'package:flutter/material.dart';
import 'package:yc_ui/constants/dummy.dart';
import 'package:yc_ui/social_feed/social_feed.dart';
import 'package:flutter/scheduler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  PaintingBinding.instance.imageCache.maximumSize = 100;
  PaintingBinding.instance.imageCache.maximumSizeBytes = 50 << 20; //

  SchedulerBinding.instance.addTimingsCallback((List<FrameTiming> timings) {
    for (final timing in timings) {
      final buildTime = timing.buildDuration.inMilliseconds;
      final rasterTime = timing.rasterDuration.inMilliseconds;
      final totalTime = buildTime + rasterTime;

      if (totalTime > 16) {
        debugPrint(
          "⚠️ Slow frame: build=${buildTime}ms, raster=${rasterTime}ms, total=${totalTime}ms",
        );
      }
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showPerformanceOverlay: true,
      title: 'SliverList Phone Preview',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: SocialFeedScreen(items: generateFeed(200)),
      debugShowCheckedModeBanner: false,
    );
  }
}
