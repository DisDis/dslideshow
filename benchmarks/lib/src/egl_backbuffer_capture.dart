import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

final _sha256Pattern = RegExp(r'^[0-9a-fA-F]{64}$');

Future<Map<String, Object?>> loadEglCaptureProvenance(
  Directory directory,
) async {
  final file = File('${directory.path}/runtime-provenance.json');
  final value = jsonDecode(await file.readAsString());
  if (value is! Map<String, dynamic> ||
      value['schema_version'] != 1 ||
      value['kind'] != 'egl_backbuffer_capture' ||
      value['timing_results_valid'] != false) {
    throw FormatException('Invalid EGL capture provenance: ${file.path}');
  }
  for (final component in ['real_runtime', 'interposer', 'wrapper']) {
    final identity = value[component];
    if (identity is! Map ||
        identity['path'] is! String ||
        (identity['path'] as String).isEmpty ||
        identity['sha256'] is! String ||
        !_sha256Pattern.hasMatch(identity['sha256'] as String)) {
      throw FormatException(
        'Missing path/SHA-256 for EGL $component: ${file.path}',
      );
    }
  }
  return Map<String, Object?>.unmodifiable(value);
}

/// Reads the engine actually mapped by this process, after its first real swap.
/// Wrapper library search paths alone cannot establish the loaded engine hash.
Future<Map<String, Object?>> loadEglCaptureLoadedRuntime(
  Directory directory,
) async {
  final file = File('${directory.path}/capture-runtime.json');
  final value = jsonDecode(await file.readAsString());
  if (value is! Map<String, dynamic> ||
      value['schema_version'] != 1 ||
      value['kind'] != 'egl_capture_loaded_runtime' ||
      value['pid'] != pid ||
      !value.containsKey('effective_ld_library_path') ||
      (value['effective_ld_library_path'] != null &&
          value['effective_ld_library_path'] is! String)) {
    throw FormatException('Invalid loaded EGL runtime: ${file.path}');
  }
  final engine = value['engine'];
  if (engine is! Map ||
      engine['path'] is! String ||
      (engine['path'] as String).isEmpty ||
      engine['sha256'] is! String ||
      !_sha256Pattern.hasMatch(engine['sha256'] as String)) {
    throw FormatException('Missing loaded engine path/SHA-256: ${file.path}');
  }
  return Map<String, Object?>.unmodifiable(value);
}

enum PixelCaptureBackend {
  toImage,
  eglBackbuffer;

  static PixelCaptureBackend parse(String? value) {
    if (value == null) return PixelCaptureBackend.toImage;
    return values.firstWhere(
      (backend) => backend.name == value,
      orElse: () => throw FormatException(
        'Unknown pixel capture backend: $value; expected '
        '${values.map((backend) => backend.name).join(', ')}',
      ),
    );
  }
}

/// Three distinct neighboring phases ending immediately before the target.
/// Zero is approached from above because earlier valid phases do not exist.
List<double> eglCaptureWarmProgress(double target) {
  if (!target.isFinite || target < 0 || target > 1) {
    throw RangeError.range(target, 0, 1, 'target');
  }
  if (target == 0) return const [.03, .02, .01];
  final start = (target - .03).clamp(0.0, 1.0);
  final step = (target - start) / 3;
  return List<double>.unmodifiable([start, start + step, start + step * 2]);
}

/// Subscribes before submission and accepts only that frame's raster timing.
/// Timings may be batched and arrive before [submitFrame] returns its number.
Future<int> waitForRasterizedFrame({
  required Stream<int> rasterizedFrameNumbers,
  required Future<int> Function() submitFrame,
  Duration timeout = const Duration(seconds: 30),
}) async {
  if (timeout <= Duration.zero) throw ArgumentError.value(timeout, 'timeout');
  final watch = Stopwatch()..start();
  final seen = <int>{};
  final rasterized = Completer<void>();
  int? target;
  Object? streamError;
  StackTrace? streamStack;
  final subscription = rasterizedFrameNumbers.listen(
    (number) {
      seen.add(number);
      if (number == target && !rasterized.isCompleted) rasterized.complete();
    },
    onError: (Object error, StackTrace stack) {
      streamError = error;
      streamStack = stack;
      if (target != null && !rasterized.isCompleted) rasterized.complete();
    },
  );
  try {
    target = await submitFrame().timeout(timeout);
    if (target < 0) throw StateError('Missing submitted frame number: $target');
    if (streamError != null) {
      Error.throwWithStackTrace(streamError!, streamStack!);
    }
    if (seen.contains(target) && !rasterized.isCompleted) rasterized.complete();
    final remaining = timeout - watch.elapsed;
    if (remaining <= Duration.zero) {
      throw TimeoutException(
        'Submitted frame $target rasterization timed out',
        timeout,
      );
    }
    await rasterized.future.timeout(remaining);
    if (streamError != null) {
      Error.throwWithStackTrace(streamError!, streamStack!);
    }
    return target;
  } finally {
    await subscription.cancel();
  }
}

enum _RequestKind { barrier, capture }

/// Serial IPC client for the benchmark-only eglSwapBuffers capture interposer.
/// Barriers acknowledge successful real swaps. Captures read the GL backbuffer
/// before a successful swap; neither operation verifies physical scanout.
class EglBackbufferCapture {
  final Directory directory;
  final int width;
  final int height;
  final Duration timeout;
  final Duration pollInterval;
  int _nextRequestId = DateTime.now().microsecondsSinceEpoch;
  int? _lastSwapIndex;
  Map<String, dynamic>? _lastAcknowledgement;
  bool _busy = false;
  bool _failed = false;

  EglBackbufferCapture({
    required this.directory,
    required this.width,
    required this.height,
    this.timeout = const Duration(seconds: 30),
    this.pollInterval = const Duration(milliseconds: 10),
  }) {
    if (width <= 0 ||
        height <= 0 ||
        timeout <= Duration.zero ||
        pollInterval <= Duration.zero) {
      throw ArgumentError(
        'Positive dimensions, timeout and poll interval required',
      );
    }
  }

  bool get failed => _failed;
  Map<String, dynamic>? get lastAcknowledgement => _lastAcknowledgement == null
      ? null
      : Map.unmodifiable(_lastAcknowledgement!);

  Future<void> barrier({
    required FutureOr<void> Function() requestFrame,
  }) async {
    await _request(_RequestKind.barrier, requestFrame);
  }

  Future<Uint8List> capture({
    required FutureOr<void> Function() requestFrame,
  }) async => (await _request(_RequestKind.capture, requestFrame))!;

  Future<Uint8List?> _request(
    _RequestKind kind,
    FutureOr<void> Function() requestFrame,
  ) async {
    if (_busy) {
      throw StateError('An EGL capture request is already outstanding');
    }
    if (_failed) throw StateError('The EGL capture backend has failed');
    _busy = true;
    final id = _nextRequestId++;
    final watch = Stopwatch()..start();
    final request = File('${directory.path}/request');
    final temporary = File('${directory.path}/request.$pid.$id.tmp');
    final raw = File('${directory.path}/frame-$id.rgba');
    final ack = File('${directory.path}/ack.json');
    try {
      await directory.create(recursive: true);
      if (await request.exists() ||
          await File('${directory.path}/request.active').exists()) {
        throw StateError(
          'Another EGL capture request is pending in ${directory.path}',
        );
      }
      await temporary.writeAsString(
        '$id${kind == _RequestKind.barrier ? ' barrier' : ''}\n',
        flush: true,
      );
      await temporary.rename(request.path);
      final triggerTime = timeout - watch.elapsed;
      if (triggerTime <= Duration.zero) {
        throw TimeoutException(
          'EGL capture request publication timed out',
          timeout,
        );
      }
      await Future<void>.sync(requestFrame).timeout(triggerTime);
      while (watch.elapsed < timeout) {
        if (await ack.exists()) {
          final decoded = jsonDecode(await ack.readAsString());
          if (decoded is! Map<String, dynamic> ||
              decoded['request_id'] is! int ||
              (decoded['request_id'] as int) <= 0) {
            throw const FormatException('Invalid EGL capture acknowledgement');
          }
          if (decoded['request_id'] == id) {
            _validateAck(decoded, id, kind);
            _lastSwapIndex = decoded['swap_index'] as int;
            _lastAcknowledgement = decoded;
            if (kind == _RequestKind.barrier) return null;
            final remaining = timeout - watch.elapsed;
            if (remaining <= Duration.zero) break;
            final rawLength = await raw.length().timeout(remaining);
            if (rawLength != width * height * 4) {
              throw StateError(
                'EGL capture $id raw byte count is $rawLength, '
                'expected ${width * height * 4}',
              );
            }
            final readTime = timeout - watch.elapsed;
            if (readTime <= Duration.zero) break;
            final pixels = await raw.readAsBytes().timeout(readTime);
            if (pixels.length != width * height * 4) {
              throw StateError(
                'EGL capture $id raw byte count is ${pixels.length}, '
                'expected ${width * height * 4}',
              );
            }
            return pixels;
          }
        }
        final remaining = timeout - watch.elapsed;
        if (remaining <= Duration.zero) break;
        await Future<void>.delayed(
          remaining < pollInterval ? remaining : pollInterval,
        );
      }
      throw TimeoutException(
        'EGL ${kind.name} request $id was not acknowledged',
        timeout,
      );
    } catch (_) {
      _failed = true;
      rethrow;
    } finally {
      try {
        if (await temporary.exists()) await temporary.delete();
        if (await raw.exists()) await raw.delete();
        if (await request.exists()) {
          final text = (await request.readAsString()).trim().split(' ').first;
          if (text == '$id') await request.delete();
        }
        // The native side owns request.active. Only remove our own published
        // acknowledgement; a stale/foreign acknowledgement remains untouched.
        if (!_failed && await ack.exists()) {
          try {
            final value = jsonDecode(await ack.readAsString());
            if (value is Map && value['request_id'] == id) await ack.delete();
          } on FormatException {
            // Preserve malformed protocol evidence for the report archive.
          }
        }
      } catch (_) {
        _failed = true;
        rethrow;
      } finally {
        _busy = false;
      }
    }
  }

  void _validateAck(Map<String, dynamic> ack, int id, _RequestKind kind) {
    if (ack['status'] == 'error') {
      throw StateError(
        'Native EGL ${kind.name} request $id failed: ${ack['error']}',
      );
    }
    final swap = ack['swap_index'];
    final expectedFile = kind == _RequestKind.capture ? 'frame-$id.rgba' : null;
    final expectedBytes = kind == _RequestKind.capture ? width * height * 4 : 0;
    if (ack['schema_version'] != 1 ||
        ack['status'] != 'ok' ||
        ack['kind'] != kind.name ||
        ack['width'] != width ||
        ack['height'] != height ||
        ack['stride'] != width * 4 ||
        ack['bytes'] != expectedBytes ||
        ack['file'] != expectedFile ||
        ack['format'] != 'RGBA8888' ||
        ack['row_order'] != 'top_to_bottom' ||
        ack['origin'] != 'top-left' ||
        ack['framebuffer'] != 0 ||
        ack['read_framebuffer'] != 0 ||
        ack['gl_error'] != 0 ||
        ack['swap_success'] != true ||
        ack['source'] != 'egl_backbuffer_before_swap' ||
        ack['error'] != null ||
        swap is! int ||
        swap <= 0 ||
        (_lastSwapIndex != null && swap <= _lastSwapIndex!)) {
      throw FormatException(
        'EGL ${kind.name} request $id has incompatible '
        'dimensions, format, identity or swap sequence: $ack',
      );
    }
  }
}
