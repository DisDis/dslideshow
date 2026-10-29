import 'effect_variants.dart';

import 'package:dslideshow_flutter/effect.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'config.dart';
import 'photo_motion_probe.dart';

part 'plan.freezed.dart';
part 'plan.g.dart';

class MediaPair {
  final String name;
  final String from;
  final String to;
  const MediaPair(this.name, this.from, this.to);
  TransitionMedia type(String name) => name.endsWith('.mp4')
      ? TransitionMedia.video
      : name.endsWith('.gif')
      ? TransitionMedia.animatedImage
      : TransitionMedia.photo;
  bool get staticPhotos =>
      type(from) == TransitionMedia.photo && type(to) == TransitionMedia.photo;
  bool get hasVideo => from.endsWith('.mp4') || to.endsWith('.mp4');
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

@freezed
@JsonSerializable(createFactory: false, ignoreUnannotated: true)
class BenchmarkCase with _$BenchmarkCase {
  final Effect? effect;
  final bool photoMotion;
  final MediaPair media;
  final int grid;
  final MosaicBackend backend;
  final bool injectStall;
  const BenchmarkCase(
    this.effect,
    this.media, {
    this.photoMotion = false,
    this.grid = 100,
    this.backend = MosaicBackend.canvas,
    this.injectStall = false,
  });

  int durationMs(BenchmarkConfig config) =>
      (effect?.options.durationMs ?? 0) == 0
      ? config.transitionMs
      : effect!.options.durationMs;

  Effect? get effectiveEffect {
    final value = effect;
    if (value == null || !value.isMosaic) return value?.canonical;
    return value.configured(
      (value.options as MosaicEffectOptions).copyWith(gridSize: grid),
    );
  }

  String? get unsupportedReason =>
      photoMotion && !media.staticPhotos ||
          effect?.supportsMedia(media.type(media.from), media.type(media.to)) ==
              false
      ? 'This effect requires two static photos'
      : null;

  @JsonKey(includeToJson: true)
  String get id =>
      '${name.replaceAll(' ', '_')}--${media.name}'
      '${effect?.isMosaic == true ? '--$grid--${backend.name}' : ''}'
      '${effect == null || effectSettingsId(effectiveEffect!).isEmpty ? '' : '--${effectSettingsId(effectiveEffect!)}'}'
      '${injectStall ? '--stall80ms' : ''}';

  @JsonKey(name: 'effect', includeToJson: true)
  String get name =>
      photoMotion ? photoMotionProbeName : effect?.name ?? 'Baseline';

  @JsonKey(name: 'effect_config', includeToJson: true, includeIfNull: false)
  Map<String, Object?>? get _effectConfig => effect == null
      ? null
      : {effectiveEffect!.type.name: effectiveEffect!.toConfig().toJson()};

  @JsonKey(name: 'media', includeToJson: true)
  String get _mediaName => media.name;

  @JsonKey(name: 'from', includeToJson: true)
  String get _from => media.from;

  @JsonKey(name: 'photo_motion', includeToJson: true, includeIfNull: false)
  String? get _photoMotion => photoMotion ? 'kenBurns' : null;

  @JsonKey(name: 'to', includeToJson: true)
  String get _to => media.to;

  @JsonKey(name: 'grid', includeToJson: true)
  int? get _grid => effect?.isMosaic == true ? grid : null;

  @JsonKey(name: 'backend', includeToJson: true)
  String? get _backend => effect?.isMosaic == true ? backend.name : null;

  @JsonKey(name: 'injected_stall_ms', includeToJson: true)
  int get _injectedStallMs => injectStall ? 80 : 0;

  bool supportsCapture(BenchmarkConfig config) =>
      !media.hasVideo &&
      media.name == 'photo-photo' &&
      !injectStall &&
      (effect?.isMosaic != true ||
          config.visualAudit ||
          grid == config.grids.first);
  Map<String, Object?> toJson() => _$BenchmarkCaseToJson(this);
}

List<BenchmarkCase> buildPlan(BenchmarkConfig config) {
  final names =
      [...Effect.values, ...benchmarkEffects].map((e) => e.name).toSet()
        ..add('Baseline')
        ..add(photoMotionProbeName);
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
  final effects = config.effectConfigs == null
      ? <Effect?>[null, ...benchmarkEffects]
            .where(
              (effect) =>
                  config.effects == null ||
                  config.effects!.contains(effect?.name ?? 'Baseline'),
            )
            .toList()
      : <Effect?>[
          if (config.effects?.contains('Baseline') == true) null,
          ...benchmarkEffects.where(
            (effect) => config.effects?.contains(effect.name) == true,
          ),
          ...config.effectConfigs!.entries.expand(
            (entry) => entry.value.map(
              (variant) => Effect.fromConfig(entry.key, variant),
            ),
          ),
        ];
  for (final pair in pairs) {
    if (config.effects?.contains(photoMotionProbeName) == true) {
      result.add(BenchmarkCase(null, pair, photoMotion: true));
    }
    for (final effect in effects) {
      if (config.suite == 'smoke' &&
          pair.name != 'photo-photo' &&
          config.effects == null &&
          config.effectConfigs == null &&
          effect != null &&
          ![
            Effect.fadeEffect,
            Effect.cubeEffect,
            Effect.blindsEffect,
            (const Effect(EffectType.mosaic, options: MosaicEffectOptions())),
          ].contains(effect)) {
        continue;
      }
      // 48 MP originals exercise preparation plus the most demanding reuse paths.
      if (pair.name == 'large-photo' &&
          config.effects == null &&
          config.effectConfigs == null &&
          effect != null &&
          ![
            Effect.fadeEffect,
            Effect.blindsEffect,
            (const Effect(EffectType.mosaic, options: MosaicEffectOptions())),
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
      (const Effect(EffectType.mosaic, options: MosaicEffectOptions())),
    ]) {
      if (effects.contains(effect) && pairs.contains(mediaPairs.first)) {
        result.add(BenchmarkCase(effect, mediaPairs.first, injectStall: true));
      }
    }
  }
  if (result.isEmpty) throw ArgumentError('The selected matrix is empty');
  if (result.map((test) => test.id).toSet().length != result.length) {
    throw ArgumentError('Duplicate effect settings in the selected matrix');
  }
  return result;
}
