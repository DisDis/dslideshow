import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:benchmarks/src/egl_backbuffer_capture.dart';
import 'package:flutter_test/flutter_test.dart';

const _pixels = <int>[
  255,
  0,
  0,
  255,
  0,
  255,
  0,
  255,
  0,
  0,
  255,
  255,
  40,
  80,
  120,
  255,
];

/// A fake native swap endpoint driven only through its documented files.
class _NativePeer {
  final Directory directory;
  final requests = <(int, bool)>[];
  int swaps = 0;
  _NativePeer(this.directory);

  Future<void> swap({
    List<int> pixels = _pixels,
    void Function(Map<String, Object?>)? changeAck,
  }) async {
    final request = File('${directory.path}/request');
    final fields = (await request.readAsString()).trim().split(' ');
    final id = int.parse(fields.first);
    final barrier = fields.length == 2 && fields.last == 'barrier';
    requests.add((id, barrier));
    final active = await request.rename('${directory.path}/request.active');
    if (!barrier) {
      await File('${directory.path}/frame-$id.rgba').writeAsBytes(pixels);
    }
    final ack = <String, Object?>{
      'schema_version': 1,
      'request_id': id,
      'kind': barrier ? 'barrier' : 'capture',
      'swap_index': ++swaps,
      'status': 'ok',
      'file': barrier ? null : 'frame-$id.rgba',
      'width': 2,
      'height': 2,
      'stride': 8,
      'bytes': barrier ? 0 : 16,
      'format': 'RGBA8888',
      'row_order': 'top_to_bottom',
      'origin': 'top-left',
      'framebuffer': 0,
      'read_framebuffer': 0,
      'gl_error': 0,
      'swap_success': true,
      'source': 'egl_backbuffer_before_swap',
      'error': null,
    };
    changeAck?.call(ack);
    await active.delete();
    final temporary = File('${directory.path}/ack.tmp');
    await temporary.writeAsString(jsonEncode(ack));
    await temporary.rename('${directory.path}/ack.json');
  }
}

Map<String, Object?> _provenance() => {
  'schema_version': 1,
  'kind': 'egl_backbuffer_capture',
  'timing_results_valid': false,
  for (final component in ['real_runtime', 'interposer', 'wrapper'])
    component: {
      'path': '/runtime/$component',
      'sha256': List.filled(64, 'a').join(),
    },
  'engine_library': {
    'path': '/runtime/engine.so',
    'sha256': List.filled(64, 'b').join(),
  },
};

Map<String, Object?> _loadedRuntime() => {
  'schema_version': 1,
  'kind': 'egl_capture_loaded_runtime',
  'pid': pid,
  'engine': {
    'path': '/runtime/libflutter_engine.so',
    'sha256': List.filled(64, 'c').join(),
  },
  'effective_ld_library_path': '/bundle/lib:/runtime',
};

void main() {
  late Directory directory;
  late EglBackbufferCapture client;
  late _NativePeer native;
  setUp(() {
    directory = Directory.systemTemp.createTempSync('egl-capture-client-');
    client = EglBackbufferCapture(
      directory: directory,
      width: 2,
      height: 2,
      timeout: const Duration(seconds: 2),
      pollInterval: const Duration(milliseconds: 2),
    );
    native = _NativePeer(directory);
  });
  tearDown(() => directory.deleteSync(recursive: true));

  test(
    'backend defaults to snapshots and rejects unknown environment values',
    () {
      expect(PixelCaptureBackend.parse(null), PixelCaptureBackend.toImage);
      for (final backend in PixelCaptureBackend.values) {
        expect(PixelCaptureBackend.parse(backend.name), backend);
      }
      expect(() => PixelCaptureBackend.parse('unknown'), throwsFormatException);
    },
  );

  test(
    'warming approaches both endpoints through three distinct valid phases',
    () {
      expect(eglCaptureWarmProgress(0), [.03, .02, .01]);
      for (final target in [1.0, .25, .02, .005, 1e-16]) {
        final phases = eglCaptureWarmProgress(target);
        expect(phases, hasLength(3));
        expect(phases.toSet(), hasLength(3));
        expect(phases, everyElement(inInclusiveRange(0, 1)));
        expect(phases, everyElement(lessThan(target)));
        expect(phases[0], lessThan(phases[1]));
        expect(phases[1], lessThan(phases[2]));
        expect(() => phases.add(target), throwsUnsupportedError);
      }
      for (final (target, expected) in [
        (1.0, [.97, .98, .99]),
        (.25, [.22, .23, .24]),
        (.015, [0.0, .005, .01]),
      ]) {
        final phases = eglCaptureWarmProgress(target);
        for (var index = 0; index < phases.length; index++) {
          expect(phases[index], closeTo(expected[index], 1e-14));
        }
      }
      for (final invalid in [-.01, 1.01, double.nan, double.infinity]) {
        expect(() => eglCaptureWarmProgress(invalid), throwsRangeError);
      }
    },
  );

  test('raster fence ignores stale and newer timings until its exact frame arrives', () async {
    final frames = StreamController<int>(sync: true);
    final submitted = Completer<int>();
    var completed = false;
    final fence =
        waitForRasterizedFrame(
          rasterizedFrameNumbers: frames.stream,
          submitFrame: () {
            expect(frames.hasListener, isTrue);
            frames.add(10);
            return submitted.future;
          },
        ).then((number) {
          completed = true;
          return number;
        });
    submitted.complete(11);
    await Future<void>.delayed(Duration.zero);
    frames.add(12);
    await Future<void>.delayed(Duration.zero);
    expect(completed, isFalse);
    frames.add(11);
    expect(await fence, 11);
    expect(frames.hasListener, isFalse);
    await frames.close();
  });

  test(
    'raster fence accepts timing batched before submission returns its number',
    () async {
      final frames = StreamController<int>(sync: true);
      expect(
        await waitForRasterizedFrame(
          rasterizedFrameNumbers: frames.stream,
          submitFrame: () async {
            frames.add(20);
            frames.add(21);
            return 21;
          },
        ),
        21,
      );
      expect(frames.hasListener, isFalse);
      await frames.close();
    },
  );

  test('raster fence timeout removes its timing subscription', () async {
    final frames = StreamController<int>(sync: true);
    await expectLater(
      waitForRasterizedFrame(
        rasterizedFrameNumbers: frames.stream,
        submitFrame: () async => 42,
        timeout: const Duration(milliseconds: 20),
      ),
      throwsA(isA<TimeoutException>()),
    );
    expect(frames.hasListener, isFalse);
    await frames.close();
  });

  test('raster fence also bounds a submission that never completes', () async {
    final frames = StreamController<int>(sync: true);
    await expectLater(
      waitForRasterizedFrame(
        rasterizedFrameNumbers: frames.stream,
        submitFrame: () => Completer<int>().future,
        timeout: const Duration(milliseconds: 20),
      ),
      throwsA(isA<TimeoutException>()),
    );
    expect(frames.hasListener, isFalse);
    await frames.close();
  });

  test(
    'raster fence preserves timing errors and releases the subscription',
    () async {
      final frames = StreamController<int>(sync: true);
      final failure = StateError('timings unavailable');
      await expectLater(
        waitForRasterizedFrame(
          rasterizedFrameNumbers: frames.stream,
          submitFrame: () async {
            frames.addError(failure, StackTrace.current);
            return 42;
          },
        ),
        throwsA(same(failure)),
      );
      expect(frames.hasListener, isFalse);
      await frames.close();
    },
  );

  test('provenance preserves actual runtime, interposer and additional engine identity', () async {
    final expected = _provenance();
    await File('${directory.path}/runtime-provenance.json')
        .writeAsString(jsonEncode(expected));
    final actual = await loadEglCaptureProvenance(directory);
    expect(actual, expected);
    expect(() => actual['timing_results_valid'] = true, throwsUnsupportedError);
  });

  test('provenance rejects missing digests and claims that captures are valid timings', () async {
    final file = File('${directory.path}/runtime-provenance.json');
    final changes = <void Function(Map<String, Object?>)>[
      (value) => value.remove('real_runtime'),
      (value) => (value['interposer']! as Map)['sha256'] = 'incomplete',
      (value) => (value['wrapper']! as Map)['path'] = '',
      (value) => value['timing_results_valid'] = true,
      (value) => value['schema_version'] = 2,
    ];
    for (final change in changes) {
      final value = _provenance();
      change(value);
      await file.writeAsString(jsonEncode(value));
      await expectLater(
        loadEglCaptureProvenance(directory),
        throwsFormatException,
      );
    }
  });

  test('missing wrapper provenance is an explicit startup error', () async {
    await expectLater(
      loadEglCaptureProvenance(directory),
      throwsA(isA<FileSystemException>()),
    );
  });

  test(
    'loaded runtime records this process and the actual mapped engine',
    () async {
      final file = File('${directory.path}/capture-runtime.json');
      for (final searchPath in ['/bundle/lib:/runtime', null]) {
        final expected = _loadedRuntime()
          ..['effective_ld_library_path'] = searchPath;
        await file.writeAsString(jsonEncode(expected));
        final actual = await loadEglCaptureLoadedRuntime(directory);
        expect(actual, expected);
        expect(() => actual['pid'] = 1, throwsUnsupportedError);
      }
    },
  );

  test(
    'loaded runtime rejects stale process identity and missing engine hashes',
    () async {
      final file = File('${directory.path}/capture-runtime.json');
      final changes = <void Function(Map<String, Object?>)>[
        (value) => value['schema_version'] = 2,
        (value) => value['kind'] = 'egl_backbuffer_capture',
        (value) => value['pid'] = pid + 1,
        (value) => value.remove('engine'),
        (value) => (value['engine']! as Map)['path'] = '',
        (value) => (value['engine']! as Map)['sha256'] = 'incomplete',
        (value) => value.remove('effective_ld_library_path'),
        (value) => value['effective_ld_library_path'] = [],
      ];
      for (final change in changes) {
        final value = _loadedRuntime();
        change(value);
        await file.writeAsString(jsonEncode(value));
        await expectLater(
          loadEglCaptureLoadedRuntime(directory),
          throwsFormatException,
        );
      }
    },
  );

  test('an absent loaded-engine sidecar prevents accepting captures', () async {
    await expectLater(
      loadEglCaptureLoadedRuntime(directory),
      throwsA(isA<FileSystemException>()),
    );
  });

  test(
    'captures original RGBA bytes and removes consumed protocol files',
    () async {
      final rgba = await client.capture(requestFrame: native.swap);
      expect(rgba, isA<Uint8List>());
      expect(rgba, orderedEquals(_pixels));
      expect(directory.listSync(), isEmpty);
      expect(client.failed, isFalse);
      expect(client.lastAcknowledgement!['kind'], 'capture');
      expect(client.lastAcknowledgement!['swap_index'], 1);
      expect(
        () => client.lastAcknowledgement!['status'] = 'changed',
        throwsUnsupportedError,
      );
    },
  );

  test(
    'three swap barriers precede a single capture without barrier payloads',
    () async {
      for (var frame = 0; frame < 3; frame++) {
        await client.barrier(requestFrame: native.swap);
        expect(directory.listSync(), isEmpty);
      }
      expect(
        await client.capture(requestFrame: native.swap),
        orderedEquals(_pixels),
      );
      expect(native.requests.map((request) => request.$2), [
        true,
        true,
        true,
        false,
      ]);
      final ids = native.requests.map((request) => request.$1).toList();
      expect(ids.first, greaterThan(0));
      for (var index = 1; index < ids.length; index++) {
        expect(ids[index], ids[index - 1] + 1);
      }
      expect(client.lastAcknowledgement!['swap_index'], 4);
    },
  );

  test(
    'ignores a stale acknowledgement until the requested swap completes',
    () async {
      await File('${directory.path}/ack.json')
          .writeAsString('{"request_id":42}');
      Future<void>? swap;
      final rgba = await client.capture(
        requestFrame: () {
          swap = Future<void>.delayed(
            const Duration(milliseconds: 25),
            native.swap,
          );
        },
      );
      await swap;
      expect(rgba, orderedEquals(_pixels));
      expect(client.failed, isFalse);
    },
  );

  test(
    'native errors abort the session and never return missing pixels as zeros',
    () async {
      await expectLater(
        client.capture(
          requestFrame: () => native.swap(
            changeAck: (ack) {
              ack['status'] = 'error';
              ack['error'] = 'real eglSwapBuffers failed';
            },
          ),
        ),
        throwsA(
          isA<StateError>().having(
            (error) => error.message,
            'message',
            contains('eglSwapBuffers failed'),
          ),
        ),
      );
      expect(client.failed, isTrue);
      expect(directory.listSync().map((file) => file.path), [
        '${directory.path}/ack.json',
      ]);
      await expectLater(client.barrier(requestFrame: () {}), throwsStateError);
    },
  );

  test('rejects incompatible dimensions, channel layout, framebuffer and unsafe filenames', () async {
    final changes = <Map<String, Object?>>[
      {'schema_version': 2},
      {'kind': 'barrier'},
      {'width': 3},
      {'height': 1},
      {'stride': 12},
      {'bytes': 15},
      {'format': 'BGRA8888'},
      {'row_order': 'bottom_to_top'},
      {'origin': 'bottom-left'},
      {'framebuffer': 1},
      {'read_framebuffer': 1},
      {'gl_error': 1282},
      {'swap_success': false},
      {'source': 'snapshot'},
      {'file': '../outside.rgba'},
      {'swap_index': 0},
      {'error': 'contradictory ok'},
    ];
    for (var index = 0; index < changes.length; index++) {
      final path = Directory('${directory.path}/$index')..createSync();
      final peer = _NativePeer(path);
      final capture = EglBackbufferCapture(
        directory: path,
        width: 2,
        height: 2,
      );
      await expectLater(
        capture.capture(
          requestFrame: () =>
              peer.swap(changeAck: (ack) => ack.addAll(changes[index])),
        ),
        throwsFormatException,
        reason: '${changes[index]}',
      );
      expect(path.listSync().map((file) => file.path), [
        '${path.path}/ack.json',
      ]);
      expect(capture.failed, isTrue);
    }
  });

  test('rejects truncated raw files and cleans their payload', () async {
    await expectLater(
      client.capture(
        requestFrame: () => native.swap(pixels: _pixels.sublist(0, 12)),
      ),
      throwsA(
        isA<StateError>().having(
          (error) => error.message,
          'message',
          contains('raw byte count'),
        ),
      ),
    );
    expect(directory.listSync().map((file) => file.path), [
      '${directory.path}/ack.json',
    ]);
    expect(client.failed, isTrue);
  });

  test(
    'missing native acknowledgement times out and removes the pending request',
    () async {
      final capture = EglBackbufferCapture(
        directory: directory,
        width: 2,
        height: 2,
        timeout: const Duration(milliseconds: 40),
        pollInterval: const Duration(milliseconds: 2),
      );
      await expectLater(
        capture.capture(requestFrame: () {}),
        throwsA(isA<TimeoutException>()),
      );
      expect(capture.failed, isTrue);
      expect(directory.listSync(), isEmpty);
    },
  );

  test('a stuck frame trigger also has a bounded timeout', () async {
    final capture = EglBackbufferCapture(
      directory: directory,
      width: 2,
      height: 2,
      timeout: const Duration(milliseconds: 40),
    );
    await expectLater(
      capture.capture(requestFrame: () => Completer<void>().future),
      throwsA(isA<TimeoutException>()),
    );
    expect(capture.failed, isTrue);
    expect(directory.listSync(), isEmpty);
  });

  test(
    'malformed acknowledgement fails and remains available as evidence',
    () async {
      await expectLater(
        client.capture(
          requestFrame: () async {
            await File('${directory.path}/ack.json')
                .writeAsString('{"truncated":');
          },
        ),
        throwsFormatException,
      );
      expect(client.failed, isTrue);
      expect(File('${directory.path}/ack.json').existsSync(), isTrue);
      expect(File('${directory.path}/request').existsSync(), isFalse);
    },
  );

  test(
    'serializes requests while allowing the first operation to complete',
    () async {
      final triggered = Completer<void>(), release = Completer<void>();
      final first = client.capture(
        requestFrame: () async {
          triggered.complete();
          await release.future;
          await native.swap();
        },
      );
      await triggered.future;
      await expectLater(client.barrier(requestFrame: () {}), throwsStateError);
      release.complete();
      expect(await first, orderedEquals(_pixels));
      expect(client.failed, isFalse);
    },
  );

  test('does not overwrite a request owned by another session', () async {
    final request = File('${directory.path}/request');
    await request.writeAsString('7 barrier\n');
    await expectLater(client.capture(requestFrame: () {}), throwsStateError);
    expect(await request.readAsString(), '7 barrier\n');
    expect(client.failed, isTrue);
  });

  test('a repeated native swap index is not a new captured frame', () async {
    await client.barrier(requestFrame: native.swap);
    await expectLater(
      client.capture(
        requestFrame: () =>
            native.swap(changeAck: (ack) => ack['swap_index'] = 1),
      ),
      throwsFormatException,
    );
    expect(client.failed, isTrue);
    expect(directory.listSync().map((file) => file.path), [
      '${directory.path}/ack.json',
    ]);
  });
}
