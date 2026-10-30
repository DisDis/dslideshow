// Review evidence: the real Bloc cannot recover after a storage RPC failure.
import 'dart:async';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_event.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_state.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter_test/flutter_test.dart';

class _Frontend implements FrontendService {
  int attempts = 0;
  @override
  Stream<ButtonEvent> get onButtonEvent => const Stream.empty();
  @override
  Stream<bool> get onScreenStateChangePreparation => const Stream.empty();
  @override
  Stream<ActionWithParam> get onAction => const Stream.empty();
  @override
  Future<void> storageNext() async {
    attempts++;
    throw StateError('synthetic storage transport failure');
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  test('storage RPC failure leaves loadingNext blocking every retry', () async {
    final done = Completer<void>();
    final error = Completer<Object>();
    runZonedGuarded(
      () async {
        final frontend = _Frontend();
        final config = SlideShowConfig.fromJson({});
        final status = SlideshowStatusBloc(
          frontendService: frontend,
          config: config,
        );
        final bloc = SlideshowBloc(
          frontendService: frontend,
          config: config,
          statusBloc: status,
        );
        try {
          bloc.add(const SlideshowInitEvent());
          await error.future.timeout(const Duration(seconds: 5));
          expect(bloc.state.phase, SlideshowPhase.loadingNext);
          bloc.add(const SlideshowLoadNextEvent());
          final paused = bloc.stream.firstWhere((state) => state.isPaused);
          bloc.add(const SlideshowTogglePauseEvent(true));
          await paused;
          expect(frontend.attempts, 1);
          expect(bloc.state.phase, SlideshowPhase.loadingNext);
          done.complete();
        } catch (failure, stack) {
          done.completeError(failure, stack);
        } finally {
          await bloc.close();
          await status.close();
        }
      },
      (failure, stack) {
        if (!error.isCompleted)
          error.complete(failure);
        else if (!done.isCompleted)
          done.completeError(failure, stack);
      },
    );
    await done.future;
  });
}
