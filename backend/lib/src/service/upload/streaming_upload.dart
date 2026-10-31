import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:http_parser/http_parser.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:shelf/shelf.dart';

/// Resource limits for one upload. These are runtime policy, not saved config.
class UploadLimits {
  final int maxBytes;
  final int maxFiles;
  final int maxParts;
  final int maxFieldBytes;
  final int maxHeaderBytes;
  final Duration idleTimeout;
  final Duration totalTimeout;

  const UploadLimits({
    this.maxBytes = 200 * 1024 * 1024,
    this.maxFiles = 100,
    this.maxParts = 128,
    this.maxFieldBytes = 1024,
    this.maxHeaderBytes = 16 * 1024,
    this.idleTimeout = const Duration(seconds: 120),
    this.totalTimeout = const Duration(minutes: 30),
  });
}

class UploadFailure implements Exception {
  final int statusCode;
  final String message;

  const UploadFailure(this.statusCode, this.message);

  @override
  String toString() => 'UploadFailure($statusCode, $message)';
}

/// Drain a live HTTP body before cancelling it so an error page can be sent.
enum UploadRejectionPolicy { cancel, drain }

/// Do not expose OS paths, exception text, or credentials to HTTP clients.
UploadFailure uploadFailureFor(Object error) {
  if (error is UploadFailure) return error;
  if (error is TimeoutException) {
    return const UploadFailure(408, 'Upload timed out');
  }
  if (error is FileSystemException) {
    if (error.osError?.errorCode == 28 || error.osError?.errorCode == 122) {
      return const UploadFailure(507, 'Insufficient storage');
    }
    return const UploadFailure(500, 'Could not store upload');
  }
  if (error is FormatException) {
    return const UploadFailure(400, 'Malformed multipart request');
  }
  return const UploadFailure(500, 'Upload failed');
}

class UploadCancellationToken {
  final Set<void Function()> _listeners = {};
  bool _cancelled = false;
  String _message = 'Upload cancelled';

  bool get isCancelled => _cancelled;

  void cancel([String message = 'Upload cancelled']) {
    if (isCancelled) return;
    _message = message;
    _cancelled = true;
    for (final listener in _listeners.toList()) {
      listener();
    }
    _listeners.clear();
  }
}

typedef UploadProgress = void Function(int receivedBytes, int? totalBytes);

/// Coalesces progress reports while always allowing the final report.
class UploadProgressThrottle {
  final UploadProgress callback;
  final Duration interval;
  final Stopwatch _watch = Stopwatch()..start();
  int? _lastBytes;
  int _lastMicroseconds = 0;

  UploadProgressThrottle(this.callback, {this.interval = const Duration(milliseconds: 250)});

  void update(int bytes, int? total, {bool force = false}) {
    final now = _watch.elapsedMicroseconds;
    if (!force && (_lastBytes == bytes || (_lastBytes != null && now - _lastMicroseconds < interval.inMicroseconds))) {
      return;
    }
    _lastBytes = bytes;
    _lastMicroseconds = now;
    callback(bytes, total);
  }
}

abstract interface class UploadFileWriter {
  Future<void> write(List<int> bytes);
  Future<void> flush();
  Future<void> close();
}

typedef UploadWriterFactory = Future<UploadFileWriter> Function(File temporary);

class _DiskWriter implements UploadFileWriter {
  final RandomAccessFile file;

  _DiskWriter(this.file);

  @override
  Future<void> write(List<int> bytes) async => file.writeFrom(bytes);

  @override
  Future<void> flush() async => file.flush();

  @override
  Future<void> close() async => file.close();
}

/// Serializes OS operations, including close after a cancelled pending write.
class _ManagedWriter {
  final UploadFileWriter writer;
  Future<void> _pending = Future<void>.value();
  Future<void>? _closing;

  _ManagedWriter(this.writer);

  Future<void> write(List<int> bytes) => _pending = _pending.then((_) => writer.write(bytes));

  Future<void> flush() => _pending = _pending.then((_) => writer.flush());

  Future<void> close() =>
      _closing ??= _pending.then<void>((_) {}, onError: (Object _, StackTrace __) {}).then((_) => writer.close());
}

/// Reservations serialize matching destinations within this backend isolate.
/// They are lifecycle guards, not filesystem security or interprocess locks.
class UploadTargetReservations {
  final Set<String> _targets = {};

  String _reserve(String destination) {
    final key = path.normalize(path.absolute(destination));
    if (!_targets.add(key)) {
      throw const UploadFailure(409, 'Upload destination is busy or repeated');
    }
    return key;
  }

  void _release(String key) => _targets.remove(key);
}

class StagedUploadFile {
  static final Logger _log = Logger('StagedUploadFile');
  final String filename;
  final String destination;
  final File temporary;
  final UploadTargetReservations _reservations;
  final String _reservation;
  _ManagedWriter? _writer;
  bool _published = false;
  bool _ownsTemporary = false;
  bool _cleaned = false;
  Future<void>? _cleanup;

  StagedUploadFile._(this.filename, this.destination, this.temporary, this._reservations, this._reservation);

  bool get published => _published;

  /// The receiver has already flushed and closed this file before returning it.
  /// Rename retains the existing overwrite policy. A batch is not transactional.
  Future<File> publish() async {
    if (_cleaned) {
      throw const UploadFailure(409, 'Upload has already been cleaned up');
    }
    if (_published) return File(destination);
    try {
      final file = await temporary.rename(destination);
      _published = true;
      return file;
    } catch (error, stack) {
      _log.warning('Upload publication failed', error, stack);
      throw uploadFailureFor(error);
    }
  }

  Future<void> cleanup() => _cleanup ??= _clean(waitForClose: true);

  Future<void> _clean({required bool waitForClose, _UploadScope? scope}) async {
    _cleaned = true;
    final closing = _writer?.close();
    if (closing != null) {
      final observed = closing.catchError((Object error, StackTrace stack) {
        _log.warning('Could not close upload', error, stack);
      });
      if (waitForClose) {
        if (scope == null) {
          await observed;
        } else {
          try {
            await scope.wait(observed);
          } on UploadFailure {
            // Cancellation/deadline still removes the path promptly. The
            // queued close remains observed and finishes after pending IO.
          }
        }
      }
    }
    try {
      if (!_published && _ownsTemporary) await temporary.delete();
    } on FileSystemException catch (error, stack) {
      if (error.osError?.errorCode != 2) {
        _log.warning('Could not remove temporary upload', error, stack);
      }
    } finally {
      _reservations._release(_reservation);
    }
  }
}

class StagedUploadBatch {
  final List<StagedUploadFile> files;
  final int receivedBytes;

  StagedUploadBatch._(List<StagedUploadFile> files, this.receivedBytes) : files = List.unmodifiable(files);

  Future<void> cleanup() async {
    for (final file in files) {
      await file.cleanup();
    }
  }
}

class _UploadScope {
  final UploadLimits limits;
  final Set<void Function()> _listeners = {};
  late final Timer _deadline;
  UploadFailure? _failure;
  final UploadCancellationToken? _cancellation;
  void Function()? _onCancellation;

  _UploadScope(this.limits, UploadCancellationToken? cancellation) : _cancellation = cancellation {
    _deadline = Timer(limits.totalTimeout, () {
      _abort(const UploadFailure(408, 'Upload timed out'));
    });
    if (cancellation != null) {
      if (cancellation.isCancelled) {
        _abort(UploadFailure(408, cancellation._message));
      } else {
        _onCancellation = () {
          _abort(UploadFailure(408, cancellation._message));
        };
        cancellation._listeners.add(_onCancellation!);
      }
    }
  }

  bool get isAborted => _failure != null;

  void _abort(UploadFailure error) {
    if (_failure != null) return;
    _failure = error;
    for (final listener in _listeners.toList()) {
      listener();
    }
    _listeners.clear();
  }

  Future<T> wait<T>(Future<T> operation) {
    final result = Completer<T>();
    void aborted() {
      if (!result.isCompleted) result.completeError(_failure!);
    }

    if (_failure == null) {
      _listeners.add(aborted);
    } else {
      aborted();
    }
    // Remove this operation's listener when it settles. No pending future
    // retains one callback (and potentially a chunk) for every completed write.
    operation.then<void>(
      (value) {
        _listeners.remove(aborted);
        if (!result.isCompleted) result.complete(value);
      },
      onError: (Object error, StackTrace stack) {
        _listeners.remove(aborted);
        if (!result.isCompleted) result.completeError(error, stack);
      },
    );
    return result.future;
  }

  void check() {
    if (_failure != null) throw _failure!;
  }

  void dispose() {
    _deadline.cancel();
    _cancellation?._listeners.remove(_onCancellation);
    _listeners.clear();
  }
}

class _RawUploadReader {
  final StreamIterator<List<int>> _input;
  final _UploadScope scope;
  final int? contentLength;
  final UploadProgressThrottle? progress;
  int receivedBytes = 0;
  List<int> _buffer = const [];
  int _offset = 0;

  _RawUploadReader(Stream<List<int>> input, this.scope, this.contentLength, UploadProgress? onProgress)
    : _input = StreamIterator(input),
      progress = onProgress == null ? null : UploadProgressThrottle(onProgress);

  Future<List<int>?> chunk() async {
    scope.check();
    if (_offset < _buffer.length) {
      final value = _slice(_buffer, _offset);
      _offset = _buffer.length;
      return value;
    }
    while (await _moveNext()) {
      final value = _input.current;
      receivedBytes += value.length;
      if (receivedBytes > scope.limits.maxBytes) {
        throw const UploadFailure(413, 'Upload exceeds size limit');
      }
      progress?.update(receivedBytes, contentLength);
      if (value.isNotEmpty) return value;
    }
    return null;
  }

  Future<bool> _moveNext() async {
    try {
      return await scope.wait(_input.moveNext().timeout(scope.limits.idleTimeout));
    } catch (error) {
      if (error is UploadFailure || error is TimeoutException || error is FileSystemException) {
        rethrow;
      }
      throw const UploadFailure(400, 'Upload stream failed');
    }
  }

  void prepend(List<int> bytes) {
    assert(_offset >= _buffer.length);
    _buffer = bytes;
    _offset = 0;
  }

  Future<int?> byte() async {
    if (_offset == _buffer.length) {
      final next = await chunk();
      if (next == null) return null;
      _buffer = next;
      _offset = 0;
    }
    return _buffer[_offset++];
  }

  Future<List<int>> line(int maxBytes, {bool allowEof = false}) async {
    final bytes = <int>[];
    while (true) {
      final next = await byte();
      if (next == null) {
        if (allowEof) return bytes;
        throw const UploadFailure(400, 'Unexpected end of multipart request');
      }
      bytes.add(next);
      if (bytes.length > maxBytes) {
        throw const UploadFailure(413, 'Multipart headers exceed size limit');
      }
      if (bytes.length >= 2 && bytes[bytes.length - 2] == 13 && bytes.last == 10) {
        return bytes;
      }
    }
  }

  void cancel() {
    // A hostile stream's asynchronous onCancel must not block HTTP shutdown.
    _input.cancel().catchError((Object _) {});
  }

  Future<void> discardRemaining() async {
    scope.check();
    if (receivedBytes > scope.limits.maxBytes) {
      throw const UploadFailure(413, 'Upload exceeds size limit');
    }
    // Bytes already fetched into the parsing buffer were counted in chunk().
    _buffer = const [];
    _offset = 0;
    while (await _moveNext()) {
      receivedBytes += _input.current.length;
      if (receivedBytes > scope.limits.maxBytes) {
        throw const UploadFailure(413, 'Upload exceeds size limit');
      }
    }
  }

  static List<int> _slice(List<int> data, int start, [int? end]) {
    if (data is Uint8List) return Uint8List.sublistView(data, start, end);
    return data.sublist(start, end);
  }
}

enum _BoundaryCandidate { valid, invalid, incomplete }

/// Streams files to staging, leaving filename/path policy to its caller.
/// All multipart bytes are counted before parsing, including ignored epilogue.
class StreamingUploadReceiver {
  static final _headerNamePattern = RegExp(r"^[!#$%&'*+.^_`|~0-9a-z-]+$");
  static final _lineEndingPattern = RegExp(r'\r\n$');
  static final _trailingWhitespacePattern = RegExp(r'[ \t]+$');
  static final Logger _log = Logger('StreamingUploadReceiver');
  final UploadLimits limits;
  final UploadWriterFactory _writerFactory;
  final UploadTargetReservations _reservations;
  final Random _random = Random.secure();

  StreamingUploadReceiver({
    this.limits = const UploadLimits(),
    UploadWriterFactory? writerFactory,
    UploadTargetReservations? reservations,
  }) : _writerFactory = writerFactory ?? _openWriter,
       _reservations = reservations ?? UploadTargetReservations();

  static Future<UploadFileWriter> _openWriter(File file) async => _DiskWriter(await file.open(mode: FileMode.write));

  Future<StagedUploadBatch> receiveMultipart(
    Request request, {
    required FutureOr<String> Function(String filename) destinationFor,
    FutureOr<void> Function(String name, String value)? onField,
    FutureOr<void> Function(String filename)? beforeFile,
    UploadProgress? onProgress,
    UploadCancellationToken? cancellation,
    UploadRejectionPolicy rejectionPolicy = UploadRejectionPolicy.cancel,
  }) async {
    final scope = _UploadScope(limits, cancellation);
    final files = <StagedUploadFile>[];
    _RawUploadReader? reader;
    try {
      scope.check();
      final contentType = request.headers['content-type'];
      if (contentType == null) {
        throw const UploadFailure(400, 'Expected multipart/form-data');
      }
      final type = MediaType.parse(contentType);
      final boundary = type.parameters['boundary'];
      if (type.mimeType != 'multipart/form-data' ||
          boundary == null ||
          boundary.isEmpty ||
          boundary.length > 70 ||
          boundary.codeUnits.any((c) => c < 32 || c > 126)) {
        throw const UploadFailure(400, 'Invalid multipart boundary');
      }
      final length = request.contentLength;
      _checkLength(length);
      reader = _RawUploadReader(request.read(), scope, length, onProgress);
      // MIME permits a preamble, and transport padding after a boundary.
      while (true) {
        final opening = _withoutPadding(utf8.decode(await reader.line(limits.maxHeaderBytes)));
        if (opening == '--$boundary') break;
        if (opening == '--$boundary--') {
          throw const UploadFailure(400, 'No uploaded files');
        }
      }
      final delimiter = ascii.encode('\r\n--$boundary');
      var parts = 0;
      while (true) {
        if (++parts > limits.maxParts) {
          throw const UploadFailure(413, 'Too many multipart parts');
        }
        final headers = await _headers(reader);
        final rawDisposition = headers['content-disposition'];
        if (rawDisposition == null) {
          throw const UploadFailure(400, 'Missing content disposition');
        }
        final HeaderValue disposition;
        try {
          disposition = HeaderValue.parse(rawDisposition);
        } catch (_) {
          throw const UploadFailure(400, 'Invalid content disposition');
        }
        final name = disposition.parameters['name'];
        final filename = disposition.parameters['filename'];
        if (disposition.value != 'form-data' || name == null || name.isEmpty) {
          throw const UploadFailure(400, 'Invalid content disposition');
        }
        final body = _partBody(reader, delimiter);
        if (filename != null) {
          if (name != 'file' || filename.isEmpty) {
            throw const UploadFailure(400, 'Expected a named file part');
          }
          if (files.length >= limits.maxFiles) {
            throw const UploadFailure(413, 'Too many uploaded files');
          }
          if (beforeFile != null) {
            await scope.wait(Future<void>.sync(() => beforeFile(filename)));
          }
          final destination = await scope.wait(Future<String>.sync(() => destinationFor(filename)));
          final file = await _stage(filename, destination, files, scope);
          await for (final bytes in body) {
            await scope.wait(file._writer!.write(bytes));
          }
          await _finish(file, scope);
        } else {
          if (name == 'file' || onField == null) {
            throw const UploadFailure(400, 'Unexpected multipart field');
          }
          final value = BytesBuilder(copy: false);
          await for (final bytes in body) {
            if (value.length + bytes.length > limits.maxFieldBytes) {
              throw const UploadFailure(413, 'Multipart field exceeds size limit');
            }
            value.add(bytes);
          }
          await scope.wait(Future<void>.sync(() => onField(name, utf8.decode(value.takeBytes()))));
        }
        final suffix = await reader.line(limits.maxHeaderBytes, allowEof: true);
        final ending = _withoutPadding(utf8.decode(suffix));
        if (ending.isEmpty && suffix.length >= 2 && suffix.last == 10) {
          continue;
        }
        if (ending != '--') {
          throw const UploadFailure(400, 'Invalid multipart closing');
        }
        // Consume and count epilogue, including errors after the final boundary.
        while (await reader.chunk() != null) {}
        if (files.isEmpty) {
          throw const UploadFailure(400, 'No uploaded files');
        }
        reader.progress?.update(reader.receivedBytes, length, force: true);
        return StagedUploadBatch._(files, reader.receivedBytes);
      }
    } catch (error, stack) {
      if (error is! UploadFailure) {
        _log.warning('Could not receive multipart upload', error, stack);
      }
      for (final file in files) {
        file._cleanup ??= file._clean(waitForClose: !scope.isAborted, scope: scope);
        await file._cleanup;
      }
      if (rejectionPolicy == UploadRejectionPolicy.drain && reader != null && !scope.isAborted) {
        try {
          // Do not parse or save rejected input. Draining retains the same
          // byte/deadline/cancellation limits and emits no upload progress.
          await reader.discardRemaining();
        } catch (drainError, stack) {
          // An oversized, disconnected or stalled sender cannot be drained
          // safely. Cancel below, retaining the original application failure.
          _log.fine('Could not finish rejected upload', drainError, stack);
        }
      }
      throw uploadFailureFor(error);
    } finally {
      reader?.cancel();
      scope.dispose();
    }
  }

  Future<StagedUploadFile> receiveStream(
    Stream<List<int>> stream, {
    required String filename,
    required String destination,
    int? contentLength,
    UploadProgress? onProgress,
    UploadCancellationToken? cancellation,
  }) async {
    final scope = _UploadScope(limits, cancellation);
    final files = <StagedUploadFile>[];
    final reader = _RawUploadReader(stream, scope, contentLength, onProgress);
    try {
      scope.check();
      _checkLength(contentLength);
      final file = await _stage(filename, destination, files, scope);
      List<int>? bytes;
      while ((bytes = await reader.chunk()) != null) {
        await scope.wait(file._writer!.write(bytes!));
      }
      await _finish(file, scope);
      reader.progress?.update(reader.receivedBytes, contentLength, force: true);
      return file;
    } catch (error, stack) {
      if (error is! UploadFailure) {
        _log.warning('Could not receive upload stream', error, stack);
      }
      for (final file in files) {
        file._cleanup ??= file._clean(waitForClose: !scope.isAborted, scope: scope);
        await file._cleanup;
      }
      throw uploadFailureFor(error);
    } finally {
      reader.cancel();
      scope.dispose();
    }
  }

  void _checkLength(int? length) {
    if (length != null && (length < 0 || length > limits.maxBytes)) {
      throw const UploadFailure(413, 'Upload exceeds size limit');
    }
  }

  Future<StagedUploadFile> _stage(
    String filename,
    String destination,
    List<StagedUploadFile> files,
    _UploadScope scope,
  ) async {
    scope.check();
    final reservation = _reservations._reserve(destination);
    final parent = File(destination).parent;
    final nonce = List.generate(4, (_) => _random.nextInt(0x100000000).toRadixString(16).padLeft(8, '0')).join();
    final temporary = File(path.join(parent.path, '.upload-$nonce.part'));
    final staged = StagedUploadFile._(filename, destination, temporary, _reservations, reservation);
    files.add(staged);
    await scope.wait(parent.create(recursive: true));
    await scope.wait(
      temporary.create(exclusive: true).then((_) async {
        staged._ownsTemporary = true;
        if (staged._cleaned) await _removeLateTemporary(temporary);
      }),
    );
    scope.check();
    final opening = _writerFactory(temporary).then<void>(
      (writer) {
        staged._writer = _ManagedWriter(writer);
        if (staged._cleaned) {
          staged._writer!.close().catchError((Object _) {}).then((_) => _removeLateTemporary(temporary));
        }
      },
      onError: (Object error, StackTrace stack) async {
        if (staged._cleaned) await _removeLateTemporary(temporary);
        Error.throwWithStackTrace(error, stack);
      },
    );
    await scope.wait(opening);
    return staged;
  }

  static Future<void> _removeLateTemporary(File file) async {
    try {
      await file.delete();
    } on FileSystemException catch (error, stack) {
      if (error.osError?.errorCode != 2) {
        StagedUploadFile._log.warning('Could not remove temporary upload', error, stack);
      }
    }
  }

  Future<void> _finish(StagedUploadFile file, _UploadScope scope) async {
    await scope.wait(file._writer!.flush());
    await scope.wait(file._writer!.close());
  }

  Future<Map<String, String>> _headers(_RawUploadReader reader) async {
    final headers = <String, String>{};
    var size = 0;
    String? lastName;
    while (true) {
      final bytes = await reader.line(limits.maxHeaderBytes - size);
      size += bytes.length;
      if (bytes.length == 2) return headers;
      final line = utf8.decode(bytes.sublist(0, bytes.length - 2));
      if (line.startsWith(' ') || line.startsWith('\t')) {
        if (lastName == null) {
          throw const UploadFailure(400, 'Invalid multipart header');
        }
        headers[lastName] = '${headers[lastName]} ${line.trim()}';
        continue;
      }
      final colon = line.indexOf(':');
      if (colon <= 0) {
        throw const UploadFailure(400, 'Invalid multipart header');
      }
      final name = line.substring(0, colon).toLowerCase();
      if (!_headerNamePattern.hasMatch(name) || headers.containsKey(name)) {
        throw const UploadFailure(400, 'Invalid multipart header');
      }
      headers[name] = line.substring(colon + 1).trim();
      lastName = name;
    }
  }

  /// Retains only a boundary-sized tail between source chunks. A matching
  /// prefix followed by another byte is ordinary file content, not a boundary.
  Stream<List<int>> _partBody(_RawUploadReader reader, List<int> delimiter) async* {
    List<int> pending = const [];
    while (true) {
      final next = await reader.chunk();
      final atEof = next == null;
      final incoming = next ?? const <int>[];
      final combined = Uint8List(pending.length + incoming.length)
        ..setRange(0, pending.length, pending)
        ..setRange(pending.length, pending.length + incoming.length, incoming);
      pending = combined;
      var found = -1;
      int? incomplete;
      for (var i = 0; i + delimiter.length <= pending.length; i++) {
        if (pending[i] != delimiter[0]) continue;
        var matches = true;
        for (var j = 1; j < delimiter.length; j++) {
          if (pending[i + j] != delimiter[j]) {
            matches = false;
            break;
          }
        }
        if (!matches) continue;
        switch (_boundaryCandidate(pending, i + delimiter.length, atEof)) {
          case _BoundaryCandidate.valid:
            found = i;
          case _BoundaryCandidate.incomplete:
            incomplete = i;
          case _BoundaryCandidate.invalid:
            continue;
        }
        break;
      }
      if (found >= 0) {
        reader.prepend(Uint8List.sublistView(combined, found + delimiter.length));
        if (found > 0) yield Uint8List.sublistView(combined, 0, found);
        return;
      }
      if (atEof) {
        throw const UploadFailure(400, 'Unexpected end of multipart request');
      }
      if (incomplete != null) {
        if (incomplete > 0) {
          yield Uint8List.sublistView(combined, 0, incomplete);
        }
        pending = pending.sublist(incomplete);
        continue;
      }
      final keep = delimiter.length + 1;
      if (pending.length > keep) {
        final emit = pending.length - keep;
        yield Uint8List.sublistView(combined, 0, emit);
        pending = pending.sublist(emit);
      }
    }
  }

  _BoundaryCandidate _boundaryCandidate(List<int> data, int offset, bool atEof) {
    final start = offset;
    var closing = false;
    if (offset < data.length && data[offset] == 45) {
      if (offset + 1 == data.length) {
        return atEof ? _BoundaryCandidate.invalid : _BoundaryCandidate.incomplete;
      }
      if (data[offset + 1] != 45) return _BoundaryCandidate.invalid;
      closing = true;
      offset += 2;
    }
    while (offset < data.length && (data[offset] == 32 || data[offset] == 9)) {
      if (offset - start >= limits.maxHeaderBytes) {
        throw const UploadFailure(413, 'Multipart headers exceed size limit');
      }
      offset++;
    }
    if (offset == data.length) {
      if (atEof) {
        return closing ? _BoundaryCandidate.valid : _BoundaryCandidate.invalid;
      }
      return _BoundaryCandidate.incomplete;
    }
    if (data[offset] != 13) return _BoundaryCandidate.invalid;
    if (offset + 1 == data.length) {
      return atEof ? _BoundaryCandidate.invalid : _BoundaryCandidate.incomplete;
    }
    return data[offset + 1] == 10 ? _BoundaryCandidate.valid : _BoundaryCandidate.invalid;
  }

  static String _withoutPadding(String line) =>
      line.replaceFirst(_lineEndingPattern, '').replaceFirst(_trailingWhitespacePattern, '');
}
