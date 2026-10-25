import 'dart:collection';

import 'package:dslideshow_backend/config.dart';

import 'slideshow_slide.dart';

/// Uses monotonic active playback time; wall clock changes affect clocks only.
class SpecialScreenScheduler {
  final List<SpecialScreenConfig> screens;
  final Duration Function()? elapsed;
  final _watch = Stopwatch()..start();
  Duration _accumulated = Duration.zero;
  Duration? _activeSince;
  final _mediaCounts = <String, int>{};
  final _lastShown = <String, Duration>{};
  final _cameraIndices = <String, int>{};
  final _pending = Queue<SpecialScreenConfig>();
  bool _lastWasSpecial = false;
  SpecialScreenScheduler(this.screens, {this.elapsed});
  Duration get _clock => elapsed?.call() ?? _watch.elapsed;
  Duration get _now =>
      _accumulated +
      (_activeSince == null ? Duration.zero : _clock - _activeSince!);
  void setActive(bool active) {
    if (active && _activeSince == null) {
      _activeSince = _clock;
    } else if (!active && _activeSince != null) {
      _accumulated += _clock - _activeSince!;
      _activeSince = null;
    }
  }

  void close() => _watch.stop();
  SpecialSlide? next() {
    if (_lastWasSpecial) return null;
    for (final screen in screens) {
      if (!screen.enabled || !screen.isSupported) continue;
      final options = screen.options;
      if (options is CamerasScreenOptions &&
          !options.cameras.any((c) => c.hasValidUrl)) {
        continue;
      }
      final due = screen.schedule.type == SpecialScreenScheduleType.interval
          ? _now - (_lastShown[screen.id] ?? Duration.zero) >=
                Duration(milliseconds: screen.schedule.intervalMs)
          : (_mediaCounts[screen.id] ?? 0) >= screen.schedule.count;
      if (due && !_pending.any((s) => s.id == screen.id)) _pending.add(screen);
    }
    if (_pending.isEmpty) return null;
    final screen = _pending.removeFirst();
    return SpecialSlide(screen, cameraIndex: _cameraIndices[screen.id] ?? 0);
  }

  void shown(SlideshowSlide slide) {
    if (slide is MediaSlide) {
      _lastWasSpecial = false;
      for (final screen in screens) {
        _mediaCounts.update(screen.id, (value) => value + 1, ifAbsent: () => 1);
      }
    } else if (slide is SpecialSlide) {
      _lastWasSpecial = true;
      _markAttempt(slide);
      final options = slide.config.options;
      if (options is CamerasScreenOptions &&
          options.mode == CameraDisplayMode.sequence &&
          options.cameras.isNotEmpty) {
        _cameraIndices[slide.config.id] =
            (slide.cameraIndex + 1) % options.cameras.length;
      }
    }
  }

  // Failed screens back off for their normal interval, without consuming media.
  void skipped(SpecialSlide slide) => _markAttempt(slide);
  void _markAttempt(SpecialSlide slide) {
    final id = slide.config.id;
    _mediaCounts[id] = 0;
    _lastShown[id] = _now;
    _pending.removeWhere((s) => s.id == id);
  }
}
