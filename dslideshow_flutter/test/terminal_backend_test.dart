import 'package:dslideshow_flutter/features/ota/presentation/bloc/terminal_backend.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xterm/xterm.dart';

void main() {
  late Terminal terminal;
  late TerminalBackend backend;

  setUp(() {
    terminal = Terminal();
    backend = TerminalBackend(terminal);
  });

  test('installer LF output starts each line in the first column', () {
    backend.onWrite('Reading package lists... Done\nUnpacking package\n');
    backend.onWrite('Setting up package\n');

    expect(_line(terminal, 0), 'Reading package lists... Done');
    expect(_line(terminal, 1), 'Unpacking package');
    expect(_line(terminal, 2), 'Setting up package');
    expect(_line(terminal, 3), isEmpty);
    expect(terminal.buffer.cursorX, 0);
  });

  test('CRLF split across output chunks produces one line break', () {
    backend.onWrite('Unpacking package\r');
    backend.onWrite('\nSetting up package\r');
    backend.onWrite('\nDone');

    expect(_line(terminal, 0), 'Unpacking package');
    expect(_line(terminal, 1), 'Setting up package');
    expect(_line(terminal, 2), 'Done');
    expect(_line(terminal, 3), isEmpty);
  });

  test('carriage return and ANSI erase update progress in place', () {
    backend.onWrite('Progress 100%');
    backend.onWrite('\r\x1b[2');
    backend.onWrite('K25%');

    expect(_line(terminal, 0), '25%');
    expect(_line(terminal, 1), isEmpty);
  });

  test('split ANSI sequences preserve color and LF positioning', () {
    backend.onWrite('\x1b[3');
    backend.onWrite('1mFailed');
    backend.onWrite('\x1b[0');
    backend.onWrite('m\nDone');

    expect(_line(terminal, 0), 'Failed');
    expect(_line(terminal, 1), 'Done');
    expect(terminal.buffer.lines[0].getForeground(0), CellColor.named | 1);
    expect(terminal.buffer.lines[1].getForeground(0), CellColor.normal);
  });

  test('long output still wraps before the next LF-delimited line', () {
    terminal.resize(12, terminal.viewHeight);

    backend.onWrite('Unpacking package\nDone');

    expect(_line(terminal, 0), 'Unpacking pa');
    expect(_line(terminal, 1), 'ckage');
    expect(_line(terminal, 2), 'Done');
  });
}

// BufferLine.getText skips empty cells, hiding incorrectly indented output.
// Preserve their columns so assertions match what the terminal displays.
String _line(Terminal terminal, int row) {
  final line = terminal.buffer.lines[row];
  return String.fromCharCodes([
    for (var column = 0; column < terminal.viewWidth; column++)
      line.getCodePoint(column) == 0 ? 0x20 : line.getCodePoint(column),
  ]).trimRight();
}
