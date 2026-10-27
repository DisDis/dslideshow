import 'dart:async';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/buttons_hint/buttons_hint_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_event.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/pages/slideshow_page.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/fade_widget.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class TestFrontend implements FrontendService {
  final buttons = StreamController<ButtonEvent>.broadcast();
  final screens = StreamController<bool>.broadcast();
  final actions = StreamController<ActionWithParam>.broadcast();
  final screenTurns = <bool>[];
  final lockChanges = <bool>[];
  final locks = <Completer<RpcResult>>[];
  bool holdLocks = false;
  Completer<void>? turn;
  Completer<MediaItem>? media;
  int loads = 0;
  @override
  Stream<ButtonEvent> get onButtonEvent => buttons.stream;
  @override
  Stream<bool> get onScreenStateChangePreparation => screens.stream;
  @override
  Stream<ActionWithParam> get onAction => actions.stream;
  @override
  Future<void> updateFrontendState({bool? isPaused, bool? isMenu}) async {}

  @override
  Future<void> storageNext() async {
    loads++;
  }

  @override
  Future<MediaItem> getStorageCurrentItem() async =>
      media == null ? MediaItem.empty : await media!.future;
  @override
  Future<RpcResult> changeScreenLock(bool value) async {
    lockChanges.add(value);
    if (holdLocks) {
      final completion = Completer<RpcResult>();
      locks.add(completion);
      return completion.future;
    }
    return const EmptyResult(id: 1);
  }

  @override
  Future<RpcResult> screenTurn(bool value) async {
    screenTurns.add(value);
    await turn?.future;
    return const EmptyResult(id: 1);
  }

  Future<void> close() async {
    await buttons.close();
    await screens.close();
    await actions.close();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

// Keep the unrelated hint timer out of the screen renderer regression.
class HiddenHints extends Cubit<ButtonsHintState> implements ButtonsHintBloc {
  HiddenHints()
    : super(
        const ButtonsHintDisplayState(
          isShow: false,
          normalColor: Colors.white,
          pushColor: Colors.white,
          button0Icon: Icons.check,
          button0isPush: false,
          button1Icon: Icons.check,
          button1isPush: false,
          button2Icon: Icons.check,
          button2isPush: false,
          button3Icon: Icons.check,
          button3isPush: false,
        ),
      );
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class Fixture {
  final frontend = TestFrontend();
  final config = AppConfig.fromJson({
    'slideshow': {
      'effects': {
        'defaultDurationMs': 1000,
        'items': {
          'fade': {'enabled': true},
        },
      },
      'displayTimeMs': 5000,
      'fadeTimeMs': 2000,
    },
  });
  late final SlideshowStatusBloc status;
  late final SlideshowBloc slideshow;
  Fixture() {
    status = SlideshowStatusBloc(
      frontendService: frontend,
      config: config.slideshow,
    );
    slideshow = SlideshowBloc(
      frontendService: frontend,
      config: config.slideshow,
      statusBloc: status,
    );
  }
  Future<void> close() async {
    await slideshow.close();
    await status.close();
    await frontend.close();
  }
}

void main() {
  for (final initiallyAsleep in [false, true]) {
    testWidgets(
      'full wake fades from black${initiallyAsleep ? " when mounted asleep" : ""}',
      (tester) async {
        final f = Fixture();
        f.frontend.media = Completer<MediaItem>();
        if (initiallyAsleep) {
          f.slideshow.add(const SlideshowScreenStatePreparationEvent(false));
          await tester.pump();
        }
        injector.registerSingleton<AppConfig>(f.config);
        injector.registerSingleton<FrontendService>(f.frontend);
        final hints = HiddenHints();
        await tester.pumpWidget(
          MultiBlocProvider(
            providers: [
              BlocProvider<SlideshowBloc>.value(value: f.slideshow),
              BlocProvider<SlideshowStatusBloc>.value(value: f.status),
              BlocProvider<ButtonsHintBloc>.value(value: hints),
            ],
            child: const MaterialApp(home: SlideShowPage()),
          ),
        );
        await tester.pump();
        final fade = tester.widget<FadeWidget>(find.byType(FadeWidget));
        final animation = fade.listenable as Animation<double>;
        if (initiallyAsleep) {
          expect(animation.value, 1);
        } else {
          expect(animation.value, 0);
          f.frontend.screens.add(false);
          await tester.pump();
          await tester.pump(const Duration(seconds: 2));
          expect(animation.value, 1);
        }

        f.frontend.screens.add(true);
        await tester.pump();
        expect(animation.value, 1);
        await tester.pump(const Duration(milliseconds: 1000));
        expect(animation.value, closeTo(0.5, 0.01));
        f.frontend.screens.add(
          true,
        ); // A duplicate must not restart the reveal.
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 1000));
        expect(animation.value, 0);
        expect(f.slideshow.state.isScreenLocked, isFalse);

        // A new sleep can also reverse an unfinished fade-in smoothly.
        f.frontend.screens.add(false);
        await tester.pump();
        await tester.pump(const Duration(seconds: 2));
        f.frontend.screens.add(true);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));
        final before = animation.value;
        f.frontend.screens.add(false);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 250));
        expect(animation.value, greaterThan(before));
        await tester.pump(const Duration(seconds: 2));
        expect(animation.value, 1);
        expect(f.slideshow.state.isScreenLocked, isTrue);

        await tester.pumpWidget(const SizedBox.shrink());
        f.frontend.media!.complete(MediaItem.empty);
        await tester.pump();
        await tester.runAsync(hints.close);
        await tester.runAsync(f.close);
        await injector.reset();
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets(
    'ON immediately reverses fade and stale work never overrides a later OFF',
    (tester) async {
      final f = Fixture();
      f.slideshow.add(const SlideshowTransitionCompleteEvent());
      await tester.pump();
      f.slideshow.add(const SlideshowScreenStatePreparationEvent(false));
      await tester.pump();
      expect(f.slideshow.state.fadeOut, isTrue);
      expect(f.slideshow.state.isScreenLocked, isTrue);
      f.slideshow.add(const SlideshowScreenStatePreparationEvent(true));
      await tester.pump();
      expect(f.slideshow.state.fadeOut, isFalse);
      expect(f.slideshow.state.isScreenLocked, isFalse);
      f.slideshow.add(const SlideshowScreenStatePreparationEvent(false));
      await tester.pump();
      await tester.pump(const Duration(seconds: 4));
      expect(f.slideshow.state.fadeOut, isTrue);
      expect(f.slideshow.state.isScreenLocked, isTrue);
      expect(f.frontend.loads, 0);
      f.slideshow.add(const SlideshowScreenStatePreparationEvent(true));
      await tester.pump();
      expect(f.slideshow.state.fadeOut, isFalse);
      await tester.runAsync(f.close);
    },
  );

  testWidgets(
    'duplicate ON does not restart display deadline; pause survives wake',
    (tester) async {
      final f = Fixture();
      f.slideshow.add(const SlideshowInitEvent());
      await tester.pump();
      final initialLoads = f.frontend.loads;
      f.slideshow.add(const SlideshowTransitionCompleteEvent());
      await tester.pump();
      f.slideshow.add(const SlideshowScreenStatePreparationEvent(false));
      f.slideshow.add(const SlideshowScreenStatePreparationEvent(true));
      await tester.pump();
      await tester.pump(const Duration(seconds: 4));
      f.slideshow.add(const SlideshowScreenStatePreparationEvent(true));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      expect(f.frontend.loads, initialLoads + 1);
      f.slideshow.add(const SlideshowTogglePauseEvent(true));
      f.slideshow.add(const SlideshowScreenStatePreparationEvent(false));
      f.slideshow.add(const SlideshowScreenStatePreparationEvent(true));
      await tester.pump();
      await tester.pump(const Duration(seconds: 10));
      expect(f.slideshow.state.isPaused, isTrue);
      expect(f.slideshow.state.isScreenLocked, isFalse);
      expect(f.frontend.loads, initialLoads + 1);
      await tester.runAsync(f.close);
    },
  );

  testWidgets('manual lock response cannot send an obsolete OFF after unlock', (
    tester,
  ) async {
    final f = Fixture();
    f.frontend.holdLocks = true;
    f.status.add(const SlideshowScreenLockEvent(true));
    await tester.pump();
    f.status.add(const SlideshowScreenLockEvent(false));
    await tester.pump();
    expect(f.frontend.lockChanges, [true, false]);
    f.frontend.locks[1].complete(const EmptyResult(id: 2));
    await tester.pump();
    f.frontend.locks[0].complete(const EmptyResult(id: 1));
    await tester.pump();
    expect(f.frontend.screenTurns, [true]);
    expect(f.status.state.isScreenLock, isFalse);
    await tester.runAsync(f.close);
  });

  testWidgets('manual lock wins over an obsolete unlock response', (
    tester,
  ) async {
    final f = Fixture();
    f.frontend.holdLocks = true;
    f.status.add(const SlideshowScreenLockEvent(false));
    await tester.pump();
    f.status.add(const SlideshowScreenLockEvent(true));
    await tester.pump();
    f.frontend.locks[0].complete(const EmptyResult(id: 1));
    f.frontend.locks[1].complete(const EmptyResult(id: 2));
    await tester.pump();
    expect(f.frontend.screenTurns, [false]);
    expect(f.status.state.isScreenLock, isTrue);
    await tester.runAsync(f.close);
  });

  test(
    'closing during pending lock RPC suppresses its later screen command',
    () async {
      final f = Fixture();
      f.frontend.holdLocks = true;
      f.status.add(const SlideshowScreenLockEvent(true));
      await Future<void>.delayed(Duration.zero);
      await f.status.close();
      f.frontend.locks.single.complete(const EmptyResult(id: 1));
      await Future<void>.delayed(Duration.zero);
      expect(f.frontend.screenTurns, isEmpty);
      await f.slideshow.close();
      await f.frontend.close();
    },
  );

  test(
    'closing during media RPC does not wait for its obsolete response',
    () async {
      final f = Fixture();
      f.frontend.media = Completer<MediaItem>();
      f.slideshow.add(const SlideshowInitEvent());
      await Future<void>.delayed(Duration.zero);
      await f.slideshow.close();
      f.frontend.media!.complete(MediaItem.empty);
      await Future<void>.delayed(Duration.zero);
      expect(f.slideshow.isClosed, isTrue);
      await f.status.close();
      await f.frontend.close();
    },
  );

  test('closing during screen-turn RPC consumes a late failure', () async {
    final f = Fixture();
    f.frontend.turn = Completer<void>();
    f.status.add(const SlideshowScreenLockEvent(true));
    await Future<void>.delayed(Duration.zero);
    expect(f.frontend.screenTurns, [false]);
    await f.status.close();
    f.frontend.turn!.completeError(StateError('late screen reply'));
    await Future<void>.delayed(Duration.zero);
    await f.slideshow.close();
    await f.frontend.close();
  });

  test('closing during media RPC consumes its late failure', () async {
    final f = Fixture();
    f.frontend.media = Completer<MediaItem>();
    f.slideshow.add(const SlideshowInitEvent());
    await Future<void>.delayed(Duration.zero);
    await f.slideshow.close();
    f.frontend.media!.completeError(StateError('late media reply'));
    await Future<void>.delayed(Duration.zero);
    expect(f.slideshow.isClosed, isTrue);
    await f.status.close();
    await f.frontend.close();
  });

  testWidgets(
    'actual renderer reverses the black overlay from its current opacity',
    (tester) async {
      final f = Fixture();
      f.frontend.media = Completer<MediaItem>();
      injector.registerSingleton<AppConfig>(f.config);
      injector.registerSingleton<FrontendService>(f.frontend);
      final hints = HiddenHints();
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<SlideshowBloc>.value(value: f.slideshow),
            BlocProvider<SlideshowStatusBloc>.value(value: f.status),
            BlocProvider<ButtonsHintBloc>.value(value: hints),
          ],
          child: const MaterialApp(home: SlideShowPage()),
        ),
      );
      await tester.pump();
      f.frontend.screens.add(false);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      final fade = tester.widget<FadeWidget>(find.byType(FadeWidget));
      final animation = fade.listenable as Animation<double>;
      final before = animation.value;
      expect(before, greaterThan(0));
      expect(before, lessThan(1));
      f.frontend.screens.add(true);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 250));
      expect(animation.value, lessThan(before));
      await tester.pump(const Duration(seconds: 2));
      expect(animation.value, 0);
      f.frontend.screens.add(false);
      await tester.pump();
      await tester.pump(const Duration(seconds: 4));
      expect(animation.value, 1);
      expect(f.slideshow.state.isScreenLocked, isTrue);
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.runAsync(hints.close);
      f.frontend.media!.complete(MediaItem.empty);
      await tester.pump();
      await tester.runAsync(f.slideshow.close);
      await tester.runAsync(f.status.close);
      await tester.runAsync(f.frontend.close);
      await injector.reset();
      expect(tester.takeException(), isNull);
    },
  );
}
