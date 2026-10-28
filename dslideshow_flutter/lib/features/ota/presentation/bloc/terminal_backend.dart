import 'package:xterm/xterm.dart';

class TerminalBackend {
  final Terminal terminal;
  TerminalBackend(this.terminal) {
    terminal.resize(120, terminal.viewHeight);
    terminal.setAutoWrapMode(true);
    // Installer pipes use LF without a PTY's carriage-return conversion.
    terminal.setLineFeedMode(true);
  }

  void onWrite(String data) {
    terminal.write(data);
  }
}
