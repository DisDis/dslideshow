import 'dart:async';
import 'dart:io';

import 'config.dart';
import 'driver.dart';
import 'plan.dart';
import 'report.dart';
import 'telemetry.dart';

class BenchmarkRunner {
  final BenchmarkConfig config;
  final ReportStore store;
  final LinuxTelemetry telemetry;
  final int Function() runtimeErrorCount;
  final Set<String> skipCaseIds;
  final String renderer;
  String stage = 'preflight';
  String? activeCaseId;
  bool cancelled = false;
  int _cleanupFailures = 0;
  BenchmarkRunner(
    this.config,
    this.store,
    this.telemetry, {
    int Function()? runtimeErrorCount,
    this.skipCaseIds = const {},
    this.renderer = 'unspecified',
  }) : runtimeErrorCount = runtimeErrorCount ?? (() => 0);

  Future<void> videoOperation(String operation, String file) async {
    final marker = {
      'utc': DateTime.now().toUtc().toIso8601String(),
      'case_id': activeCaseId,
      'stage': stage,
      'operation': operation,
      'file': file,
    };
    await store.flush();
    await atomicJson(
      File('${store.directory.path}/active-operation.json'),
      marker,
    );
    stdout.writeln('BENCHMARK_VIDEO $marker');
  }

  Future<int> execute(BenchmarkDriver driver) async {
    final watch = Stopwatch()..start();
    final fullPlan = buildPlan(config);
    final unsupported = fullPlan
        .where(
          (test) =>
              test.unsupportedReason != null ||
              renderer == 'vulkan' &&
                  !config.vulkanVideo &&
                  test.media.hasVideo,
        )
        .toList();
    final unsupportedIds = unsupported.map((test) => test.id).toSet();
    final plan = fullPlan
        .where(
          (test) =>
              !skipCaseIds.contains(test.id) &&
              !unsupportedIds.contains(test.id),
        )
        .toList();
    store.metadata['display'] = driver.display;
    final matches =
        driver.display['physical_width'] == config.expectedWidth &&
        driver.display['physical_height'] == config.expectedHeight;
    store.metadata['target_display_matches'] = matches;
    if (!matches) {
      store.warnings.add(
        'Разрешение вывода не совпадает с ${config.expectedWidth}×${config.expectedHeight}; '
        'нагрузка на целевом экране не подтверждена.',
      );
    }
    store.metadata['plan'] = fullPlan.map((c) => c.toJson()).toList();
    store.metadata['executed_case_ids'] = plan.map((c) => c.id).toList();
    store.metadata['skipped_case_ids'] = skipCaseIds.toList();
    store.metadata['unsupported_case_ids'] = unsupportedIds.toList();
    store.metadata['eligible_case_ids'] = fullPlan
        .where((test) => !unsupportedIds.contains(test.id))
        .map((test) => test.id)
        .toList();
    for (final test in unsupported) {
      store.record({
        'case_id': test.id,
        'case': test.toJson(),
        'phase': 'capability',
        'status': 'unsupported',
        'reason': test.unsupportedReason ?? 'Vulkan video disabled; enable vulkan_video explicitly to probe support',
      }, []);
    }
    final expectedCases = plan.length + unsupported.length;
    await store.checkpoint('running', telemetry, expectedCases: expectedCases);
    var cycle = 0;
    try {
      do {
        for (final test in plan) {
          if (cancelled ||
              cycle > 0 && watch.elapsed.inSeconds >= config.soakSeconds) {
            break;
          }
          await _case(driver, test, cycle);
          await store.checkpoint(
            'running',
            telemetry,
            expectedCases: expectedCases,
          );
        }
        cycle++;
      } while (!cancelled &&
          config.soakSeconds > 0 &&
          watch.elapsed.inSeconds < config.soakSeconds);
    } catch (error, stack) {
      store.error(error, stack);
      store.warnings.add('Прогон прерван: $error');
      cancelled = true;
    } finally {
      stage = 'finishing';
      await telemetry.stop();
      await _release(driver);
    }
    store.metadata['elapsed_seconds'] = watch.elapsedMilliseconds / 1000;
    store.metadata['cycles'] = cycle;
    store.metadata['runtime_errors'] = runtimeErrorCount();
    store.metadata['cleanup_errors'] = _cleanupFailures;
    final failed =
        store.cases.values.any((c) => c.failed > 0) ||
        runtimeErrorCount() > 0 ||
        _cleanupFailures > 0;
    final hasErrors = failed || store.errorCounts.isNotEmpty;
    await store.checkpoint(
      cancelled
          ? 'interrupted'
          : hasErrors
          ? 'completed_with_failures'
          : 'completed',
      telemetry,
      expectedCases: expectedCases,
      finalReport: true,
    );
    return cancelled
        ? 130
        : hasErrors
        ? 2
        : 0;
  }

  Future<void> _case(
    BenchmarkDriver driver,
    BenchmarkCase test,
    int cycle,
  ) async {
    activeCaseId = test.id;
    stage = 'prepare:${test.id}';
    await atomicJson(File('${store.directory.path}/active-case.json'), {
      'id': test.id,
      'cycle': cycle,
    });
    stdout.writeln('BENCHMARK_CASE ${test.id} cycle=$cycle');
    Map<String, Object?>? preparation;
    try {
      final preparationErrors = runtimeErrorCount();
      final watch = Stopwatch()..start();
      preparation = await driver
          .prepare(test)
          .timeout(Duration(seconds: config.prepareTimeoutSeconds));
      preparation['total_ms'] = watch.elapsedMicroseconds / 1000;
      store.metadata['video_texture_probes'] =
          preparation['video_texture_probes'];
      if (runtimeErrorCount() > preparationErrors) {
        throw StateError(
          'Asynchronous media preparation error (see errors.jsonl)',
        );
      }
      if (cancelled) return;
      final warmups = cycle == 0 ? config.warmups : 0;
      for (var i = -warmups; i < config.repeats; i++) {
        if (cancelled) break;
        final phase = i < 0 ? 'warmup' : 'measured';
        stage = '$phase:${test.id}:$i';
        final errorsBefore = runtimeErrorCount();
        final result = await driver
            .run(test)
            .timeout(
              Duration(
                seconds:
                    config.transitionTimeoutSeconds +
                    (config.timingDrainMs / 1000).ceil() +
                    15,
              ),
            );
        final values = result.values;
        if (runtimeErrorCount() > errorsBefore) {
          values['status'] = 'failed';
          values['error'] =
              '${values['error'] ?? ''}; asynchronous Flutter/engine error (see errors.jsonl)';
        }
        final row = <String, Object?>{
          'utc': DateTime.now().toUtc().toIso8601String(),
          'case_id': test.id,
          'case': test.toJson(),
          'cycle': cycle,
          'phase': phase,
          'repeat': i,
          'preparation': preparation,
          ...values,
        };
        store.record(
          row,
          result.frames.map(
            (frame) => {
              'case_id': test.id,
              'cycle': cycle,
              'phase': phase,
              'repeat': i,
              ...frame.toJson(),
            },
          ),
        );
        await store.flush();
      }
      if (config.captureFrames && cycle == 0 && !cancelled) {
        stage = 'capture:${test.id}';
        try {
          final captures = await driver
              .capture(test)
              .timeout(const Duration(seconds: 60));
          if (captures.isNotEmpty) {
            final index = store.metadata.putIfAbsent(
              'captures',
              () => <String, Object?>{},
            ) as Map;
            index[test.id] = captures;
          }
        } catch (error, stack) {
          store.error(
            error,
            stack,
            caseId: test.id,
            stage: stage,
            kind: 'capture',
          );
          store.warnings.add(
            'Не удалось снять контрольные кадры ${test.id}: $error',
          );
        }
      }
    } catch (error, stack) {
      store.error(error, stack, caseId: test.id, stage: stage);
      store.record({
        'case_id': test.id,
        'case': test.toJson(),
        'cycle': cycle,
        'phase': 'measured',
        'repeat': null,
        'status': 'failed',
        'error': '$error',
        'failed_stage': stage,
        'preparation': preparation,
        'rss_bytes': ProcessInfo.currentRss,
      }, []);
    } finally {
      // Native player destruction can abort the process. Save all measurements
      // before releasing its resources so the launcher can resume the matrix.
      await store.checkpoint(
        'running',
        telemetry,
        expectedCases:
            (store.metadata['executed_case_ids'] as List).length +
            (store.metadata['unsupported_case_ids'] as List).length,
      );
      await _release(driver, test: test, cycle: cycle);
    }
  }

  Future<void> _release(
    BenchmarkDriver driver, {
    BenchmarkCase? test,
    int? cycle,
  }) async {
    try {
      stage = 'cleanup:${test?.id ?? 'final'}';
      await driver.release().timeout(const Duration(seconds: 10));
    } catch (error, stack) {
      _cleanupFailures++;
      store.error(
        error,
        stack,
        caseId: test?.id ?? activeCaseId,
        stage: stage,
        kind: 'cleanup',
      );
    }
  }
}
