import 'dart:async';

import 'package:logging/logging.dart';

enum _Escape { text, escape, csi, string, stringEscape }

typedef _Line = ({String label, String text, bool isError});
typedef _Fragment = ({String text, bool carriage});

/// Serializes console output and owns a compact board of active test jobs.
class BuildConsole {
  BuildConsole({
    required this.output,
    required this.errors,
    this.flushOutput,
    this.flushErrors,
    required this.color,
    required bool interactive,
    this.columns = 120,
  }) : interactive = interactive && color {
    if (columns < 2) throw ArgumentError.value(columns, 'columns', 'Must be at least two');
  }

  static final _sgr = RegExp(r'\x1b\[[0-9;:]*m');
  static final _controls = RegExp(r'[\x00-\x1f\x7f-\x9f]');
  static final _progress = RegExp(r'^\d+:\d{2}(?::\d{2})?\s+[+~\-]\d+(?:\s+[+~\-]\d+)*:');
  static final _failure = RegExp(r'(?:^|\s)-[1-9]\d*(?:\s|:)|\[(?:E|F)\]|Some tests failed');
  static final _completed = RegExp(r'All tests passed!|Some tests failed\.|No tests ran\.');
  static final _result = RegExp(r'(?:^|\s)result=(passed|failed|cancelled)(?:\s|$)');
  static final _marks = RegExp(r'\p{Mark}', unicode: true);
  static final _progressPadding = RegExp(r'(?: |\x1b\[[0-9;:]*m)+$');
  static final _leadingRun = RegExp(r'^(run=\S+)(?:\s+|$)');
  static const _reset = '\x1b[0m';
  static const _palette = [36, 35, 34, 33, 32, 96];

  final StringSink output, errors;
  final Future<void> Function()? flushOutput, flushErrors;
  final bool color, interactive;
  final int columns;
  final _jobs = <String, _Job>{};
  Future<void> _queue = Future<void>.value();
  Object? _writeError;
  StackTrace? _writeStack;
  var _closed = false;
  var _drawnRows = 0;
  var _drawnBoard = '';

  Future<void> _serialize(Future<void> Function() work) {
    final operation = _queue.then((_) async {
      try {
        await work();
      } on Object catch (error, stack) {
        _writeError ??= error;
        _writeStack ??= stack;
        rethrow;
      }
    });
    // A caller receives its failure; later cleanup must still drain the queue.
    _queue = operation.then<void>((_) {}, onError: (Object _, StackTrace _) {});
    return operation;
  }

  Future<void> _enqueue(Future<void> Function() work) {
    if (_closed) return Future<void>.error(StateError('BuildConsole is closed'));
    return _serialize(work);
  }

  Future<void> startJob(String label, {bool compact = false}) => _enqueue(() async {
    if (_jobs.containsKey(label)) throw StateError('Console job is already active');
    _jobs[label] = _Job(compact && interactive);
    await _render(const []);
  });

  Future<void> writeChunk(String label, String text, {bool isError = false}) => _enqueue(() async {
    final job = _jobs[label];
    if (job == null) throw StateError('Console job is not active');
    final lines = <_Line>[];
    if (isError && job.compact && job.output.pending.isNotEmpty) {
      job.output.flush((fragment) => lines.add((label: label, text: fragment.text, isError: false)));
    }
    (isError ? job.errors : job.output).consume(text, (fragment) => _accept(label, job, fragment, isError, lines));
    if (!isError && job.compact && job.output.pending.isNotEmpty) job.progress = job.output.pending;
    await _render(lines);
  });

  Future<void> finishJob(String label) => _enqueue(() async {
    final job = _jobs[label];
    if (job == null) return;
    final lines = <_Line>[];
    job.output.finish((fragment) => lines.add((label: label, text: fragment.text, isError: false)));
    job.errors.finish((fragment) => lines.add((label: label, text: fragment.text, isError: true)));
    _jobs.remove(label);
    await _render(lines);
  });

  void _accept(String label, _Job job, _Fragment fragment, bool isError, List<_Line> lines) {
    final plain = fragment.text.replaceAll(_sgr, '');
    final failed = _failure.hasMatch(plain), completed = _completed.hasMatch(plain);
    // Compact reporter uses CR for ephemeral updates. A LF-terminated progress
    // header supplies the full context of a following print/error message.
    final progress = job.compact && !isError && !failed && !completed && fragment.carriage && _progress.hasMatch(plain);
    if (progress) {
      if (fragment.text.isNotEmpty) job.progress = fragment.text;
    } else if (fragment.text.isNotEmpty || !fragment.carriage) {
      lines.add((label: label, text: fragment.text, isError: isError));
    }
  }

  Future<void> writeLog(LogRecord record) => _enqueue(() async {
    final filter = _AnsiFilter(color: false);
    final text = StringBuffer();
    var message = record.message;
    final run = record.loggerName == 'build' ? _leadingRun.firstMatch(message) : null;
    if (run != null) {
      final remaining = message.substring(run.end);
      message = remaining.isEmpty ? run.group(1)! : '$remaining ${run.group(1)}';
    }
    final diagnostic = StringBuffer('${record.level.name} ${record.loggerName} $message');
    if (record.error != null) diagnostic.write('\n${record.error}');
    if (record.stackTrace != null) diagnostic.write('\n${record.stackTrace}');
    filter.consume(diagnostic.toString(), text.write);
    filter.finish(text.write);
    var code = 36;
    final result = _result.firstMatch(record.message)?.group(1);
    if (record.level >= Level.SEVERE || result == 'failed') {
      code = 31;
    } else if (record.level >= Level.WARNING || result == 'cancelled') {
      code = 33;
    } else if (result == 'passed') {
      code = 32;
    } else if (record.level < Level.INFO) {
      code = 90;
    }
    final lines = text.toString().replaceAll('\r\n', '\n').replaceAll('\r', '\n').split('\n');
    await _render([
      for (final line in lines) (label: '', text: color ? '\x1b[${code}m$line$_reset' : line, isError: true),
    ]);
  });

  String _prefix(String label) {
    final safe = label.replaceAll(_controls, '');
    if (!color) return '[$safe] ';
    final index = safe.codeUnits.fold<int>(0, (sum, unit) => sum + unit) % _palette.length;
    return '\x1b[${_palette[index]}m[$safe]$_reset ';
  }

  List<String> _board() => [
    for (final entry in _jobs.entries)
      if (entry.value.compact)
        _clamp('${_prefix(entry.key)}${_trimProgressPadding(entry.value.progress)}', columns - 1),
  ];

  String _trimProgressPadding(String text) {
    if (!_progress.hasMatch(text.replaceAll(_sgr, ''))) return text;
    return text.replaceFirstMapped(_progressPadding, (match) => match.group(0)!.replaceAll(' ', ''));
  }

  bool _clearBoard() {
    if (_drawnRows == 0) return false;
    output.write('\x1b[${_drawnRows}F\x1b[J');
    _drawnRows = 0;
    _drawnBoard = '';
    return true;
  }

  Future<void> _render(List<_Line> lines, {bool redraw = true}) async {
    final board = interactive && redraw ? _board() : const <String>[];
    final next = board.join('\n');
    if (lines.isEmpty && next == _drawnBoard) return;
    if (_clearBoard()) await flushOutput?.call();
    for (final line in lines) {
      final sink = line.isError ? errors : output;
      final content = line.isError || line.label.isEmpty ? line.text : _trimProgressPadding(line.text);
      final text = color ? content : content.replaceAll(_sgr, '');
      sink.write('${line.label.isEmpty ? '' : _prefix(line.label)}$text${color ? _reset : ''}\n');
      if (line.isError) {
        await flushErrors?.call();
      } else {
        await flushOutput?.call();
      }
    }
    if (board.isNotEmpty) {
      output.write('${board.join('\n')}\n');
      _drawnRows = board.length;
      _drawnBoard = next;
      await flushOutput?.call();
    }
  }

  String _clamp(String text, int width) {
    final tokens = <({String text, int width})>[];
    var index = 0;
    var join = false;
    var regional = false;
    while (index < text.length) {
      final sgr = _sgr.matchAsPrefix(text, index);
      if (sgr != null) {
        tokens.add((text: sgr.group(0)!, width: 0));
        index = sgr.end;
        continue;
      }
      final first = text.codeUnitAt(index++);
      final rune =
          first >= 0xd800 &&
              first <= 0xdbff &&
              index < text.length &&
              text.codeUnitAt(index) >= 0xdc00 &&
              text.codeUnitAt(index) <= 0xdfff
          ? 0x10000 + ((first - 0xd800) << 10) + text.codeUnitAt(index++) - 0xdc00
          : first;
      final value = String.fromCharCode(rune);
      final mark = _combining(rune) || rune == 0x200d || (rune >= 0x1f3fb && rune <= 0x1f3ff);
      final flag = rune >= 0x1f1e6 && rune <= 0x1f1ff;
      if (tokens.isNotEmpty && (mark || join || (flag && regional))) {
        final previous = tokens.removeLast();
        final runeWidth = _width(rune);
        tokens.add((text: '${previous.text}$value', width: previous.width > runeWidth ? previous.width : runeWidth));
      } else {
        tokens.add((text: value, width: _width(rune)));
      }
      join = rune == 0x200d;
      regional = flag && !regional;
    }
    final total = tokens.fold<int>(0, (sum, token) => sum + token.width);
    final buffer = StringBuffer();
    var used = 0;
    final limit = total > width ? width - 1 : width;
    for (final token in tokens) {
      if (used + token.width > limit) break;
      buffer.write(token.text);
      used += token.width;
    }
    if (total > width) buffer.write('…');
    if (color) buffer.write(_reset);
    return buffer.toString();
  }

  static bool _combining(int rune) => _marks.hasMatch(String.fromCharCode(rune));

  static int _width(int rune) {
    if (_combining(rune) || rune == 0x200d) return 0;
    return (rune >= 0x1100 && rune <= 0x115f) ||
            (rune >= 0x2329 && rune <= 0x232a) ||
            (rune >= 0x2e80 && rune <= 0xa4cf) ||
            (rune >= 0xac00 && rune <= 0xd7a3) ||
            (rune >= 0xf900 && rune <= 0xfaff) ||
            (rune >= 0xfe10 && rune <= 0xfe6f) ||
            (rune >= 0xff01 && rune <= 0xff60) ||
            (rune >= 0xffe0 && rune <= 0xffe6) ||
            (rune >= 0x1f000 && rune <= 0x1faff) ||
            (rune >= 0x20000 && rune <= 0x3fffd)
        ? 2
        : 1;
  }

  /// Drains pending lines and clears the board without closing supplied sinks.
  Future<void> close() {
    _closed = true;
    return _serialize(() async {
      final lines = <_Line>[];
      for (final entry in _jobs.entries) {
        // An interrupted owner's last partial progress remains useful context.
        // It must survive the final board erase along with pending diagnostics.
        entry.value.output.finish((fragment) => lines.add((label: entry.key, text: fragment.text, isError: false)));
        entry.value.errors.finish((fragment) => lines.add((label: entry.key, text: fragment.text, isError: true)));
      }
      _jobs.clear();
      await _render(lines, redraw: false);
      await flushOutput?.call();
      await flushErrors?.call();
      if (_writeError != null) Error.throwWithStackTrace(_writeError!, _writeStack!);
    });
  }
}

class _Job {
  _Job(this.compact);
  final bool compact;
  final output = _LineBuffer(), errors = _LineBuffer();
  var progress = 'starting';
}

class _LineBuffer {
  static const _maximum = 4096;
  final _filter = _AnsiFilter(color: true);
  final _pending = StringBuffer();
  var _carriage = false;
  String get pending => _pending.toString();

  void consume(String text, void Function(_Fragment) emit) => _filter.consume(text, (token) {
    if (_carriage) {
      _carriage = false;
      _emit(emit, carriage: token != '\n');
      if (token == '\n') return;
    }
    if (token == '\r') {
      _carriage = true;
    } else if (token == '\n') {
      _emit(emit);
    } else {
      if (_pending.length + token.length > _maximum) _emit(emit);
      _pending.write(token == '\t' ? '    ' : token);
    }
  });

  void _emit(void Function(_Fragment) emit, {bool carriage = false}) {
    emit((text: pending, carriage: carriage));
    _pending.clear();
  }

  void finish(void Function(_Fragment) emit) {
    _filter.finish((token) => _pending.write(token));
    if (_pending.isNotEmpty) _emit(emit, carriage: _carriage);
    _carriage = false;
  }

  void flush(void Function(_Fragment) emit) {
    if (_pending.isNotEmpty) _emit(emit);
    _carriage = false;
  }
}

class _AnsiFilter {
  _AnsiFilter({required this.color});
  static final _validSgr = RegExp(r'^\x1b\[[0-9;:]*m$');
  final bool color;
  var _state = _Escape.text;
  var _sequence = '';
  var _surrogate = '';

  void consume(String text, void Function(String) emit) {
    text = '$_surrogate$text';
    _surrogate = '';
    if (text.isNotEmpty && text.codeUnitAt(text.length - 1) >= 0xd800 && text.codeUnitAt(text.length - 1) <= 0xdbff) {
      _surrogate = text.substring(text.length - 1);
      text = text.substring(0, text.length - 1);
    }
    for (final rune in text.runes) {
      final char = String.fromCharCode(rune);
      switch (_state) {
        case _Escape.text:
          if (rune == 27) {
            _state = _Escape.escape;
          } else if (rune == 0x9b) {
            _state = _Escape.csi;
            _sequence = '\x1b[';
          } else if (rune == 0x9d || rune == 0x90 || rune == 0x98 || rune == 0x9e || rune == 0x9f) {
            _state = _Escape.string;
          } else if (rune == 9 || rune == 10 || rune == 13 || (rune >= 32 && (rune < 0x7f || rune > 0x9f))) {
            emit(char);
          }
        case _Escape.escape:
          if (char == '[') {
            _state = _Escape.csi;
            _sequence = '\x1b[';
          } else if (char == ']' || char == 'P' || char == 'X' || char == '^' || char == '_') {
            _state = _Escape.string;
          } else if (rune >= 0x30 && rune <= 0x7e) {
            _state = _Escape.text;
          }
        case _Escape.csi:
          if (_sequence.length < 128) {
            _sequence += char;
          } else {
            _sequence = '';
          }
          if (rune >= 0x40 && rune <= 0x7e) {
            if (color && _validSgr.hasMatch(_sequence)) emit(_sequence);
            _sequence = '';
            _state = _Escape.text;
          }
        case _Escape.string:
          if (rune == 7 || rune == 0x9c) {
            _state = _Escape.text;
          } else if (rune == 27) {
            _state = _Escape.stringEscape;
          }
        case _Escape.stringEscape:
          _state = char == '\\' || rune == 0x9c ? _Escape.text : _Escape.string;
      }
    }
  }

  void finish(void Function(String) emit) {
    if (_surrogate.isNotEmpty && _state == _Escape.text) emit('\ufffd');
    _surrogate = '';
    _sequence = '';
    _state = _Escape.text;
  }
}
