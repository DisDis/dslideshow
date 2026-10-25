import 'package:dslideshow_flutter/effect.dart';

import 'config.dart';

class MediaPair {
  final String name;
  final String from;
  final String to;
  const MediaPair(this.name, this.from, this.to);
}

const mediaPairs = [
  MediaPair('photo-photo', 'photo_a.jpg', 'photo_b.jpg'),
  MediaPair('photo-video', 'photo_a.jpg', 'video_a.mp4'),
  MediaPair('video-photo', 'video_a.mp4', 'photo_b.jpg'),
  MediaPair('video-video', 'video_a.mp4', 'video_b.mp4'),
  MediaPair('gif-photo', 'animation.gif', 'photo_b.jpg'),
  MediaPair('photo-gif', 'photo_a.jpg', 'animation.gif'),
  MediaPair('large-photo', 'photo_large.jpg', 'photo_b.jpg'),
];

class BenchmarkCase {
  final Effect? effect;
  final MediaPair media;
  final int grid;
  final MosaicBackend backend;
  final bool injectStall;
  const BenchmarkCase(
    this.effect,
    this.media, {
    this.grid = 100,
    this.backend = MosaicBackend.canvas,
    this.injectStall = false,
  });

  String get name => effect?.name ?? 'Baseline';
  String get id =>
      '${name.replaceAll(' ', '_')}--${media.name}'
      '${effect?.isMosaic == true ? '--$grid--${backend.name}' : ''}'
      '${injectStall ? '--stall80ms' : ''}';
  Map<String, Object?> toJson() => {
    'id': id,
    'effect': name,
    'media': media.name,
    'from': media.from,
    'to': media.to,
    'grid': effect?.isMosaic == true ? grid : null,
    'backend': effect?.isMosaic == true ? backend.name : null,
    'injected_stall_ms': injectStall ? 80 : 0,
  };
}

List<BenchmarkCase> buildPlan(BenchmarkConfig config) {
  final names = Effect.values.map((e) => e.name).toSet()..add('Baseline');
  for (final name in config.effects ?? <String>[]) {
    if (!names.contains(name)) throw ArgumentError('Unknown effect: $name');
  }
  for (final name in config.mediaCases ?? <String>[]) {
    if (!mediaPairs.any((p) => p.name == name)) {
      throw ArgumentError('Unknown media case: $name');
    }
  }
  final result = <BenchmarkCase>[];
  final pairs = config.mediaCases == null
      ? mediaPairs
      : mediaPairs.where((p) => config.mediaCases!.contains(p.name));
  final effects = <Effect?>[null, ...Effect.values].where(
    (e) =>
        config.effects == null ||
        config.effects!.contains(e?.name ?? 'Baseline'),
  );
  for (final pair in pairs) {
    for (final effect in effects) {
      if (config.suite == 'smoke' &&
          pair.name != 'photo-photo' &&
          config.effects == null &&
          effect != null &&
          ![
            Effect.fadeEffect,
            Effect.cubeEffect,
            Effect.blindsEffect,
            Effect.mosaicFadeEffect,
          ].contains(effect)) {
        continue;
      }
      // 48 MP originals exercise preparation plus the most demanding reuse paths.
      if (pair.name == 'large-photo' &&
          config.effects == null &&
          effect != null &&
          ![
            Effect.fadeEffect,
            Effect.blindsEffect,
            Effect.mosaicFadeEffect,
          ].contains(effect)) {
        continue;
      }
      if (effect?.isMosaic == true) {
        for (final grid in config.grids.toSet()) {
          for (final backend in config.backends.toSet()) {
            result.add(
              BenchmarkCase(
                effect,
                pair,
                grid: grid,
                backend: MosaicBackend.values.byName(backend),
              ),
            );
          }
        }
      } else {
        result.add(BenchmarkCase(effect, pair));
      }
    }
  }
  if (config.suite != 'smoke') {
    for (final effect in [
      Effect.fadeEffect,
      Effect.blindsEffect,
      Effect.mosaicFadeEffect,
    ]) {
      if (effects.contains(effect) && pairs.contains(mediaPairs.first)) {
        result.add(BenchmarkCase(effect, mediaPairs.first, injectStall: true));
      }
    }
  }
  if (result.isEmpty) throw ArgumentError('The selected matrix is empty');
  return result;
}
