// lib/main.dart
import 'package:flutter/material.dart';
import 'package:yc_ui/sliverlist_main_page.dart';

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
      home: const SliverListMainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
