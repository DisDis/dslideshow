import 'dart:io';

import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_flutter/environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:video_player/video_player.dart';

import 'item_widget.dart';

class VideoWidget extends StatefulWidget implements ItemWidget {
  final File mediaFile;
  @override
  final MediaItem item;

  VideoWidget(this.item)
      : mediaFile = File(item.uri!.toFilePath()),
        super(key: Key('mp4:${item.uri!.toFilePath()}'));

  @override
  // ignore: library_private_types_in_public_api
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  static final bool isVideoSupport = isLinuxEmbedded || !(Platform.isLinux || Platform.isWindows);

  static final Logger _log = Logger('_VideoWidgetState');

  late VideoPlayerController _controller;

  _VideoWidgetState();

  @override
  Widget build(BuildContext context) {
    if (!isVideoSupport) {
      return const Center(child: Text('Video not supported'));
    }

    return Center(
      child: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          : Container(),
    );
  }

  @override
  void dispose() {
    if (isVideoSupport) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (isVideoSupport) {
      _controller = VideoPlayerController.file(widget.mediaFile)
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        }).catchError((dynamic message, StackTrace s) {
          _log.severe('VideoPlayerController.initialize: $message', s);
        });
      _controller.setLooping(true);
      _controller.play().catchError((dynamic message, StackTrace s) {
        _log.severe('VideoPlayerController.play: $message', s);
      });
    }
  }
}
