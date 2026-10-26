import 'package:flutter/widgets.dart';
import 'package:video_player_platform_interface/video_player_platform_interface.dart';

/// One decoder and its view. The platform bridge owns its complete lifetime.
abstract interface class LinuxVideoSession {
  Stream<VideoEvent> get events;
  Duration get position;

  Future<void> open(DataSource source);
  Future<void> dispose();
  Future<void> play();
  Future<void> pause();
  Future<void> setLooping(bool looping);
  Future<void> setVolume(double volume);
  Future<void> setPlaybackSpeed(double speed);
  Future<void> seekTo(Duration position);
  Widget buildView();
}
