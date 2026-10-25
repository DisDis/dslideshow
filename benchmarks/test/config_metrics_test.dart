import 'dart:convert';
import 'dart:io';

import 'package:benchmarks/src/config.dart';
import 'package:benchmarks/src/metrics.dart';
import 'package:benchmarks/src/plan.dart';
import 'package:benchmarks/src/report.dart';
import 'package:benchmarks/src/telemetry.dart';
import 'package:dslideshow_flutter/effect.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'standard matrix covers every effect, media direction, grid and backend',
    () {
      final config = BenchmarkConfig();
      final plan = buildPlan(config);
      expect(plan.map((c) => c.id).toSet().length, plan.length);
      expect(plan.length, 486);
      expect(
        plan.map((c) => c.media.name).toSet(),
        mediaPairs.map((p) => p.name).toSet(),
      );
      expect(plan.map((c) => c.effect).toSet(), {null, ...Effect.values});
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
