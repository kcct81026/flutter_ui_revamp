import 'package:video_player/video_player.dart';

class VideoControllerManager {
  static final VideoControllerManager instance = VideoControllerManager._();

  VideoControllerManager._();

  VideoPlayerController? _currentController;

  Future<VideoPlayerController> playVideo(String url) async {
    if (_currentController != null) {
      await _currentController!.pause();
      await _currentController!.dispose();
    }

    _currentController = VideoPlayerController.networkUrl(Uri.parse(url));

    await _currentController!.initialize();
    await _currentController!.play();

    return _currentController!;
  }

  void disposeCurrent() {
    _currentController?.dispose();
    _currentController = null;
  }
}
