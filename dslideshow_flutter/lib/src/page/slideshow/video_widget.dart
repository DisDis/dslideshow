import 'dart:io';

import 'package:dslideshow_backend/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final File mediaFile;

  VideoWidget(MediaItem item) : this.mediaFile = new File(item.uri.path);

  @override
  _VideoWidgetState createState() => _VideoWidgetState(mediaFile);
}

class _VideoWidgetState extends State<VideoWidget> {
  static final bool isVideoSupport = !(Platform.isLinux || Platform.isWindows);

  final File videoFile;

  VideoPlayerController _controller;

  _VideoWidgetState(this.videoFile);

  @override
  Widget build(BuildContext context) {
    if (!isVideoSupport) {
      return Container();
    }

    return _controller.value.initialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : Container();
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (isVideoSupport) {
      _controller = VideoPlayerController.file(videoFile)
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
      _controller.play();
    }
  }
}
