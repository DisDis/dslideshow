import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:video_player/video_player.dart';

class VideoGridItem extends StatefulWidget {
  final String url;
  final String title;

  const VideoGridItem({super.key, required this.url, required this.title});

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
        color: Theme.of(context).colorScheme.errorContainer,
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.error,
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
              Text(
                widget.title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onErrorContainer,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      );
    }

    // 2. Если видео готово и инициализировано
    if (_isInitialized && _controller != null) {
      return Stack(
        fit: StackFit.expand,
        children: [
          // Сам плеер. FittedBox нужен, чтобы видео заполнило квадрат (обрезалось)
          Tooltip(
            message: widget.title,
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller!.value.size.width,
                height: _controller!.value.size.height,
                child: VideoPlayer(_controller!),
              ),
            ),
          ),
          // Кнопка паузы (появляется при тапе, если нужно, или делаем прозрачной)
          if (!_isPlaying)
            Center(
              child: IconButton(
                onPressed: _playPause,
                tooltip: context.localizations.preview_resume,
                icon: Icon(
                  Icons.play_circle_fill,
                  size: 50,
                  color: Theme.of(context).colorScheme.primary,
                ),
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
        Container(color: Theme.of(context).colorScheme.surfaceContainerHighest),

        // Кнопка "Скачать и смотреть"
        IconButton(
          onPressed: _initializeVideo, // Начинаем грузить только по клику
          tooltip: context.localizations.video_load,
          icon: Icon(
            Icons.play_circle_outline,
            size: 40,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),

        // Текст для понятности
        Positioned(
          left: 8,
          right: 8,
          bottom: 10,
          child: Column(
            children: [
              Text(
                widget.title,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                context.localizations.video_tap_to_play,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
