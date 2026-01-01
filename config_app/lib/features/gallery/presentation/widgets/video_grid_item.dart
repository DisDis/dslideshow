import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:video_player/video_player.dart';

class VideoGridItem extends StatefulWidget {
  final String url;
  final String title;

  const VideoGridItem({Key? key, required this.url, required this.title})
      : super(key: key);

  @override
  State<VideoGridItem> createState() => _VideoGridItemState();
}

class _VideoGridItemState extends State<VideoGridItem> {
  static final Logger _log = Logger('_VideoGridItemState');

  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _isPlaying = false;
  bool _hasError = false;

  @override
  void dispose() {
    // ОБЯЗАТЕЛЬНО освобождаем ресурсы при скролле или закрытии
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _initializeVideo() async {
    if (_controller != null) return; // Уже инициализировано

    // Создаем контроллер для GET запроса
    // Если нужны заголовки (headers), используйте VideoPlayerController.networkUrl(uri, httpHeaders: ...)
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url));

    try {
      await _controller!.initialize();
      await _controller!.setLooping(true); // Зациклить видео
      setState(() {
        _isInitialized = true;
      });
      _playPause(); // Сразу запускаем
    } catch (e) {
      _log.warning("Ошибка загрузки видео: $e");
      setState(() {
        _hasError = true;
      });
    }
  }

  void _playPause() {
    setState(() {
      if (_controller!.value.isPlaying) {
        _controller!.pause();
        _isPlaying = false;
      } else {
        _controller!.play();
        _isPlaying = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 1. Если ошибка загрузки
    if (_hasError) {
      return Container(
        color: Colors.black,
        child: const Center(child: Icon(Icons.error, color: Colors.red)),
      );
    }

    // 2. Если видео готово и инициализировано
    if (_isInitialized && _controller != null) {
      return Stack(
        fit: StackFit.expand,
        children: [
          // Сам плеер. FittedBox нужен, чтобы видео заполнило квадрат (обрезалось)
          FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _controller!.value.size.width,
              height: _controller!.value.size.height,
              child: VideoPlayer(_controller!),
            ),
          ),
          // Кнопка паузы (появляется при тапе, если нужно, или делаем прозрачной)
          if (!_isPlaying)
            Center(
              child: IconButton(
                onPressed: _playPause,
                icon: const Icon(Icons.play_circle_fill,
                    size: 50, color: Colors.white),
              ),
            ),
          // Прозрачный слой для управления нажатием (Play/Pause)
          GestureDetector(
            onTap: _playPause,
            behavior: HitTestBehavior.translucent,
            child: Container(),
          ),
        ],
      );
    }

    // 3. Заглушка (пока видео не нажали)
    return Stack(
      alignment: Alignment.center,
      children: [
        // Фон (черный или можно поставить превью картинкой, если есть)
        Container(color: Colors.black87),

        // Кнопка "Скачать и смотреть"
        IconButton(
          onPressed: _initializeVideo, // Начинаем грузить только по клику
          icon: const Icon(Icons.play_circle_outline,
              size: 40, color: Colors.white),
        ),
        const SizedBox(height: 4),
        Text(
          widget.title,
          style: const TextStyle(color: Colors.white70, fontSize: 10),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        // Текст для понятности
        const Positioned(
          bottom: 10,
          child: Text(
            "Tap to play",
            style: TextStyle(color: Colors.white54, fontSize: 10),
          ),
        )
      ],
    );
  }
}
