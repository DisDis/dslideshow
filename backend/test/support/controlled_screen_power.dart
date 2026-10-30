import 'dart:async';

import 'package:dslideshow_backend/src/service/hardware/src/screen_power.dart';

class ControlledPower implements ScreenPower {
  final calls = <bool>[];
  final pending = <Completer<void>>[];
  bool automatic = true;
  bool fail = false;
  int active = 0;
  int maxActive = 0;

  @override
  Future<void> setPower(bool enabled) async {
    calls.add(enabled);
    active++;
    if (active > maxActive) maxActive = active;
    try {
      if (fail) throw StateError('hardware failure');
      if (!automatic) {
        final completion = Completer<void>();
        pending.add(completion);
        await completion.future;
      }
    } finally {
      active--;
    }
  }
}
