import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SingleVideoPlayer extends StatefulWidget {
  final Uri uri;
  final VoidCallback onContentTap;

  const SingleVideoPlayer({super.key, required this.uri, required this.onContentTap});

  @override
  State<SingleVideoPlayer> createState() => _SingleVideoPlayerState();
}


class _SingleVideoPlayerState extends State<SingleVideoPlayer> {
  late VideoPlayerController _controller;
  bool _initialized = false;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(widget.uri)
      ..initialize().then((_) {
        setState(() {
          _initialized = true;
          _isPlaying = true;
        });
        _controller.play();
        _controller.setLooping(true);
      });
    
    _controller.addListener(() {
      // Обновляем UI для слайдера прогресса
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlay() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const CircularProgressIndicator(color: Colors.white);
    }

    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          VideoPlayer(_controller),
          
          // Прозрачный слой для клика Play/Pause по центру, если нужно,
          // но мы используем глобальный тап для скрытия UI.
          // Добавим большую кнопку Play по центру, если пауза
          if (!_isPlaying)
            Center(
              child: IconButton(
                iconSize: 64,
                icon: const Icon(Icons.play_circle_fill, color: Colors.white54),
                onPressed: _togglePlay,
              ),
            ),
            
          // Видео Прогресс (в самом низу видео)
          VideoProgressIndicator(
            _controller, 
            allowScrubbing: true,
            colors: const VideoProgressColors(
              playedColor: Colors.cyanAccent,
              bufferedColor: Colors.white24,
              backgroundColor: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
