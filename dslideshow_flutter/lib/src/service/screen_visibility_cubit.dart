import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'frontend.dart';

/// Replays backend visibility for routes created after an OFF notification.
class ScreenVisibilityCubit extends Cubit<bool> {
  ScreenVisibilityCubit(FrontendService frontend) : super(frontend.isScreenVisible) {
    _subscription = frontend.onScreenStateChangePreparation.listen(emit);
  }

  late final StreamSubscription<bool> _subscription;

  @override
  Future<void> close() async {
    await _subscription.cancel();
    await super.close();
  }
}

/// Covers every route, including overlays, while the backend keeps the screen asleep.
class ScreenVisibility extends StatelessWidget {
  const ScreenVisibility({super.key, required this.child, this.fadeDuration = Duration.zero});
  final Widget child;
  final Duration fadeDuration;

  @override
  Widget build(BuildContext context) => BlocBuilder<ScreenVisibilityCubit, bool>(
    builder: (_, visible) => Stack(
      fit: StackFit.expand,
      children: [
        child,
        Positioned.fill(
          child: IgnorePointer(
            ignoring: visible,
            child: AnimatedOpacity(
              duration: fadeDuration,
              opacity: visible ? 0 : 1,
              child: const ColoredBox(color: Colors.black),
            ),
          ),
        ),
      ],
    ),
  );
}
