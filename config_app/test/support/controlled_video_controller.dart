import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

enum VideoControllerFailure {
  none,
  initialize,
  looping,
  play,
  pause,
  seek,
  dispose,
}

class ControlledVideoController extends VideoPlayerController {
  ControlledVideoController({
    this.failure = VideoControllerFailure.none,
    this.initializeGate,
    this.pauseGate,
    this.seekGate,
  }) : super.networkUrl(Uri.parse('https://frame.local/video.mp4'));

  VideoControllerFailure failure;
  final Completer<void>? initializeGate;
  final Completer<void>? pauseGate;
  final Completer<void>? seekGate;
  final seeks = <Duration>[];
  int initializeCalls = 0;
  int loopingCalls = 0;
  int playCalls = 0;
  int pauseCalls = 0;
  int disposeCalls = 0;
  bool disposed = false;

  @override
  Future<void> initialize() async {
    initializeCalls++;
    await initializeGate?.future;
    if (failure == VideoControllerFailure.initialize) {
      throw StateError('private media URL');
    }
    if (!disposed) {
      value = value.copyWith(
        duration: const Duration(seconds: 10),
        size: const Size(320, 180),
        isInitialized: true,
      );
    }
  }

  @override
  Future<void> setLooping(bool looping) async {
    loopingCalls++;
    if (failure == VideoControllerFailure.looping) {
      throw StateError('private media URL');
    }
    value = value.copyWith(isLooping: looping);
  }

  @override
  Future<void> play() async {
    playCalls++;
    if (failure == VideoControllerFailure.play) {
      throw StateError('private media URL');
    }
    value = value.copyWith(isPlaying: true);
  }

  @override
  Future<void> pause() async {
    pauseCalls++;
    await pauseGate?.future;
    if (failure == VideoControllerFailure.pause) {
      throw StateError('private media URL');
    }
    if (!disposed) value = value.copyWith(isPlaying: false);
  }

  @override
  Future<void> seekTo(Duration position) async {
    seeks.add(position);
    await seekGate?.future;
    if (failure == VideoControllerFailure.seek) {
      throw StateError('private media URL');
    }
    if (!disposed) value = value.copyWith(position: position);
  }

  @override
  Future<void> dispose() async {
    disposeCalls++;
    disposed = true;
    await super.dispose();
    if (failure == VideoControllerFailure.dispose) {
      throw StateError('private media URL');
    }
  }
}
