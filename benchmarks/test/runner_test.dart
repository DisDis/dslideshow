import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:benchmarks/src/config.dart';
import 'package:benchmarks/src/driver.dart';
import 'package:benchmarks/src/plan.dart';
import 'package:benchmarks/src/report.dart';
import 'package:benchmarks/src/runner.dart';
import 'package:benchmarks/src/telemetry.dart';
import 'package:flutter_test/flutter_test.dart';

class FailingDriver implements BenchmarkDriver {
  int preparations = 0, releases = 0, runs = 0;
  bool failFirst = true;
  @override
  Map<String, Object?> get display => {
    'physical_width': 2560.0,
    'physical_height': 1600.0,
  };
  @override
  Future<Map<String, Object?>> prepare(BenchmarkCase test) async {
    preparations++;
    if (failFirst && preparations == 1) throw StateError('decoder failure');
    return {'media': [], 'decoder_count': 0};
  }

  @override
  Future<RunMeasurement> run(BenchmarkCase test) async {
    runs++;
    return RunMeasurement({
      'status': 'passed',
      'actual_ms': 2300.0,
      'duration_stretch': 2.3,
      'max_progress_step': .01,
      'frames': 100,
    }, []);
  }

  @override
  Future<List<String>> capture(BenchmarkCase test) async => [];
  @override
  Future<void> release() async {
    releases++;
  }
}

class HangingDriver extends FailingDriver {
  @override
  Future<Map<String, Object?>> prepare(BenchmarkCase test) {
    preparations++;
    if (preparations == 1) return Completer<Map<String, Object?>>().future;
    return Future.value({'media': []});
  }
}

class RuntimeErrorOnReleaseDriver extends FailingDriver {
  final ReportStore store;
  bool reported = false;
  RuntimeErrorOnReleaseDriver(this.store) {
    failFirst = false;
  }
  @override
  Future<void> release() async {
    await super.release();
    if (!reported) {
      reported = true;
      store.error(
        StateError('late cancel'),
        StackTrace.current,
        caseId: 'Baseline--photo-photo',
        stage: 'cleanup',
        kind: 'runtime',
      );
    }
  }
}

void main() {
  test('late cleanup runtime error fails acceptance without inventing a failed measurement', () async {
    final directory = await Directory.systemTemp.createTemp('late-runtime-');
    final store = ReportStore(directory);
    await store.open();
    try {
      final runner = BenchmarkRunner(
        BenchmarkConfig(
          effects: ['Baseline'],
          mediaCases: ['photo-photo'],
          warmups: 0,
          repeats: 1,
          captureFrames: false,
        ),
        store,
        LinuxTelemetry(onSample: store.telemetry, stage: () => 'test'),
      );
      expect(await runner.execute(RuntimeErrorOnReleaseDriver(store)), 2);
      final summary = jsonDecode(
        await File('${directory.path}/summary.json').readAsString(),
      ) as Map;
      expect(summary['failed_runs'], 0);
      expect(summary['error_counts'], {'runtime': 1});
      expect((summary['cases'] as List).single['has_errors'], true);
      expect(summary['status'], 'completed_with_failures');
    } finally {
      await store.close();
      await directory.delete(recursive: true);
    }
  });
  test(
    'Vulkan video is unsupported before preparation, and can be enabled',
    () async {
      for (final enabled in [false, true]) {
        final directory = await Directory.systemTemp.createTemp(
          'vulkan-policy-',
        );
        final store = ReportStore(directory);
        await store.open();
        try {
          final driver = FailingDriver()..failFirst = false;
          final runner = BenchmarkRunner(
            BenchmarkConfig(
              effects: ['Baseline'],
              mediaCases: ['video-video'],
              warmups: 0,
              repeats: 1,
              captureFrames: false,
              vulkanVideo: enabled,
            ),
            store,
            LinuxTelemetry(onSample: store.telemetry, stage: () => 'test'),
            renderer: 'vulkan',
          );
          expect(await runner.execute(driver), 0);
          expect(driver.preparations, enabled ? 1 : 0);
          expect(driver.runs, enabled ? 1 : 0);
          final summary = jsonDecode(
            await File('${directory.path}/summary.json').readAsString(),
          ) as Map;
          expect(summary['unsupported_cases'], enabled ? 0 : 1);
          expect(summary['failed_runs'], 0);
          expect(summary['measured_runs'], enabled ? 1 : 0);
          expect(
            (summary['cases'] as List).single['status'],
            enabled ? null : 'unsupported',
          );
        } finally {
          await store.close();
          await directory.delete(recursive: true);
        }
      }
    },
  );
  test(
    'resume excludes previous cases while retaining the original plan',
    () async {
      final directory = await Directory.systemTemp.createTemp(
        'benchmark-resume-',
      );
      final store = ReportStore(directory);
      await store.open();
      try {
        final telemetry = LinuxTelemetry(
          onSample: store.telemetry,
          stage: () => 'test',
        );
        final driver = FailingDriver()..failFirst = false;
        final runner = BenchmarkRunner(
          BenchmarkConfig(
            effects: ['Cube', 'Depth'],
            mediaCases: ['photo-photo'],
            warmups: 0,
            repeats: 1,
            captureFrames: false,
          ),
          store,
          telemetry,
          skipCaseIds: {'Cube--photo-photo'},
        );
        expect(await runner.execute(driver), 0);
        expect(driver.preparations, 1);
        expect(store.cases.keys, ['Depth--photo-photo']);
        expect((store.metadata['plan'] as List).length, 2);
        expect(store.metadata['executed_case_ids'], ['Depth--photo-photo']);
      } finally {
        await store.close();
        await directory.delete(recursive: true);
      }
    },
  );
  test(
    'a stalled preparation times out and the next case still runs',
    () async {
      final directory = await Directory.systemTemp.createTemp(
        'benchmark-timeout-',
      );
      final store = ReportStore(directory);
      await store.open();
      try {
        final telemetry = LinuxTelemetry(
          onSample: store.telemetry,
          stage: () => 'test',
        );
        final driver = HangingDriver();
        final runner = BenchmarkRunner(
          BenchmarkConfig(
            effects: ['Cube', 'Depth'],
            mediaCases: ['photo-photo'],
            prepareTimeoutSeconds: 1,
            repeats: 1,
            warmups: 0,
            captureFrames: false,
          ),
          store,
          telemetry,
        );
        expect(await runner.execute(driver), 2);
        expect(driver.preparations, 2);
        expect(driver.runs, 1);
        expect(
          store.cases.values.first.errors.single,
          contains('TimeoutException'),
        );
      } finally {
        await store.close();
        await directory.delete(recursive: true);
      }
    },
  );
  test(
    'runner continues after a decoder error and writes complete reports',
    () async {
      final directory = await Directory.systemTemp.createTemp(
        'benchmark-runner-',
      );
      final store = ReportStore(directory);
      await store.open();
      try {
        final config = BenchmarkConfig(
          effects: ['Cube', 'Depth'],
          mediaCases: ['photo-photo'],
          repeats: 2,
          warmups: 1,
          captureFrames: false,
        );
        final telemetry = LinuxTelemetry(
          onSample: store.telemetry,
          stage: () => 'test',
        );
        final driver = FailingDriver();
        final result = await BenchmarkRunner(
          config,
          store,
          telemetry,
        ).execute(driver);
        expect(result, 2);
        expect(driver.preparations, 2);
        expect(driver.runs, 3);
        expect(driver.releases, greaterThanOrEqualTo(3));
        final summary = jsonDecode(
          await File('${directory.path}/summary.json').readAsString(),
        ) as Map;
        expect(summary['status'], 'completed_with_failures');
        expect(summary['observed_cases'], 2);
        expect(summary['failed_runs'], 1);
        expect(summary['warmup_runs'], 1);
        expect(summary['measured_runs'], 3);
        expect((summary['metadata'] as Map)['target_display_matches'], isTrue);
        expect(await File('${directory.path}/report.html').exists(), isTrue);
        expect(await File('${directory.path}/summary.csv').exists(), isTrue);
        final raw = await File('${directory.path}/runs.jsonl').readAsLines();
        expect(raw.length, 4);
        expect(jsonDecode(raw.last)['actual_ms'], 2300);
      } finally {
        await store.close();
        await directory.delete(recursive: true);
      }
    },
  );

  test(
    'cancelled runner preserves partial results and releases resources',
    () async {
      final directory = await Directory.systemTemp.createTemp(
        'benchmark-cancel-',
      );
      final store = ReportStore(directory);
      await store.open();
      try {
        final telemetry = LinuxTelemetry(
          onSample: store.telemetry,
          stage: () => 'test',
        );
        final driver = FailingDriver()..failFirst = false;
        final runner = BenchmarkRunner(
          BenchmarkConfig(effects: ['Depth'], mediaCases: ['photo-photo']),
          store,
          telemetry,
        )..cancelled = true;
        expect(await runner.execute(driver), 130);
        expect(driver.runs, 0);
        final summary = jsonDecode(
          await File('${directory.path}/summary.json').readAsString(),
        ) as Map;
        expect(summary['status'], 'interrupted');
        expect(driver.releases, greaterThan(0));
      } finally {
        await store.close();
        await directory.delete(recursive: true);
      }
    },
  );
}
