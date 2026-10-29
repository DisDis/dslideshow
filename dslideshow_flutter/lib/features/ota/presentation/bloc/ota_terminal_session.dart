import 'package:dslideshow_flutter/features/ota/presentation/bloc/terminal_backend.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:xterm/xterm.dart';

/// Owns one OTA log and its viewport for the lifetime of the page.
/// xterm itself follows new output until the user scrolls into history.
class OtaTerminalSession {
  OtaTerminalSession() : this._(Terminal(maxLines: 3000));

  OtaTerminalSession._(this.terminal) : backend = TerminalBackend(terminal) {
    scrollController.addListener(scheduleScrollStateUpdate);
  }

  final Terminal terminal;
  final TerminalBackend backend;
  final ScrollController scrollController = ScrollController();
  final _following = ValueNotifier(true);
  bool _updateScheduled = false;
  bool _disposed = false;

  bool get isFollowing => _following.value;
  ValueListenable<bool> get following => _following;

  /// Read dimensions after xterm has applied its stick-to-bottom policy.
  void scheduleScrollStateUpdate() {
    if (_disposed || _updateScheduled) return;
    _updateScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateScheduled = false;
      if (_disposed || !scrollController.hasClients) return;
      final position = scrollController.position;
      if (!position.hasContentDimensions) return;
      final following = position.pixels >= position.maxScrollExtent;
      _following.value = following;
    });
  }

  void followLatest() {
    if (_disposed || !scrollController.hasClients) return;
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
    scheduleScrollStateUpdate();
  }

  void dispose() {
    _disposed = true;
    scrollController.removeListener(scheduleScrollStateUpdate);
    scrollController.dispose();
    _following.dispose();
  }
}
