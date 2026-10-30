import 'dart:async';

import 'package:dslideshow_tools/src/process/console.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

final _sgr = RegExp(r'\x1b\[[0-9;:]*m');
final _cursor = RegExp(r'\x1b\[[0-?]*[ -/]*[A-LN-Za-ln-z]');
final _surrogate = RegExp(r'[\ud800-\udfff]', unicode: true);

String _plain(String text) => text.replaceAll(_sgr, '');

// The board redraw starts after erase-to-end; inspect its resulting rows.
String _frame(String text) {
  final index = text.lastIndexOf('\x1b[J');
  return _plain(index < 0 ? text : text.substring(index + 3)).trimRight();
}

void main() {
  test('plain output isolates partial lines, CRLF and streams without ANSI', () async {
    final out = StringBuffer(), err = StringBuffer();
    final console = BuildConsole(output: out, errors: err, color: false, interactive: true);
    expect(console.interactive, isFalse);
    await console.startJob('one', compact: true);
    await console.startJob('two');
    await console.writeChunk('one', 'first');
    await console.writeChunk('two', 'second\n');
    await console.writeChunk('one', ' line\r');
    await console.writeChunk('one', '\nnext\rfinal');
    await console.writeChunk('one', '\x1b[31mproblem\x1b[0m\n', isError: true);
    await console.finishJob('one');
    await console.finishJob('two');
    await console.close();
    expect(out.toString(), '[two] second\n[one] first line\n[one] next\n[one] final\n');
    expect(err.toString(), '[one] problem\n');
    expect('${out.toString()}$err', isNot(contains('\x1b')));
    expect(out.toString(), isNot(contains('\r')));
  });

  test('interactive jobs retain one separate progress row across split CR chunks', () async {
    final out = StringBuffer(), err = StringBuffer();
    final console = BuildConsole(output: out, errors: err, color: true, interactive: true);
    await console.startJob('tests:one', compact: true);
    await console.startJob('tests:two', compact: true);
    await console.writeChunk('tests:one', '\r00:00 +1: first');
    await console.writeChunk('tests:two', '00:00 +4: second\r');
    expect(_frame(out.toString()), '[tests:one] 00:00 +1: first\n[tests:two] 00:00 +4: second');
    await console.writeChunk('tests:one', '\r00:01 +2: later\r');
    expect(_frame(out.toString()), '[tests:one] 00:01 +2: later\n[tests:two] 00:00 +4: second');
    await console.finishJob('tests:one');
    expect(_frame(out.toString()), endsWith('[tests:two] 00:00 +4: second'));
    await console.finishJob('tests:two');
    final finished = out.toString();
    await console.close();
    expect(out.toString(), finished, reason: 'Finished jobs leave no active board to clear');
    expect(err.toString(), isEmpty);
  });

  test('LF context headers, prints and failures persist above the board', () async {
    final out = StringBuffer(), err = StringBuffer(), events = <String>[];
    final console = BuildConsole(
      output: out,
      errors: err,
      color: true,
      interactive: true,
      flushOutput: () async => events.add('out:${out.toString()}'),
      flushErrors: () async => events.add('err:${err.toString()}'),
    );
    await console.startJob('tests:one', compact: true);
    await console.writeChunk('tests:one', '00:00 +1: current\r');
    final beforeHeader = out.length;
    await console.writeChunk('tests:one', '\nprinted detail\n');
    expect(_plain(out.toString().substring(beforeHeader)), contains('[tests:one] 00:00 +1: current\n'));
    expect(_plain(out.toString()), contains('[tests:one] printed detail\n'));
    await console.writeChunk('tests:one', '00:01 +1 -1: full failure name [E]\r');
    await console.writeChunk('tests:one', '  expected red, saw black\n', isError: true);
    await console.writeLog(LogRecord(Level.SEVERE, 'action=tests result=failed', 'build'));
    await console.finishJob('tests:one');
    await console.close();
    expect(_plain(out.toString()), contains('[tests:one] 00:01 +1 -1: full failure name [E]\n'));
    expect(_plain(err.toString()), contains('expected red, saw black'));
    expect(_plain(err.toString()), contains('SEVERE build action=tests result=failed'));
    final diagnostic = events.indexWhere((event) => event.startsWith('err:') && event.contains('expected red'));
    expect(diagnostic, greaterThan(0));
    expect(events[diagnostic - 1], startsWith('out:'));
    expect(events[diagnostic - 1], contains('full failure name [E]'));
    expect(events.take(diagnostic).any((event) => event.startsWith('out:') && event.endsWith('\x1b[J')), isTrue);
  });

  test('nonprogress carriage text remains a diagnostic, not an ephemeral update', () async {
    final out = StringBuffer(), err = StringBuffer();
    final console = BuildConsole(output: out, errors: err, color: true, interactive: true);
    await console.startJob('tests:one', compact: true);
    await console.writeChunk('tests:one', 'configuration failed\rnext detail\n');
    await console.finishJob('tests:one');
    await console.close();
    expect(_plain(out.toString()), contains('[tests:one] configuration failed\n'));
    expect(_plain(out.toString()), contains('[tests:one] next detail\n'));
  });

  test('native progress padding before SGR reset neither clips the board nor wraps the final summary', () async {
    final out = StringBuffer(), err = StringBuffer();
    final console = BuildConsole(output: out, errors: err, color: true, interactive: true, columns: 65);
    final padding = ' ' * 180;
    await console.startJob('tests:one', compact: true);
    await console.writeChunk('tests:one', '\x1b[32m00:02 +3: short message$padding\x1b[0m\r');
    expect(_frame(out.toString()), '[tests:one] 00:02 +3: short message');
    expect(_frame(out.toString()), isNot(contains('…')));
    await console.writeChunk('tests:one', '\x1b[32m00:02 +3: All tests passed!$padding\x1b[0m\n');
    await console.writeChunk('tests:one', '  diagnostic keeps spaces    \x1b[0m\n');
    await console.writeChunk('tests:one', '  stack keeps spaces    \x1b[0m\n', isError: true);
    await console.finishJob('tests:one');
    await console.close();
    expect(_plain(out.toString()), contains('[tests:one] 00:02 +3: All tests passed!\n'));
    expect(out.toString(), contains('All tests passed!\x1b[0m\x1b[0m\n'));
    expect(_plain(out.toString()), contains('[tests:one]   diagnostic keeps spaces    \n'));
    expect(_plain(err.toString()), '[tests:one]   stack keeps spaces    \n');
  });

  test('split OSC and child cursor sequences are removed while complete SGR survives', () async {
    final out = StringBuffer(), err = StringBuffer();
    final console = BuildConsole(output: out, errors: err, color: true, interactive: false);
    await console.startJob('one');
    await console.writeChunk('one', '\x1b]8;;https://private.invalid/token');
    await console.writeChunk('one', '\x1b');
    await console.writeChunk('one', '\\safe\x1b]8;;\x07\x1b[2');
    await console.writeChunk('one', 'J\x1b[31');
    await console.writeChunk('one', 'm red\x1b[0m\x1b[10A\n');
    await console.close();
    expect(_plain(out.toString()), '[one] safe red\n');
    expect(out.toString(), contains('\x1b[31m'));
    expect(out.toString(), isNot(contains('private')));
    expect(_cursor.hasMatch(out.toString()), isFalse);
    expect(out.toString(), endsWith('\x1b[0m\n'));
  });

  test('forced colors use reset prefixes and own log statuses without a progress board', () async {
    final out = StringBuffer(), err = StringBuffer();
    final console = BuildConsole(output: out, errors: err, color: true, interactive: false);
    await console.startJob('one', compact: true);
    await console.writeChunk('one', 'line\n');
    for (final (level, status, code) in [
      (Level.INFO, 'passed', 32),
      (Level.INFO, 'cancelled', 33),
      (Level.SEVERE, 'failed', 31),
    ]) {
      await console.writeLog(LogRecord(level, 'result=$status', 'build'));
      expect(err.toString(), contains('\x1b[${code}m${level.name} build result=$status\x1b[0m'));
    }
    await console.close();
    expect(_plain(out.toString()), '[one] line\n');
    expect(out.toString(), contains('m[one]\x1b[0m '));
    expect(_cursor.hasMatch('$out$err'), isFalse);
  });

  test('build run token moves to the display suffix in both colored and plain logs', () async {
    const message = 'run=attempt_42 elapsedMs=17 job=tests:common action=finish result=passed';
    for (final color in [false, true]) {
      final out = StringBuffer(), err = StringBuffer();
      final console = BuildConsole(output: out, errors: err, color: color, interactive: false);
      final record = LogRecord(Level.INFO, message, 'build');
      await console.writeLog(record);
      await console.writeLog(LogRecord(Level.INFO, 'run=other action=report', 'testing'));
      await console.close();
      expect(
        _plain(err.toString()),
        'INFO build elapsedMs=17 job=tests:common action=finish result=passed run=attempt_42\n'
        'INFO testing run=other action=report\n',
      );
      expect(_plain(err.toString()), isNot(contains('INFO build run=')));
      expect(record.message, message, reason: 'Structured LogRecord messages retain their original ordering');
      if (color) {
        expect(err.toString(), contains('run=attempt_42\x1b[0m\x1b[0m\n'));
      } else {
        expect(err.toString(), isNot(contains('\x1b')));
      }
      expect(out.toString(), isEmpty);
    }
  });

  test('unicode board clipping preserves surrogate pairs, marks, emoji joins and SGR', () async {
    final out = StringBuffer(), err = StringBuffer();
    final console = BuildConsole(output: out, errors: err, color: true, interactive: true, columns: 23);
    await console.startJob('x', compact: true);
    await console.writeChunk('x', '00:00 +1: \x1b[31m👩\u200d💻e\u0301界long-long\r');
    final frame = _frame(out.toString());
    expect(frame, contains('👩\u200d💻e\u0301界'));
    expect(frame, endsWith('…'));
    expect(_surrogate.hasMatch(frame), isFalse);
    expect(out.toString(), endsWith('\x1b[0m\n'));
    await console.close();
  });

  test('long unterminated lines stream bounded fragments and close drains both streams', () async {
    final out = StringBuffer(), err = StringBuffer();
    var outputFlushes = 0, errorFlushes = 0;
    final console = BuildConsole(
      output: out,
      errors: err,
      color: false,
      interactive: false,
      flushOutput: () async => outputFlushes++,
      flushErrors: () async => errorFlushes++,
    );
    await console.startJob('one');
    await console.writeChunk('one', 'x' * 20000);
    expect(outputFlushes, greaterThan(0), reason: 'An unfinished line cannot grow without producing output');
    await console.writeChunk('one', 'error tail', isError: true);
    await console.close();
    final body = out.toString().replaceAll('[one] ', '').replaceAll('\n', '');
    expect(body, 'x' * 20000);
    expect(err.toString(), '[one] error tail\n');
    expect(errorFlushes, greaterThan(0));
    await expectLater(console.writeChunk('one', 'late'), throwsStateError);
    // The supplied sinks remain owned by the caller.
    out.write('caller still owns output');
    err.write('caller still owns errors');
  });

  test('queued writes and logs wait for an atomic flush without real delays', () async {
    final out = StringBuffer(), err = StringBuffer();
    final entered = Completer<void>(), release = Completer<void>();
    var first = true;
    final console = BuildConsole(
      output: out,
      errors: err,
      color: false,
      interactive: false,
      flushOutput: () async {
        if (first) {
          first = false;
          entered.complete();
          await release.future;
        }
      },
    );
    await console.startJob('one');
    await console.startJob('two');
    final firstWrite = console.writeChunk('one', 'first\n');
    await entered.future;
    final secondWrite = console.writeChunk('two', 'second\n');
    final log = console.writeLog(LogRecord(Level.INFO, 'result=passed', 'build'));
    expect(out.toString(), '[one] first\n');
    expect(err.toString(), isEmpty);
    release.complete();
    await Future.wait([firstWrite, secondWrite, log]);
    await console.close();
    expect(out.toString(), '[one] first\n[two] second\n');
    expect(err.toString(), 'INFO build result=passed\n');
  });

  test('close reports an already observed queued flush failure', () async {
    final failure = StateError('flush failure');
    var first = true;
    final console = BuildConsole(
      output: StringBuffer(),
      errors: StringBuffer(),
      color: false,
      interactive: false,
      flushOutput: () async {
        if (first) {
          first = false;
          throw failure;
        }
      },
    );
    await console.startJob('one');
    await expectLater(console.writeChunk('one', 'line\n'), throwsA(same(failure)));
    await expectLater(console.close(), throwsA(same(failure)));
  });

  test('close preserves interrupted partial progress and clears the active board', () async {
    final out = StringBuffer(), err = StringBuffer();
    final console = BuildConsole(output: out, errors: err, color: true, interactive: true);
    await console.startJob('tests:one', compact: true);
    await console.writeChunk('tests:one', '00:01 +2: unfinished test\r');
    await console.close();
    expect(_frame(out.toString()), '[tests:one] 00:01 +2: unfinished test');
    expect(out.toString(), endsWith('00:01 +2: unfinished test\x1b[0m\n'));
  });

  for (final (kind, partial) in [
    ('interrupted progress', '00:01 +2: interrupted test\r'),
    ('failure', '00:01 +2 -1: failure before LF [E]'),
    ('final summary', '00:01 +3: All tests passed!'),
  ]) {
    test('finish preserves $kind without a final newline', () async {
      final out = StringBuffer(), err = StringBuffer();
      final console = BuildConsole(output: out, errors: err, color: true, interactive: true);
      await console.startJob('tests:one', compact: true);
      await console.writeChunk('tests:one', partial);
      await console.finishJob('tests:one');
      expect(_frame(out.toString()), '[tests:one] ${partial.trimRight()}');
      await console.close();
    });
  }
}
