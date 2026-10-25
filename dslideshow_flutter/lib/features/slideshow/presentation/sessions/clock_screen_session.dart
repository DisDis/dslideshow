import 'dart:async';

import 'package:dslideshow_backend/config.dart';

import 'special_screen_session.dart';

class ClockScreenSession extends SpecialScreenSession {
  final DateTime Function() now;
  Timer? _timer;
  ClockScreenSession(super.config, {DateTime Function()? now})
    : now = now ?? DateTime.now;
  @override
  Future<bool> prepare() async => true;
  @override
  void setActive(bool value) {
    if (closed || active == value) return;
    super.setActive(value);
    _timer?.cancel();
    if (active && !closed) _schedule();
  }

  void _schedule() {
    final milliseconds = now().millisecondsSinceEpoch;
    final unit = (config.options as ClockScreenOptions).showSeconds
        ? 1000
        : 60000;
    _timer = Timer(Duration(milliseconds: unit - milliseconds % unit), () {
      if (closed || !active) return;
      notifyListeners();
      _schedule();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
