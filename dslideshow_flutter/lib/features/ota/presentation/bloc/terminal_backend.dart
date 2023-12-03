import 'package:xterm/xterm.dart';

class TerminalBackend {
  final Terminal terminal;
  TerminalBackend(this.terminal) {
    terminal.resize(120, terminal.viewHeight);
    terminal.setAutoWrapMode(true);
  }

  void onWrite(String data) {
    terminal.write(data);
  }
}
