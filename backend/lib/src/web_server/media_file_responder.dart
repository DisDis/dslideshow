// Asynchronous filesystem work keeps HTTP and RPC event loops responsive.
// ignore_for_file: avoid_slow_async_io
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:http_parser/http_parser.dart' as dates;
import 'package:mime/mime.dart';
import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart';

const galleryCorsHeaders = <String, String>{
  'access-control-allow-origin': '*',
  'access-control-allow-methods': 'GET, HEAD, POST, OPTIONS',
  'access-control-allow-headers':
      'Origin, Content-Type, If-None-Match, If-Modified-Since, Range, If-Range',
  'access-control-expose-headers': 'ETag, Last-Modified, Content-Length, Content-Range, Accept-Ranges, Retry-After',
};

/// Admission covers opened media handles until body completion or cancellation.
/// Initial policy is conservative and must be measured on the target device.
class MediaFileResponder {
  static final _log = Logger('MediaFileResponder');
  static final _rangePattern = RegExp(r'^bytes=(\d*)-(\d*)$');
  final int maxStreams;
  final Set<_FileBody> _bodies = {};
  final Set<Completer<void>> _pending = {};
  Future<void>? _closing;
  int _active = 0;
  bool _closed = false;
  MediaFileResponder({this.maxStreams = 12}) {
    if (maxStreams < 1) throw ArgumentError.value(maxStreams);
  }

  Future<Response> serve(
    Request request,
    File file, {
    String? etag,
    String? contentType,
    String cacheControl = 'private, no-cache',
    Future<void> Function()? onRelease,
    Future<bool> Function()? isCurrent,
  }) async {
    var released = false;
    var admitted = false;
    RandomAccessFile? handle;
    Future<void> release() async {
      if (released) return;
      released = true;
      try {
        await handle?.close();
      } finally {
        if (admitted) _active--;
        await onRelease?.call();
      }
    }

    if (_closed || _active >= maxStreams) {
      await release();
      return Response(
        _closed ? 503 : 429,
        headers: {...galleryCorsHeaders, 'retry-after': '1'},
      );
    }
    _active++;
    admitted = true;
    final pending = Completer<void>();
    _pending.add(pending);
    try {
      final before = await file.stat();
      handle = await file.open();
      final length = await handle.length();
      final after = await file.stat();
      if (before.modified != after.modified ||
          before.changed != after.changed ||
          before.size != after.size ||
          length != after.size ||
          (isCurrent != null && !await isCurrent())) {
        await release();
        return Response(409, headers: galleryCorsHeaders);
      }
      final modified = DateTime.fromMillisecondsSinceEpoch(
        after.modified.millisecondsSinceEpoch ~/ 1000 * 1000,
        isUtc: true,
      );
      final validator =
          etag ??
          'W/"${after.modified.microsecondsSinceEpoch}-${after.changed.microsecondsSinceEpoch}-$length"';
      final headers = <String, String>{
        ...galleryCorsHeaders,
        'content-type':
            contentType ??
            lookupMimeType(file.path) ??
            'application/octet-stream',
        'content-length': '$length',
        'last-modified': dates.formatHttpDate(modified),
        'etag': validator,
        'accept-ranges': 'bytes',
        'cache-control': cacheControl,
      };
      final ifNoneMatch = request.headers['if-none-match'];
      final notModified = ifNoneMatch != null
          ? ifNoneMatch
                .split(',')
                .any(
                  (value) =>
                      value.trim() == '*' ||
                      _weak(value.trim()) == _weak(validator),
                )
          : _date(request.headers['if-modified-since'])?.isBefore(modified) ==
                false;
      if (notModified) {
        await release();
        headers.remove('content-length');
        return Response.notModified(headers: headers);
      }
      var start = 0;
      var end = length;
      var status = 200;
      final range = request.headers['range'];
      final ifRange = request.headers['if-range'];
      // Stat metadata cannot prove that a source did not change twice within
      // one second. Its Last-Modified is weak for If-Range (RFC 9110 8.8.2.2).
      final rangeAllowed =
          ifRange == null ||
          (!validator.startsWith('W/') && ifRange == validator);
      // RFC 9110 14.2 defines Range only for GET; HEAD retains the full length.
      if (request.method == 'GET' && range != null && rangeAllowed) {
        final match = _rangePattern.firstMatch(range);
        if (match != null && (match[1]!.isNotEmpty || match[2]!.isNotEmpty)) {
          final first = match[1]!;
          final last = match[2]!;
          final firstNumber = first.isEmpty ? null : int.tryParse(first);
          final lastNumber = last.isEmpty ? null : int.tryParse(last);
          var valid =
              length > 0 &&
              (first.isEmpty || firstNumber != null) &&
              (last.isEmpty || lastNumber != null);
          if (first.isEmpty) {
            valid = valid && lastNumber != null && lastNumber > 0;
            start = valid ? math.max(0, length - lastNumber) : 0;
          } else {
            start = firstNumber ?? length;
            end = last.isEmpty
                ? length
                : math.min(length - 1, lastNumber ?? length) + 1;
            valid = valid && start < length && end > start;
          }
          if (!valid) {
            await release();
            return Response(
              416,
              headers: {
                ...galleryCorsHeaders,
                'content-range': 'bytes */$length',
                'accept-ranges': 'bytes',
              },
            );
          }
          status = 206;
          headers['content-range'] = 'bytes $start-${end - 1}/$length';
          headers['content-length'] = '${end - start}';
        }
      }
      if (request.method == 'HEAD') {
        await release();
        return Response(status, headers: headers);
      }
      await handle.setPosition(start);
      if (_closed) {
        await release();
        return Response(503, headers: galleryCorsHeaders);
      }
      late _FileBody body;
      body = _FileBody(handle, end - start, () async {
        _bodies.remove(body);
        await release();
      });
      _bodies.add(body);
      return Response(status, headers: headers, body: body.stream);
    } on FileSystemException catch (error, stack) {
      _log.log(
        error.osError?.errorCode == 2 ? Level.FINE : Level.WARNING,
        () => 'Media file unavailable path=${jsonEncode(file.path)}',
        error,
        stack,
      );
      await release();
      return Response.notFound(
        'Media unavailable',
        headers: galleryCorsHeaders,
      );
    } catch (error, stack) {
      _log.warning(
        () => 'Media response failed path=${jsonEncode(file.path)}',
        error,
        stack,
      );
      await release();
      rethrow;
    } finally {
      _pending.remove(pending);
      pending.complete();
    }
  }

  static String _weak(String value) =>
      value.startsWith('W/') ? value.substring(2) : value;
  static DateTime? _date(String? value) {
    if (value == null) return null;
    try {
      return dates.parseHttpDate(value);
    } on FormatException {
      return null;
    }
  }

  Future<void> close() => _closing ??= _close();
  Future<void> _close() async {
    _closed = true;
    await Future.wait(_bodies.toList().map((body) => body.cancel()));
    await Future.wait(_pending.map((pending) => pending.future).toList());
    await Future.wait(_bodies.toList().map((body) => body.cancel()));
  }
}

class _FileBody {
  final RandomAccessFile handle;
  final Future<void> Function() release;
  int remaining;
  bool cancelled = false;
  Future<void>? running;
  Future<void>? released;
  Future<void>? cancellation;
  Completer<void>? paused;
  late final StreamController<List<int>> controller;
  _FileBody(this.handle, this.remaining, this.release) {
    controller = StreamController<List<int>>(
      onListen: () {
        running = _pump();
      },
      onPause: () {
        paused ??= Completer<void>();
      },
      onResume: () {
        paused?.complete();
        paused = null;
      },
      onCancel: cancel,
    );
  }
  Stream<List<int>> get stream => controller.stream;
  Future<void> _release() => released ??= release();
  Future<void> cancel() => cancellation ??= _cancel();
  Future<void> _cancel() async {
    cancelled = true;
    paused?.complete();
    paused = null;
    if (running != null) await running;
    await _release();
    if (!controller.isClosed) unawaited(controller.close());
  }

  Future<void> _pump() async {
    try {
      while (!cancelled && remaining > 0) {
        if (paused != null) await paused!.future;
        if (cancelled) break;
        final bytes = await handle.read(math.min(64 * 1024, remaining));
        if (cancelled) break;
        if (bytes.isEmpty) throw const FileSystemException('Media truncated');
        remaining -= bytes.length;
        controller.add(bytes);
      }
    } catch (error, stack) {
      if (!cancelled) {
        MediaFileResponder._log.warning(
          () =>
              'Media body failed path=${jsonEncode(handle.path)} '
              'remaining=$remaining',
          error,
          stack,
        );
        controller.addError(error, stack);
      }
    } finally {
      // close() schedules done. The consumer may still be paused on the last
      // chunk: onCancel owns release, after actual done/cancel, not source EOF.
      if (!controller.isClosed) unawaited(controller.close());
    }
  }
}
