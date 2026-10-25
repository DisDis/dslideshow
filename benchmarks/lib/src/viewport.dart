import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_flutter/effect.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/fixed_animation_controller.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/image_widget.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/video_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

import 'config.dart';
import 'driver.dart';
import 'media.dart';
import 'metrics.dart';
import 'plan.dart';
import 'telemetry.dart';
import 'visual_audit.dart';

class BenchmarkViewport extends StatefulWidget {
  final BenchmarkConfig config;
  final MediaCatalog catalog;
  final Directory reportDirectory;
  final Future<void> Function(BenchmarkDriver driver) onReady;
  final Future<void> Function(String operation, String file)? onVideoOperation;
  const BenchmarkViewport({
    super.key,
    required this.config,
    required this.catalog,
    required this.reportDirectory,
    required this.onReady,
    this.onVideoOperation,
  });

  @override
  State<BenchmarkViewport> createState() => _BenchmarkViewportState();
}

class _BenchmarkViewportState extends State<BenchmarkViewport>
    with SingleTickerProviderStateMixin
    implements BenchmarkDriver {
  late final FixedAnimationController _controller;
  MediaSliderItemEffect? _effect;
  Widget _from = const SizedBox.expand(), _to = const SizedBox.expand();
  final List<ImageWidget> _images = [];
  final List<VideoSession> _videos = [];
  final Map<VideoSession, String> _videoNames = {};
  final GlobalKey _captureKey = GlobalKey();
  List<FrameSample>? _frames;
  String _status = 'Подготовка автоматического прогона…';
  String? _captureLabel;
  bool _scene = false;
  int _generation = 0;
  int _windowStart = 0;
  int? _windowEnd;
  final Map<String, Map<String, Object?>> _videoProbes = {};

  @override
  void initState() {
    super.initState();
    _controller = FixedAnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.config.transitionMs),
      animationBehavior: AnimationBehavior.preserve,
    );
    SchedulerBinding.instance.addTimingsCallback(_timings);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(widget.onReady(this));
    });
  }

  void _timings(List<ui.FrameTiming> timings) {
    final frames = _frames;
    if (frames == null) return;
    for (final timing in timings) {
      final stamp = timing.timestampInMicroseconds(ui.FramePhase.vsyncStart);
      if (stamp > _windowStart &&
          (_windowEnd == null || stamp <= _windowEnd!)) {
        frames.add(
          FrameSample(
            stamp,
            timing.buildDuration.inMicroseconds,
            timing.rasterDuration.inMicroseconds,
            timing.totalSpan.inMicroseconds,
          ),
        );
      }
    }
  }

  @override
  Map<String, Object?> get display {
    final view = View.of(context);
    return {
      'physical_width': view.physicalSize.width,
      'physical_height': view.physicalSize.height,
      'logical_width': view.physicalSize.width / view.devicePixelRatio,
      'logical_height': view.physicalSize.height / view.devicePixelRatio,
      'pixel_ratio': view.devicePixelRatio,
      'refresh_hz': view.display.refreshRate,
      'refresh_fallback': view.display.refreshRate <= 0,
    };
  }

  Future<void> _paint() async {
    if (!mounted) throw StateError('Viewport detached');
    setState(() {});
    await SchedulerBinding.instance.endOfFrame;
  }

  @override
  Future<Map<String, Object?>> prepare(BenchmarkCase test) async {
    final releasing = release();
    final generation = _generation;
    await releasing;
    if (generation != _generation) throw StateError('Preparation cancelled');
    _status = 'Подготовка: ${test.id}';
    await _paint();
    if (!mounted) throw StateError('Viewport detached');
    final details = <Map<String, Object?>>[];
    final videoViews = <(String, VideoSession, Widget)>[];
    final size = MediaQuery.sizeOf(context);
    final ratio = View.of(context).devicePixelRatio;
    final slideshow = SlideShowConfig.fromJson({});
    Future<Widget> load(String name) async {
      final watch = Stopwatch()..start();
      final rssBefore = ProcessInfo.currentRss;
      final item = MediaItem(name, widget.catalog.file(name).uri);
      Widget view;
      Map<String, Object?> videoInfo = {};
      if (name.endsWith('.mp4')) {
        final session = VideoSession(widget.catalog.file(name));
        _videos.add(session);
        _videoNames[session] = name;
        await widget.onVideoOperation?.call('initialize', name);
        await session.prepare();
        await widget.onVideoOperation?.call('initialized', name);
        final player = session.controller;
        if (player == null || !player.value.isInitialized) {
          throw StateError('Video decoder unavailable: $name');
        }
        await player.setVolume(0);
        videoInfo = {
          'decoded_width': player.value.size.width,
          'decoded_height': player.value.size.height,
          'duration_ms': player.value.duration.inMilliseconds,
        };
        view = VideoWidget(item, session: session);
        videoViews.add((name, session, view));
      } else {
        final image = ImageWidget(item, slideshow, size, pixelRatio: ratio);
        _images.add(image);
        await image.precache(context);
        view = image;
      }
      if (generation != _generation || !mounted) {
        throw StateError('Preparation cancelled');
      }
      details.add({
        'file': name,
        'prepare_ms': watch.elapsedMicroseconds / 1000,
        'rss_before_bytes': rssBefore,
        'rss_after_bytes': ProcessInfo.currentRss,
        'hwm_bytes': parseKiB(
          await readText('/proc/self/status') ?? '',
        )['VmHWM'],
        ...videoInfo,
      });
      return RepaintBoundary(
        child: ColoredBox(color: Colors.black, child: view),
      );
    }

    final from = await load(test.media.from);
    final to = await load(test.media.to);
    _effect = test.effect?.createEffect(
      seed: widget.config.seed,
      mosaicGridSize: test.grid,
      mosaicBackend: test.backend,
    );
    final effectWatch = Stopwatch()..start();
    await _effect?.prepare();
    effectWatch.stop();
    if (generation != _generation) throw StateError('Preparation cancelled');
    _from = from;
    _to = to;
    _controller.value = 0;
    _scene = true;
    await _paint();
    // Functional pause/resume intent uses the same shared sessions as production.
    for (final video in _videos) {
      await video.setPlaying(false);
    }
    for (final (name, session, view) in videoViews) {
      if (!_videoProbes.containsKey(name)) {
        final probe = await _probeVideo(name, session, view, generation);
        if (generation != _generation) {
          throw StateError('Preparation cancelled');
        }
        _videoProbes[name] = probe;
      }
    }
    if (generation != _generation || !mounted) {
      throw StateError('Preparation cancelled');
    }
    _from = from;
    _to = to;
    _controller.value = 0;
    await _paint();
    return {
      'media': details,
      'effect_prepare_ms': effectWatch.elapsedMicroseconds / 1000,
      'decoder_count': _videos.length,
      'slideshow_config': slideshow.toJson(),
      'video_texture_probes': {..._videoProbes},
    };
  }

  // A positive capture of changing pixels is evidence of texture composition.
  // A black/failed capture is ambiguous: some embedders cannot snapshot Texture.
  // Run once per source, before warmups, never inside performance windows.
  Future<Map<String, Object?>> _probeVideo(
    String name,
    VideoSession session,
    Widget view,
    int generation,
  ) async {
    void ensureActive() {
      if (!mounted || generation != _generation) {
        throw StateError('Video probe cancelled');
      }
    }

    final savedEffect = _effect;
    final watch = Stopwatch()..start();
    final result = <String, Object?>{
      'file': name,
      'status': 'unverified',
      'note': 'Capture evidence does not verify physical display scanout',
    };
    try {
      _effect = null;
      _from = ColoredBox(color: Colors.black, child: view);
      await session.controller!.seekTo(Duration.zero);
      await session.setPlaying(true);
      final samples = <List<int>>[];
      final files = <String>[];
      final positions = <int>[];
      final folder = Directory('${widget.reportDirectory.path}/video-probes');
      await folder.create(recursive: true);
      if (!mounted) throw StateError('Viewport detached');
      final ratio = View.of(context).devicePixelRatio;
      for (var i = 0; i < 2; i++) {
        ensureActive();
        await _paint();
        await Future<void>.delayed(const Duration(milliseconds: 700));
        positions.add(session.controller!.value.position.inMilliseconds);
        ensureActive();
        final boundary =
            _captureKey.currentContext!.findRenderObject()!
                as RenderRepaintBoundary;
        final image = await boundary.toImage(pixelRatio: ratio);
        try {
          final data = await image.toByteData(
            format: ui.ImageByteFormat.rawRgba,
          );
          if (data == null) {
            throw StateError('Texture capture returned no pixels');
          }
          final rgba = data.buffer.asUint8List(
            data.offsetInBytes,
            data.lengthInBytes,
          );
          final sample = <int>[];
          for (var y = 0; y < 32; y++) {
            for (var x = 0; x < 32; x++) {
              final offset =
                  (((y + .5) * image.height / 32).floor() * image.width +
                      ((x + .5) * image.width / 32).floor()) *
                  4;
              sample.addAll([rgba[offset], rgba[offset + 1], rgba[offset + 2]]);
            }
          }
          samples.add(sample);
          final png = await image.toByteData(format: ui.ImageByteFormat.png);
          final relative = 'video-probes/$name--$i.png';
          await File('${widget.reportDirectory.path}/$relative')
              .writeAsBytes(png!.buffer.asUint8List());
          files.add(relative);
        } finally {
          image.dispose();
        }
      }
      final lit = samples.last.where((v) => v > 8).length / samples.last.length;
      var difference = 0;
      for (var i = 0; i < samples.first.length; i++) {
        difference += (samples.first[i] - samples.last[i]).abs();
      }
      final delta = difference / samples.first.length;
      result.addAll({
        'status': lit > .05 && delta > .5
            ? 'captured_motion'
            : 'unverified_black_or_static_capture',
        'nonblack_channel_fraction': lit,
        'mean_absolute_pixel_change': delta,
        'positions_ms': positions,
        'captures': files,
      });
    } catch (error) {
      result['capture_error'] = '$error';
    } finally {
      if (generation == _generation) _effect = savedEffect;
      await session.setPlaying(false);
    }
    result['probe_ms'] = watch.elapsedMicroseconds / 1000;
    return result;
  }

  @override
  Future<RunMeasurement> run(BenchmarkCase test) async {
    final generation = _generation;
    void ensureActive() {
      if (generation != _generation || !mounted) {
        throw StateError('Run cancelled');
      }
    }

    if (!mounted) throw StateError('Viewport detached');
    final refresh = View.of(context).display.refreshRate;
    final positions = List<int>.filled(_videos.length, 0);
    final changes = List<int>.filled(_videos.length, 0);
    final listeners = <VoidCallback>[];
    for (var i = 0; i < _videos.length; i++) {
      final player = _videos[i].controller!;
      void observe() {
        final position = player.value.position.inMilliseconds;
        if (position > positions[i]) changes[i]++;
        positions[i] = position;
      }

      listeners.add(observe);
      player.addListener(observe);
    }
    for (final video in _videos) {
      await widget.onVideoOperation?.call('seek', _videoNames[video]!);
      await video.controller!.seekTo(Duration.zero);
      ensureActive();
      await widget.onVideoOperation?.call('play', _videoNames[video]!);
      await video.setPlaying(true);
      ensureActive();
    }
    _controller.value = 0;
    await _paint();
    ensureActive();
    final probe = ProgressProbe();
    final progress = <Map<String, Object?>>[];
    final watch = Stopwatch()..start();
    var stalled = false;
    void tick() {
      probe.add(_controller.value);
      progress.add({
        'elapsed_us': watch.elapsedMicroseconds,
        'progress': _controller.value,
        'vsync_us': SchedulerBinding
            .instance
            .currentSystemFrameTimeStamp
            .inMicroseconds,
      });
      if (test.injectStall && !stalled && _controller.value >= .35) {
        stalled = true;
        final stall = Stopwatch()..start();
        while (stall.elapsedMilliseconds < 80) {
          /* deliberate UI load, labelled separately */
        }
      }
    }

    _windowStart =
        SchedulerBinding.instance.currentSystemFrameTimeStamp.inMicroseconds;
    _windowEnd = null;
    _frames = [];
    _controller.addListener(tick);
    Object? failure;
    try {
      await _controller
          .forward(from: 0)
          .orCancel
          .timeout(Duration(seconds: widget.config.transitionTimeoutSeconds));
    } catch (error) {
      failure = error;
      _controller.stop();
    } finally {
      _windowEnd =
          SchedulerBinding.instance.currentSystemFrameTimeStamp.inMicroseconds;
      _controller.removeListener(tick);
      watch.stop();
    }
    final videoStates = [
      for (var i = 0; i < _videos.length; i++)
        {
          'position_ms': _videos[i].controller!.value.position.inMilliseconds,
          'position_advances': changes[i],
          'error': _videos[i].controller!.value.errorDescription,
          'is_playing': _videos[i].controller!.value.isPlaying,
          'texture_visual_verification':
              'see metadata.video_texture_probes; physical scanout unverified',
        },
    ];
    for (var i = 0; i < _videos.length; i++) {
      _videos[i].controller!.removeListener(listeners[i]);
    }
    // Release builds batch FrameTiming delivery (~1 s). Hold this window until
    // its tail arrives; exclude later vsyncs even when videos keep producing frames.
    await Future<void>.delayed(
      Duration(milliseconds: widget.config.timingDrainMs),
    );
    ensureActive();
    final frames = _frames!;
    _frames = null;
    final errors = <String>[
      if (failure != null) '$failure',
      if (!probe.smooth(widget.config.transitionMs)) 'Progress discontinuity',
      if (frames.length < 2 && widget.config.requireTimings)
        'Insufficient FrameTiming samples received',
      for (final state in videoStates)
        if (state['error'] != null) 'Video: ${state['error']}',
      for (final state in videoStates)
        if (state['position_advances'] == 0 &&
            widget.config.transitionMs >= 500)
          'Video position did not advance',
    ];
    return RunMeasurement({
      'status': errors.isEmpty ? 'passed' : 'failed',
      if (errors.isNotEmpty) 'error': errors.join('; '),
      'requested_ms': widget.config.transitionMs,
      'actual_ms': watch.elapsedMicroseconds / 1000,
      'duration_stretch':
          watch.elapsedMicroseconds / 1000 / widget.config.transitionMs,
      'max_progress_step': probe.maxStep,
      'monotonic_progress': probe.monotonic,
      'smooth_progress': probe.smooth(widget.config.transitionMs),
      'ticks': probe.ticks,
      'progress': progress,
      'videos': videoStates,
      'injected_stall_executed': stalled,
      'rss_bytes': ProcessInfo.currentRss,
      'hwm_bytes': parseKiB(await readText('/proc/self/status') ?? '')['VmHWM'],
      ...frameMetrics(frames, refresh > 0 ? refresh : 60),
    }, frames);
  }

  @override
  Future<List<String>> capture(BenchmarkCase test) async {
    final generation = _generation;
    void ensureActive() {
      if (!mounted || generation != _generation) {
        throw StateError('Capture cancelled');
      }
    }

    if (_videos.isNotEmpty ||
        test.media.name != 'photo-photo' ||
        test.injectStall ||
        test.effect?.isMosaic == true &&
            test.grid != widget.config.grids.first) {
      return [];
    }
    if (!mounted) throw StateError('Viewport detached');
    if (widget.config.visualAudit) return _audit(test);
    final pixelRatio = View.of(context).devicePixelRatio;
    final result = <String>[];
    final folder = Directory('${widget.reportDirectory.path}/captures');
    await folder.create(recursive: true);
    for (final value in [0.0, .5, 1.0]) {
      ensureActive();
      _captureLabel =
          'КОНТРОЛЬНЫЙ КАДР · ${Platform.environment['BENCHMARK_RENDERER'] ?? ''} · ${test.id} · ${(value * 100).round()}% · анимация остановлена';
      _controller.value = value;
      await _paint();
      ensureActive();
      final boundary =
          _captureKey.currentContext!.findRenderObject()!
              as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: pixelRatio);
      try {
        final data = await image.toByteData(format: ui.ImageByteFormat.png);
        final relative = 'captures/${test.id}--${(value * 100).round()}.png';
        await File('${widget.reportDirectory.path}/$relative')
            .writeAsBytes(data!.buffer.asUint8List());
        result.add(relative);
      } finally {
        image.dispose();
      }
    }
    _captureLabel = null;
    await _paint();
    return result;
  }

  Future<List<String>> _audit(BenchmarkCase test) async {
    final generation = _generation;
    final folder = Directory('${widget.reportDirectory.path}/audit');
    await folder.create(recursive: true);
    final files = <String>[];
    final originalEffect = _effect;
    final originalFrom = _from;
    Future<Uint8List> capture(String suffix) async {
      if (!mounted || generation != _generation) {
        throw StateError('Audit cancelled');
      }
      _captureLabel =
          'КОНТРОЛЬНЫЙ КАДР · ${Platform.environment['BENCHMARK_RENDERER'] ?? ''} · ${test.id} · $suffix · анимация остановлена';
      await _paint();
      if (!mounted || generation != _generation) {
        throw StateError('Audit cancelled');
      }
      final boundary =
          _captureKey.currentContext!.findRenderObject()!
              as RenderRepaintBoundary;
      final full = await boundary.toImage(
        pixelRatio: View.of(context).devicePixelRatio,
      );
      try {
        final recorder = ui.PictureRecorder();
        final canvas = Canvas(recorder);
        canvas.drawImageRect(
          full,
          Rect.fromLTWH(0, 0, full.width.toDouble(), full.height.toDouble()),
          const Rect.fromLTWH(0, 0, 320, 200),
          Paint()..filterQuality = FilterQuality.high,
        );
        final picture = recorder.endRecording();
        late ui.Image preview;
        try {
          preview = await picture.toImage(320, 200);
        } finally {
          picture.dispose();
        }
        try {
          final rgba = await preview.toByteData(
            format: ui.ImageByteFormat.rawRgba,
          );
          final png = await preview.toByteData(format: ui.ImageByteFormat.png);
          final relative = 'audit/${test.id}--$suffix.png';
          await File('${widget.reportDirectory.path}/$relative')
              .writeAsBytes(png!.buffer.asUint8List());
          files.add(relative);
          return Uint8List.fromList(rgba!.buffer.asUint8List());
        } finally {
          preview.dispose();
        }
      } finally {
        full.dispose();
      }
    }

    try {
      _effect = null;
      final from = await capture('source-A');
      _from = _to;
      final to = await capture('source-B');
      _from = originalFrom;
      _effect = originalEffect;
      final frames = <Uint8List>[];
      for (var i = 0; i <= 20; i++) {
        _controller.value = i / 20;
        frames.add(await capture('p${i.toString().padLeft(2, '0')}'));
      }
      final assessment = assessVisualFrames(
        frames,
        from,
        to,
        baseline: test.effect == null,
      );
      final relative = 'audit/${test.id}.json';
      await File('${widget.reportDirectory.path}/$relative').writeAsString(
        jsonEncode({
          'case': test.toJson(),
          'renderer': Platform.environment['BENCHMARK_RENDERER'],
          'progress': List.generate(21, (i) => i / 20),
          'files': files,
          ...assessment,
        }),
      );
      files.add(relative);
      if (assessment['status'] == 'failed') {
        throw StateError(
          'Visual audit: ${assessment['issues']}; see $relative',
        );
      }
      return files;
    } finally {
      if (generation == _generation) {
        _effect = originalEffect;
        _from = originalFrom;
        _captureLabel = null;
        if (mounted) await _paint();
      }
    }
  }

  @override
  Future<void> release() async {
    _generation++;
    _controller.stop();
    _frames = null;
    _scene = false;
    _captureLabel = null;
    _from = const SizedBox.expand();
    _to = const SizedBox.expand();
    _effect = null;
    final videos = [..._videos];
    _videos.clear();
    final images = [..._images];
    _images.clear();
    if (mounted) await _paint();
    for (final image in images) {
      image.dispose();
    }
    // Await each native teardown and record which player was being destroyed.
    Object? failure;
    StackTrace? failureStack;
    for (final video in videos) {
      final name = _videoNames.remove(video)!;
      for (final operation in <Future<void> Function()>[
        () async {
          await widget.onVideoOperation?.call('dispose', name);
        },
        video.dispose,
        () async {
          await widget.onVideoOperation?.call('disposed', name);
        },
      ]) {
        try {
          await operation();
        } catch (error, stack) {
          failure ??= error;
          failureStack ??= stack;
        }
      }
    }
    if (failure != null) {
      Error.throwWithStackTrace(failure, failureStack!);
    }
  }

  @override
  void dispose() {
    _generation++;
    SchedulerBinding.instance.removeTimingsCallback(_timings);
    _controller.dispose();
    for (final image in _images) {
      image.dispose();
    }
    for (final video in _videos) {
      unawaited(video.dispose());
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: Colors.black,
    child: _scene
        ? Stack(
            fit: StackFit.expand,
            children: [
              RepaintBoundary(
                key: _captureKey,
                child: ClipRect(
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      final size = MediaQuery.sizeOf(context);
                      return _effect?.createTransformWidget(
                            context,
                            _from,
                            _to,
                            _controller,
                            size.width,
                            size.height,
                          ) ??
                          _from;
                    },
                  ),
                ),
              ),
              if (_captureLabel != null)
                Positioned(
                  left: 0,
                  top: 0,
                  child: ColoredBox(
                    color: Colors.black87,
                    child: Text(
                      _captureLabel!,
                      style: const TextStyle(color: Colors.white, fontSize: 22),
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ),
            ],
          )
        : Center(
            child: Text(
              _status,
              textDirection: TextDirection.ltr,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
  );
}
