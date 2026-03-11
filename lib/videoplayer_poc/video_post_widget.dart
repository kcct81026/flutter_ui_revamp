import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:yc_ui/videoplayer_poc/video_controller_manager.dart';

class VideoPostWidget extends StatefulWidget {
  final String videoUrl;
  final String thumbnail;

  const VideoPostWidget({
    super.key,
    required this.videoUrl,
    required this.thumbnail,
  });

  @override
  State<VideoPostWidget> createState() => _VideoPostWidgetState();
}

class _VideoPostWidgetState extends State<VideoPostWidget> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;

  bool _initialized = false;
  bool _playing = false;

  Future<void> _initializeVideo() async {
    final controller = await VideoControllerManager.instance.playVideo(
      widget.videoUrl,
    );

    _videoController = controller;

    _chewieController = ChewieController(
      videoPlayerController: _videoController!,
      autoPlay: true,
      looping: false,
    );

    setState(() {
      _initialized = true;
      _playing = true;
    });
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  Widget _buildPreview() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.network(
          widget.thumbnail,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        IconButton(
          icon: const Icon(
            Icons.play_circle_fill,
            size: 64,
            color: Colors.white,
          ),
          onPressed: _initializeVideo,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_playing) {
      return AspectRatio(aspectRatio: 16 / 9, child: _buildPreview());
    }

    if (!_initialized) {
      return const AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return AspectRatio(
      aspectRatio: _videoController!.value.aspectRatio,
      child: Chewie(controller: _chewieController!),
    );
  }
}
