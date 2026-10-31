import 'dart:async';
import 'dart:io';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_event.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_slide.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_state.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;

import 'support/slideshow_frontend.dart';

MediaItem _media(String name) => MediaItem(name, path.toUri(path.join(Directory.systemTemp.path, '$name.jpg')));

RpcErrorResultException _backendError() =>
    RpcErrorResultException(const ErrorResult(id: 1, error: 'storage unavailable'));

class _Fixture {
  _Fixture(WidgetTester tester) {
    addTearDown(() => tester.runAsync(close));
  }

  bool _closed = false;
  final frontend = TestFrontend();
  final config = SlideShowConfig.fromJson({'displayTimeMs': 1000000});
  late final status = SlideshowStatusBloc(frontendService: frontend, config: config);
  late final bloc = SlideshowBloc(frontendService: frontend, config: config, statusBloc: status);

  Future<void> close() async {
    if (_closed) return;
    _closed = true;
    await bloc.close();
    await status.close();
    await frontend.close();
  }

  Future<void> displayFirst(WidgetTester tester) async {
    frontend.media = Completer<MediaItem>()..complete(_media('first'));
    bloc.add(const SlideshowInitEvent());
    await tester.pump();
    expect(bloc.state.phase, SlideshowPhase.precaching);
    bloc.add(const SlideshowImageReadyEvent());
    await tester.pump();
    bloc.add(const SlideshowTransitionCompleteEvent());
    await tester.pump();
    expect(bloc.state.phase, SlideshowPhase.display);
  }
}

void main() {
  for (final failAdvance in [true, false]) {
    testWidgets('${failAdvance ? 'advance' : 'current read'} error keeps the slide without automatic requests', (
      tester,
    ) async {
      final records = <LogRecord>[];
      final level = Logger.root.level;
      Logger.root.level = Level.ALL;
      final subscription = Logger.root.onRecord.listen(records.add);
      addTearDown(() async {
        await subscription.cancel();
        Logger.root.level = level;
      });
      final f = _Fixture(tester);
      await f.displayFirst(tester);
      final current = f.bloc.state.currentSlide;
      const privateFailure = 'private-authorized-url?code=private-code';
      final failure = RpcErrorResultException(const ErrorResult(id: 1, error: privateFailure));
      if (failAdvance) {
        f.frontend.onStorageNext = () => Future.error(failure);
      } else {
        f.frontend.onReadStorageCurrent = () => Future.error(failure);
      }
      f.bloc.add(const SlideshowLoadNextEvent());
      await tester.pump();
      expect(f.bloc.state.phase, SlideshowPhase.error);
      expect(f.bloc.state.currentSlide, same(current));
      expect(f.bloc.state.nextSlide, isNull);
      final loads = f.frontend.loads;
      final reads = f.frontend.reads;
      f.frontend.onStorageNext = null;
      f.frontend.onReadStorageCurrent = () async => _media('second');
      // Neither the old display deadline nor a queued timer event restarts loading.
      f.bloc.add(const SlideshowTimerCompleteEvent());
      await tester.pump(const Duration(hours: 1));
      f.bloc.add(const SlideshowTogglePauseEvent(true));
      f.bloc.add(const SlideshowScreenStatePreparationEvent(false));
      await tester.pump();
      f.bloc.add(const SlideshowTogglePauseEvent(false));
      f.bloc.add(const SlideshowScreenStatePreparationEvent(true));
      await tester.pump();
      await tester.pump(const Duration(minutes: 1));
      expect(f.frontend.loads, loads);
      expect(f.frontend.reads, reads);
      expect(f.bloc.state.phase, SlideshowPhase.error);
      expect(f.bloc.state.currentSlide, same(current));
      final own = records.where((record) => record.loggerName == 'SlideshowBloc');
      final failed = own.singleWhere((record) => record.message.startsWith('event=loadFailed '));
      expect(failed.level, Level.WARNING);
      expect(failed.message, contains('type=RpcErrorResultException'));
      expect(failed.error, same(failure));
      expect(failed.error.toString(), contains(privateFailure));
      expect(failed.stackTrace, isNotNull);
      // A new explicit event uses the ordinary loading path, with no saved failed step.
      f.bloc.add(const SlideshowLoadNextEvent());
      await tester.pump();
      expect(f.frontend.loads, loads + 1);
      expect(f.frontend.reads, reads + 1);
      expect(f.bloc.state.phase, SlideshowPhase.precaching);
      expect(f.bloc.state.currentSlide, same(current));
      expect((f.bloc.state.nextSlide as MediaSlide).item.id, 'second');
      expect(own.where((record) => record.message == 'event=loadCompleted'), hasLength(2));
      expect(tester.takeException(), isNull);
      await tester.runAsync(f.close);
    });
  }

  testWidgets('backend error result stops before reading current and stays failed without a first slide', (
    tester,
  ) async {
    final f = _Fixture(tester);
    f.frontend.onStorageNext = () async => const ErrorResult(id: 3, error: 'storage unavailable');
    f.bloc.add(const SlideshowInitEvent());
    await tester.pump();
    expect(f.bloc.state.phase, SlideshowPhase.error);
    expect(f.bloc.state.currentSlide, isNull);
    for (final event in [
      const SlideshowTogglePauseEvent(true),
      const SlideshowTogglePauseEvent(false),
      const SlideshowScreenStatePreparationEvent(false),
      const SlideshowScreenStatePreparationEvent(true),
    ]) {
      f.bloc.add(event);
      await tester.pump();
    }
    await tester.pump(const Duration(hours: 1));
    expect(f.frontend.loads, 1);
    expect(f.frontend.reads, 0);
    expect(f.bloc.state.phase, SlideshowPhase.error);
    await tester.runAsync(f.close);
  });

  for (final awaitingAdvance in [true, false]) {
    testWidgets('loading phase ignores duplicate events during ${awaitingAdvance ? 'advance' : 'current read'}', (
      tester,
    ) async {
      final f = _Fixture(tester);
      final advance = Completer<void>();
      final current = Completer<MediaItem>();
      if (awaitingAdvance) {
        f.frontend.onStorageNext = () => advance.future;
      } else {
        f.frontend.onReadStorageCurrent = () => current.future;
      }
      f.bloc.add(const SlideshowInitEvent());
      await tester.pump();
      f.bloc.add(const SlideshowLoadNextEvent());
      f.bloc.add(const SlideshowLoadNextEvent());
      f.bloc.add(const SlideshowTimerCompleteEvent());
      await tester.pump();
      expect(f.bloc.state.phase, SlideshowPhase.loadingNext);
      expect(f.frontend.loads, 1);
      expect(f.frontend.reads, awaitingAdvance ? 0 : 1);
      if (awaitingAdvance) {
        advance.complete();
      } else {
        current.complete(_media('next'));
      }
      await tester.pump();
      expect(f.frontend.loads, 1);
      expect(f.frontend.reads, 1);
      expect(f.bloc.state.phase, SlideshowPhase.precaching);
      await tester.runAsync(f.close);
    });

    for (final failLate in [false, true]) {
      testWidgets(
        'close during ${awaitingAdvance ? 'advance' : 'read'} consumes a late ${failLate ? 'error' : 'result'}',
        (tester) async {
          final f = _Fixture(tester);
          final pending = Completer<MediaItem>();
          if (awaitingAdvance) {
            f.frontend.onStorageNext = () => pending.future;
          } else {
            f.frontend.onReadStorageCurrent = () => pending.future;
          }
          f.bloc.add(const SlideshowInitEvent());
          await tester.pump();
          expect(f.bloc.state.phase, SlideshowPhase.loadingNext);
          await tester.runAsync(f.close);
          final closed = f.bloc.state;
          if (failLate) {
            pending.completeError(_backendError());
          } else {
            pending.complete(MediaItem.empty);
          }
          await tester.pump();
          await tester.pump(const Duration(minutes: 1));
          expect(f.bloc.state, same(closed));
          expect(f.frontend.loads, 1);
          expect(f.frontend.reads, awaitingAdvance ? 0 : 1);
          expect(tester.takeException(), isNull);
        },
      );
    }
  }
}
