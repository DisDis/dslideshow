import 'package:benchmarks/src/effect_variants.dart';

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:benchmarks/src/config.dart';
import 'package:benchmarks/src/metrics.dart';
import 'package:benchmarks/src/plan.dart';
import 'package:benchmarks/src/report.dart';
import 'package:benchmarks/src/telemetry.dart';
import 'package:benchmarks/src/visual_audit.dart';
import 'package:dslideshow_flutter/effect.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Freezed benchmark configuration keeps independent immutable variants',
    () {
      final variants = [const EffectConfig()];
      final source = {EffectType.fade: variants};
      final config = BenchmarkConfig(suite: 'smoke', effectConfigs: source);
      source.clear();
      variants.clear();
      expect(config.effectConfigs, hasLength(1));
      expect(config.effectConfigs![EffectType.fade], hasLength(1));
      expect(
        () => config.effectConfigs![EffectType.fade]!.clear(),
        throwsUnsupportedError,
      );
      expect(() => config.effectConfigs!.clear(), throwsUnsupportedError);
      expect(() => config.grids.clear(), throwsUnsupportedError);
      final changed = config.copyWith(transitionMs: 1500);
      expect(config.transitionMs, 1000);
      expect(changed.transitionMs, 1500);
      expect(changed, BenchmarkConfig.fromJson(changed.toJson()));
    },
  );

  test('bundled configurations retain their grouped effect variants', () {
    var checked = 0;
    for (final file in Directory('config').listSync().whereType<File>()) {
      if (!file.path.endsWith('.json')) continue;
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      if (!json.containsKey('effect_configs')) continue;
      final config = BenchmarkConfig.fromJson(json);
      expect(config.effectConfigs!.keys, [
        EffectType.mosaic,
      ], reason: file.path);
      expect(
        config.effectConfigs![EffectType.mosaic],
        hasLength(2),
        reason: file.path,
      );
      expect(buildPlan(config), isNotEmpty, reason: file.path);
      expect(BenchmarkConfig.fromJson(config.toJson()), config);
      checked++;
    }
    expect(checked, 6);
  });

  test(
    'explicit typed variants retain independent IDs and effective duration',
    () {
      final config = BenchmarkConfig.fromJson({
        'suite': 'smoke',
        'media_cases': ['photo-photo'],
        'grids': [100],
        'backends': ['canvas'],
        'transition_ms': 900,
        'effect_configs': {
          'mosaic': [
            {
              'options': {'durationMs': 0, 'fadeFraction': 0},
            },
            {
              'options': {'durationMs': 1400, 'fadeFraction': .3},
            },
          ],
        },
      });
      final plan = buildPlan(config);
      expect(plan.length, 2);
      expect(plan.map((c) => c.id).toSet().length, 2);
      expect(plan.map((c) => c.durationMs(config)), [900, 1400]);
      final gridCase = BenchmarkCase(
        Effect.mosaicEffect,
        mediaPairs.first,
        grid: 200,
      );
      expect(
        (gridCase.toJson()['effect_config']
            as Map)['mosaic']['options']['gridSize'],
        200,
      );
      expect(
        () => buildPlan(
          BenchmarkConfig(
            effectConfigs: {
              EffectType.fade: [const EffectConfig(), const EffectConfig()],
            },
          ),
        ),
        throwsArgumentError,
      );

      expect(
        (plan.last.toJson()['effect_config']
            as Map)['mosaic']['options']['durationMs'],
        1400,
      );
      expect(
        BenchmarkConfig.fromJson(config.toJson())
            .effectConfigs![EffectType.mosaic]!
            .last
            .options
            .durationMs,
        1400,
      );
    },
  );

  test('visual audit distinguishes motion, two discrete frames and unavailable readback', () {
    final from = Uint8List.fromList([255, 0, 0, 255]),
        to = Uint8List.fromList([0, 0, 255, 255]);
    final frames = List.generate(
      21,
      (i) => Uint8List.fromList([
        (255 * (1 - i / 20)).round(),
        0,
        (255 * i / 20).round(),
        255,
      ]),
    );
    expect(assessVisualFrames(frames, from, to)['status'], 'passed');
    expect(
      assessVisualFrames(
        [...List.filled(10, from), ...List.filled(11, to)],
        from,
        to,
      )['status'],
      'failed',
    );
    final blank = Uint8List(4);
    expect(
      assessVisualFrames(List.filled(21, blank), blank, blank)['status'],
      'unverified_capture',
    );
  });
  test(
    'JSONL writes during overlapping flushes are retained and errors counted',
    () async {
      final directory = await Directory.systemTemp.createTemp('report-writes-');
      final store = ReportStore(directory);
      await store.open();
      try {
        final flushes = <Future<void>>[];
        for (var i = 0; i < 400; i++) {
          store.telemetry({'sample': i});
          if (i % 10 == 0) {
            flushes.add(store.flush());
            store.error(
              StateError('late event $i'),
              StackTrace.current,
              caseId: 'Cube--video-video',
              stage: 'cleanup',
              kind: 'runtime',
            );
          }
          await Future<void>.delayed(Duration.zero);
        }
        await Future.wait(flushes);
        final summary = await store.checkpoint(
          'completed_with_failures',
          LinuxTelemetry(onSample: store.telemetry, stage: () => 'test'),
        );
        final samples = await File('${directory.path}/telemetry.jsonl')
            .readAsLines();
        expect(
          samples.map((line) => jsonDecode(line)['sample']),
          List.generate(400, (i) => i),
        );
        expect(summary['error_counts'], {'runtime': 40});
        expect(summary['error_events'], 40);
        expect(
          (await File('${directory.path}/errors.jsonl').readAsLines()).length,
          40,
        );
      } finally {
        await store.close();
        await directory.delete(recursive: true);
      }
    },
  );

  test(
    'Vulkan video defaults off and accepts explicit JSON/environment opt-in',
    () async {
      expect(BenchmarkConfig().vulkanVideo, isFalse);
      expect(
        BenchmarkConfig.fromJson({'vulkan_video': true}).vulkanVideo,
        isTrue,
      );
      expect(
        (await BenchmarkConfig.load({'BENCHMARK_VULKAN_VIDEO': 'true'}))
            .vulkanVideo,
        isTrue,
      );
      await expectLater(
        BenchmarkConfig.load({'BENCHMARK_VULKAN_VIDEO': 'maybe'}),
        throwsFormatException,
      );
    },
  );

  test(
    'a 60Hz Flutter clock on a 50Hz display has no missed-vsync estimate',
    () {
      final measured = frameMetrics([
        const FrameSample(1000, 100, 200, 300),
        const FrameSample(17667, 100, 200, 300),
        const FrameSample(51000, 100, 200, 300),
      ], 50);
      expect(measured['vsync_clock_matches_display'], isFalse);
      expect(measured['estimated_missed_vsyncs'], isNull);
      expect(measured['sampled_fps'], closeTo(40, .001));
    },
  );
  test(
    'standard matrix covers every effect, media direction, grid and backend',
    () {
      final config = BenchmarkConfig();
      final plan = buildPlan(config);
      expect(plan.map((c) => c.id).toSet().length, plan.length);
      expect(plan.length, 684);
      expect(
        plan.map((c) => c.media.name).toSet(),
        mediaPairs.map((p) => p.name).toSet(),
      );
      expect(plan.map((c) => c.effect).toSet(), {null, ...benchmarkEffects});
      for (final effect in Effect.values) {
        for (final pair in mediaPairs.where((p) => p.name != 'large-photo')) {
          expect(
            plan.any(
              (c) => c.effect?.type == effect.type && c.media.name == pair.name,
            ),
            isTrue,
            reason: '${effect.name} must cover ${pair.name}',
          );
        }
      }
      for (final grid in [100, 150, 200]) {
        for (final backend in MosaicBackend.values) {
          expect(
            plan.any(
              (c) =>
                  c.grid == grid &&
                  c.backend == backend &&
                  c.effect?.isMosaic == true,
            ),
            isTrue,
          );
        }
      }
      expect(plan.where((c) => c.injectStall).length, 3);
      final smoke = buildPlan(BenchmarkConfig(suite: 'smoke'));
      expect(smoke.any((c) => c.media.name == 'video-video'), isTrue);
      expect(smoke.any((c) => c.media.name == 'large-photo'), isTrue);
      expect(smoke.any((c) => c.media.name == 'photo-gif'), isTrue);
    },
  );

  test(
    'configuration rejects silent typos, unknown names and reduced grids',
    () {
      expect(
        () => BenchmarkConfig.fromJson({'repeat': 2}),
        throwsFormatException,
      );
      expect(() => BenchmarkConfig(grids: [99]), throwsArgumentError);
      expect(
        () => buildPlan(BenchmarkConfig(effects: ['Typo'])),
        throwsArgumentError,
      );
      expect(
        () => buildPlan(BenchmarkConfig(mediaCases: ['Typo'])),
        throwsArgumentError,
      );
      expect(() => BenchmarkConfig(timingDrainMs: 100), throwsArgumentError);
      final config = BenchmarkConfig.fromJson(
        BenchmarkConfig().toJson().cast<String, dynamic>(),
      );
      expect(config.expectedWidth, 2560);
      expect(config.expectedHeight, 1600);
    },
  );

  test(
    'missing timings remain null; frame spacing and percentiles are measured',
    () {
      final empty = frameMetrics([], 60);
      expect((empty['raster_ms'] as Map)['p95'], isNull);
      expect(empty['sampled_fps'], isNull);
      final measured = frameMetrics([
        const FrameSample(1000, 1000, 2000, 5000),
        const FrameSample(17667, 2000, 8000, 12000),
        const FrameSample(51000, 3000, 20000, 25000),
      ], 60);
      expect((measured['raster_ms'] as Map)['p95'], closeTo(18.8, .001));
      expect(measured['estimated_missed_vsyncs'], 1);
      expect(measured['sampled_fps'], closeTo(40, .001));
      expect(measured['slow_raster_frames'], 1);
    },
  );

  test('fixed progress can be slow but must remain monotonic and bounded', () {
    final smooth = ProgressProbe();
    for (var i = 0; i <= 100; i++) {
      smooth.add(i / 100);
    }
    expect(smooth.smooth(1000), isTrue);
    smooth.add(.8);
    expect(smooth.smooth(1000), isFalse);
    final jump = ProgressProbe()..add(.2);
    expect(jump.smooth(1000), isFalse);
  });

  test('proc parsers handle spaces and parentheses in process names', () {
    expect(
      processTicks('12 (a weird (name)) S 1 2 3 4 5 6 7 8 9 10 20 30 0'),
      50,
    );
    expect(processTicks('unavailable'), isNull);
    expect(
      parseKiB('VmRSS:\t123 kB\nVmHWM: 456 kB\nThreads: 8')['VmRSS'],
      123 * 1024,
    );
    expect(cpuTicks('cpu 10 20 30 40 50 60 70 80 100 200\ncpu0 1 2'), (
      total: 360,
      idle: 90,
    ));
  });

  test('failed preparation does not manufacture zero performance metrics', () {
    final aggregate = CaseAggregate({'id': 'failed'});
    aggregate.add({'status': 'failed', 'error': 'timeout'});
    expect(aggregate.toJson()['actual_mean_ms'], isNull);
    expect(aggregate.toJson()['raster_p95_mean_ms'], isNull);
    expect(aggregate.toJson()['max_progress_step'], isNull);
    expect(csvCell('a,"b"\nc'), '"a,""b""\nc"');
    expect(html('<script>'), '&lt;script&gt;');
  });

  test('bundled JPEGs retain phone/camera original dimensions', () {
    final json = jsonDecode(
      File('assets/media/manifest.json').readAsStringSync(),
    ) as Map;
    final files = (json['files'] as List).cast<Map>();
    for (final size in [(4032, 3024), (6000, 4000), (8000, 6000)]) {
      expect(
        files.any((f) => f['width'] == size.$1 && f['height'] == size.$2),
        isTrue,
      );
    }
  });
}
