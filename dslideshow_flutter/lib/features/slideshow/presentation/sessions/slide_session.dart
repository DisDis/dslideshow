import 'dart:async';

import 'package:dslideshow_flutter/src/effect/effect_slide_input.dart';
import 'package:flutter/widgets.dart';

enum SlideSessionRole { pending, current, outgoing, incoming }

/// Owns one slide's resources independently of its views in a transition.
/// The renderer owns this session from creation, including during preparation.
abstract class SlideSession {
  Future<bool>? _preparation;
  Future<void>? _disposal;
  bool _disposed = false;

  bool get disposed => _disposed;
  Widget get view;

  /// Capture once before a transition; this session retains resource ownership.
  EffectSlideInput createEffectInput(Size size) => EffectSlideInput(view: view);
  bool get cancelPreparationOnSleep => false;

  Future<bool> prepare(BuildContext context) {
    if (_disposed) return Future.value(false);
    return _preparation ??= _prepare(context);
  }

  Future<bool> _prepare(BuildContext context) async {
    final ready = await prepareContents(context);
    return ready && !_disposed;
  }

  @protected
  Future<bool> prepareContents(BuildContext context);

  /// Called only after the renderer accepts this preparation's generation.
  void commitPreparation() {}

  void setActivity({
    required SlideSessionRole role,
    required bool playing,
    required bool screenOn,
  });

  /// Releases tickers, timers and images synchronously, then awaits native I/O.
  Future<void> dispose() {
    if (_disposal case final disposal?) return disposal;
    _disposed = true;
    return _disposal = Future<void>.sync(disposeResources);
  }

  @protected
  FutureOr<void> disposeResources();
}
