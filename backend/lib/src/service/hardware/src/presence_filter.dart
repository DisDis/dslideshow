import 'dart:async';

/// Presence is immediate; absence must remain stable before it is published.
class PresenceFilter {
  final Duration absenceDelay;
  final bool Function() readLevel;
  final void Function(bool present) onChanged;
  Timer? _absenceTimer;
  bool? _lastValue;
  bool _disposed = false;

  PresenceFilter({
    required this.absenceDelay,
    required this.readLevel,
    required this.onChanged,
  });

  void sample() {
    if (!_disposed) onLevel(readLevel());
  }

  void onLevel(bool present) {
    if (_disposed) return;
    if (present) {
      _absenceTimer?.cancel();
      _absenceTimer = null;
      _emit(true);
    } else if (_lastValue != false && _absenceTimer == null) {
      _absenceTimer = Timer(absenceDelay, () {
        _absenceTimer = null;
        if (!_disposed) _emit(readLevel());
      });
    }
  }

  void _emit(bool present) {
    if (_lastValue == present) return;
    _lastValue = present;
    onChanged(present);
  }

  void dispose() {
    _disposed = true;
    _absenceTimer?.cancel();
    _absenceTimer = null;
  }
}
