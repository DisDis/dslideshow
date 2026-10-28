import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FakeVideoController extends VideoPlayerController {
  final Completer<void>? gate;
  final Object? disposalError;
  int initializations = 0;
  int disposals = 0;
  int plays = 0;
  int pauses = 0;
  bool dead = false;
  FakeVideoController({this.gate, this.disposalError})
    : super.file(File('/tmp/session-test.mp4'));
  @override
  Future<void> initialize() async {
    initializations++;
    await gate?.future;
    if (dead) return;
    value = value.copyWith(
      isInitialized: true,
      duration: const Duration(seconds: 30),
      size: const Size(320, 240),
    );
  }

  @override
  Future<void> setLooping(bool looping) async {}
  @override
  Future<void> play() async {
    plays++;
  }

  @override
  Future<void> pause() async {
    pauses++;
  }

  @override
  Future<void> dispose() async {
    disposals++;
    dead = true;
    await super.dispose();
    if (disposalError case final error?) throw error;
  }
}
