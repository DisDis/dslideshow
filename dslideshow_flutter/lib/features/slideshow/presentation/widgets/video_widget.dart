import 'dart:async';
import 'dart:io';

import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_flutter/environment.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:video_player/video_player.dart';

import 'item_widget.dart';

/// A decoder owned by the slideshow, independent of its visual views.
/// All Blinds strips share this session's one video texture.
class VideoSession {
  static final bool isSupported =
      isLinuxEmbedded || !(Platform.isLinux || Platform.isWindows);

  final VideoPlayerController? controller;
  Future<void>? _preparation;
  bool _disposed = false;
  bool _shouldPlay = false;

  VideoSession(File file, {VideoPlayerController? controller, bool? supported})
    : controller = (supported ?? isSupported)
          ? controller ?? VideoPlayerController.file(file)
          : null;

  VideoSession.network(Uri uri)
    : controller = VideoPlayerController.networkUrl(uri);

  Future<void> prepare() => _preparation ??= _prepare();

  Future<void> _prepare() async {
    final player = controller;
    if (player == null || _disposed) return;
    await player.initialize();
    if (_disposed) return;
    await player.setLooping(true);
  }

  Future<void> setPlaying(bool playing) async {
    _shouldPlay = playing;
    await prepare();
    if (_disposed || controller == null) return;
    // Read the latest intent after initialization, including pause/screen sleep.
    if (_shouldPlay) {
      await controller!.play();
    } else {
      await controller!.pause();
    }
  }

  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    await controller?.dispose();
  }
}

class VideoWidget extends StatefulWidget implements ItemWidget {
  @override
  final MediaItem item;
  final VideoSession? session;

  VideoWidget(this.item, {this.session})
    : super(key: ValueKey('video:${item.uri}'));

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  static final Logger _log = Logger('VideoWidget');
  late VideoSession _session;

  @override
  void initState() {
    super.initState();
    _attach();
  }

  void _attach() {
    _session =
        widget.session ?? VideoSession(File(widget.item.uri!.toFilePath()));
    if (widget.session == null) {
      unawaited(
        _session.setPlaying(true).catchError((Object e, StackTrace st) {
          _log.warning('Video preparation/playback failed', e, st);
        }),
      );
    }
  }

  @override
  void didUpdateWidget(covariant VideoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.session != widget.session) {
      if (oldWidget.session == null) unawaited(_session.dispose());
      _attach();
    }
  }

  @override
  void dispose() {
    if (widget.session == null) unawaited(_session.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final player = _session.controller;
    if (player == null) {
      return const Center(child: Text('Video not supported'));
    }
    return ValueListenableBuilder<VideoPlayerValue>(
      valueListenable: player,
      child: VideoPlayer(player),
      builder: (context, value, child) => Center(
        child: value.isInitialized
            ? AspectRatio(aspectRatio: value.aspectRatio, child: child)
            : const SizedBox.shrink(),
      ),
    );
  }
}
