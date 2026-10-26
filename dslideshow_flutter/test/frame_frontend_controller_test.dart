import 'dart:async';
import 'dart:ui';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_common/version.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:dslideshow_flutter/src/route_bloc.dart';
import 'package:dslideshow_flutter/src/service/frame_frontend_controller.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter_test/flutter_test.dart';

class RecordingFrontend implements FrontendService {
  final actions = StreamController<ActionWithParam>.broadcast();
  final updates = <({bool? paused, bool? menu})>[];
  final locks = <bool>[];
  final screenTurns = <bool>[];
  Completer<RpcResult>? lockResult;
  Completer<RpcResult>? turnResult;
  Object? lockFailure;
  Object? turnFailure;
  bool failUpdates = false;

  @override
  Stream<ActionWithParam> get onAction => actions.stream;

  @override
  Future<void> updateFrontendState({bool? isPaused, bool? isMenu}) async {
    updates.add((paused: isPaused, menu: isMenu));
    if (failUpdates) throw StateError('Backend disconnected');
  }

  @override
  Future<RpcResult> changeScreenLock(bool value) async {
    locks.add(value);
    if (lockFailure != null) throw lockFailure!;
    return await lockResult?.future ?? const EmptyResult(id: 1);
  }

  @override
  Future<RpcResult> screenTurn(bool value) async {
    screenTurns.add(value);
    if (turnFailure != null) throw turnFailure!;
    return await turnResult?.future ?? const EmptyResult(id: 2);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class StalledStatus extends SlideshowStatusBloc {
  StalledStatus(FrontendService frontend)
    : super(
        frontendService: frontend,
        config: AppConfig.fromJson({}).slideshow,
      );

  @override
  void add(SlideshowStatusEvent event) {}
}

class Fixture {
  final frontend = RecordingFrontend();
  final route = RouteBloc();
  late final status = SlideshowStatusBloc(
    frontendService: frontend,
    config: AppConfig.fromJson({}).slideshow,
  );
  late final controller = FrameFrontendController(
    statusBloc: () => status,
    routeBloc: () => route,
    displayInfo: () => const FrameDisplayInfo(
      physicalWidth: 2560,
      physicalHeight: 1600,
      logicalWidth: 1280,
      logicalHeight: 800,
      pixelRatio: 2,
    ),
  );

  Future<void> showPage(RoutePage page) async {
    route.add(ChangePageEvent(page));
    await Future<void>.delayed(Duration.zero);
  }

  Future<void> close() async {
    await status.close();
    await route.close();
    await frontend.actions.close();
  }
}

void main() {
  test('snapshot reads live status, route and frame display', () async {
    final f = Fixture();
    addTearDown(f.close);
    for (final page in RoutePage.values) {
      await f.showPage(page);
      final snapshot = f.controller.readState();
      expect(snapshot.page, switch (page) {
        RoutePage.welcome => FramePage.welcome,
        RoutePage.slideshow => FramePage.slideshow,
        RoutePage.config => FramePage.config,
        RoutePage.ota => FramePage.ota,
      });
      expect(snapshot.frontendVersion, ApplicationInfo.frontendVersion);
      expect(snapshot.display!.physicalWidth, 2560);
      expect(snapshot.display!.logicalHeight, 800);
    }
    f.status.add(const SlideshowPauseEvent(true));
    f.status.add(const SlideshowMenuEvent(true));
    await Future<void>.delayed(Duration.zero);
    expect(f.controller.readState().isPaused, isTrue);
    expect(f.controller.readState().isMenu, isTrue);
  });

  test(
    'pause and menu are explicit and acknowledge the applied state',
    () async {
      final f = Fixture();
      addTearDown(f.close);
      await f.showPage(RoutePage.slideshow);
      await f.controller.setControl(FrameControl.pause, true);
      expect(f.status.state.isPaused, isTrue);
      await f.controller.setControl(FrameControl.pause, true);
      expect(f.status.state.isPaused, isTrue);
      await f.controller.setControl(FrameControl.menu, true);
      expect(f.status.state.isMenu, isTrue);
      await f.controller.setControl(FrameControl.menu, false);
      expect(f.status.state.isMenu, isFalse);
      await f.controller.setControl(FrameControl.pause, false);
      expect(f.status.state.isPaused, isFalse);
      expect(f.frontend.updates, [
        (paused: true, menu: null),
        (paused: null, menu: true),
        (paused: null, menu: false),
        (paused: false, menu: null),
      ]);
    },
  );

  test(
    'direct menu close and MQTT actions publish actual state once',
    () async {
      final f = Fixture();
      addTearDown(f.close);
      f.controller
          .readState(); // Start the status subscription before the event.
      f.frontend.actions.add(
        const ActionWithParam(action: SlideshowAction.showMenu, param: true),
      );
      await Future<void>.delayed(Duration.zero);
      f.status.add(const SlideshowMenuEvent(false));
      f.status.add(const SlideshowMenuEvent(false));
      f.status.add(const SlideshowPauseEvent(true));
      await Future<void>.delayed(Duration.zero);
      expect(f.frontend.updates, [
        (paused: null, menu: true),
        (paused: null, menu: false),
        (paused: true, menu: null),
      ]);
      expect(f.controller.readState().isMenu, isFalse);
    },
  );

  test(
    'backend publication failure does not undo local state or fail commands',
    () async {
      final f = Fixture();
      addTearDown(f.close);
      f.frontend.failUpdates = true;
      await f.showPage(RoutePage.slideshow);
      await f.controller.setControl(FrameControl.pause, true);
      expect(f.status.state.isPaused, isTrue);
      await Future<void>.delayed(Duration.zero);
    },
  );

  test(
    'pause/menu reject non-slideshow routes without changing state',
    () async {
      final f = Fixture();
      addTearDown(f.close);
      for (final page in [RoutePage.welcome, RoutePage.config, RoutePage.ota]) {
        await f.showPage(page);
        for (final control in [FrameControl.pause, FrameControl.menu]) {
          await expectLater(
            f.controller.setControl(control, true),
            throwsStateError,
          );
        }
        expect(f.status.state.isPaused, isFalse);
        expect(f.status.state.isMenu, isFalse);
      }
      expect(f.frontend.updates, isEmpty);
    },
  );

  test('screen controls acknowledge both backend RPCs without waiting for native work', () async {
    final f = Fixture();
    addTearDown(f.close);
    f.frontend.lockResult = Completer<RpcResult>();
    f.frontend.turnResult = Completer<RpcResult>();
    var accepted = false;
    final command = f.controller.setControl(FrameControl.screen, false)
      ..then((_) => accepted = true);
    await Future<void>.delayed(Duration.zero);
    expect(f.status.state.isScreenLock, isTrue);
    expect(f.frontend.locks, [true]);
    expect(f.frontend.screenTurns, isEmpty);
    expect(accepted, isFalse);
    f.frontend.lockResult!.complete(const EmptyResult(id: 1));
    await Future<void>.delayed(Duration.zero);
    expect(f.frontend.screenTurns, [false]);
    expect(accepted, isFalse);
    f.frontend.turnResult!.complete(const EmptyResult(id: 2));
    await command;
    expect(accepted, isTrue);
    f.frontend.lockResult = null;
    f.frontend.turnResult = null;
    await f.controller.setControl(FrameControl.screen, true);
    expect(f.status.state.isScreenLock, isFalse);
    expect(f.frontend.locks, [true, false]);
    expect(f.frontend.screenTurns, [false, true]);
    // An explicit ON also wakes a sensor-slept screen with no manual lock.
    await f.controller.setControl(FrameControl.screen, true);
    expect(f.frontend.screenTurns, [false, true, true]);
  });

  for (final lockFails in [true, false]) {
    test(
      'screen ${lockFails ? 'lock' : 'turn'} RPC failures reach the caller',
      () async {
        final f = Fixture();
        addTearDown(f.close);
        final failure = StateError('Backend rejected screen intent');
        if (lockFails) {
          f.frontend.lockFailure = failure;
        } else {
          f.frontend.turnFailure = failure;
        }
        await expectLater(
          f.controller.setControl(FrameControl.screen, false),
          throwsA(same(failure)),
        );
        expect(f.frontend.screenTurns, lockFails ? isEmpty : [false]);
      },
    );

    test(
      'screen ${lockFails ? 'lock' : 'turn'} RPC error results reject control',
      () async {
        final f = Fixture();
        addTearDown(f.close);
        final rejection = Completer<RpcResult>();
        if (lockFails) {
          f.frontend.lockResult = rejection;
        } else {
          f.frontend.turnResult = rejection;
        }
        final command = f.controller.setControl(FrameControl.screen, false);
        final expectation = expectLater(
          command,
          throwsA(isA<RpcErrorResultException>()),
        );
        await Future<void>.delayed(Duration.zero);
        rejection.complete(const ErrorResult(id: 1, error: 'Rejected'));
        await expectation;
      },
    );

    test(
      'screen ${lockFails ? 'lock' : 'turn'} rejects unexpected acknowledgements',
      () async {
        final f = Fixture();
        addTearDown(f.close);
        final unexpected = Completer<RpcResult>();
        if (lockFails) {
          f.frontend.lockResult = unexpected;
        } else {
          f.frontend.turnResult = unexpected;
        }
        final command = f.controller.setControl(FrameControl.screen, false);
        final expectation = expectLater(command, throwsStateError);
        await Future<void>.delayed(Duration.zero);
        unexpected.complete(
          const EchoCommandResult(id: 1, resultText: 'Wrong response'),
        );
        await expectation;
      },
    );

    test(
      'closing during screen ${lockFails ? 'lock' : 'turn'} RPC rejects the waiter',
      () async {
        final f = Fixture();
        final pending = Completer<RpcResult>();
        if (lockFails) {
          f.frontend.lockResult = pending;
        } else {
          f.frontend.turnResult = pending;
        }
        final command = f.controller.setControl(FrameControl.screen, false);
        final expectation = expectLater(command, throwsStateError);
        await Future<void>.delayed(Duration.zero);
        await f.status.close();
        await expectation;
        pending.completeError(StateError('Late backend failure'));
        await Future<void>.delayed(Duration.zero);
        await f.close();
      },
    );

    test(
      'ordinary screen ${lockFails ? 'lock' : 'turn'} failure is handled',
      () async {
        final f = Fixture();
        addTearDown(f.close);
        if (lockFails) {
          f.frontend.lockFailure = StateError('Lock rejected');
        } else {
          f.frontend.turnFailure = StateError('Turn rejected');
        }
        f.status.executeAction(SlideshowAction.toggleScreen, true);
        await Future<void>.delayed(Duration.zero);
        expect(f.frontend.locks, [true]);
      },
    );
  }

  test('superseded screen waiter ends before its late lock response', () async {
    final f = Fixture();
    addTearDown(f.close);
    final previousLock = Completer<RpcResult>();
    f.frontend.lockResult = previousLock;
    final previous = f.controller.setControl(FrameControl.screen, false);
    final previousExpectation = expectLater(previous, throwsStateError);
    await Future<void>.delayed(Duration.zero);
    f.frontend.lockResult = null;
    await f.controller.setControl(FrameControl.screen, true);
    await previousExpectation;
    previousLock.complete(const EmptyResult(id: 1));
    await Future<void>.delayed(Duration.zero);
    expect(f.frontend.screenTurns, [true]);
  });

  test(
    'superseded screen turn cannot hide a later failure or remain pending',
    () async {
      final f = Fixture();
      addTearDown(f.close);
      final previousTurn = Completer<RpcResult>();
      f.frontend.turnResult = previousTurn;
      final previous = f.controller.setControl(FrameControl.screen, false);
      final previousExpectation = expectLater(previous, throwsStateError);
      await Future<void>.delayed(Duration.zero);
      f.frontend.turnResult = null;
      await f.controller.setControl(FrameControl.screen, true);
      await previousExpectation;
      previousTurn.completeError(StateError('Late obsolete failure'));
      await Future<void>.delayed(Duration.zero);
      expect(f.frontend.screenTurns, [false, true]);
    },
  );

  test(
    'closing cancels queued acknowledgements and rejects later commands',
    () async {
      final f = Fixture();
      await f.showPage(RoutePage.slideshow);
      final command = f.controller.setControl(FrameControl.pause, true);
      final expectation = expectLater(command, throwsStateError);
      await f.status.close();
      await expectation;
      await expectLater(
        f.controller.setControl(FrameControl.menu, true),
        throwsStateError,
      );
      expect(f.controller.readState, throwsStateError);
      await f.route.close();
      await f.frontend.actions.close();
    },
  );

  test(
    'an unhandled control has a bounded wait and releases on close',
    () async {
      final frontend = RecordingFrontend();
      final status = StalledStatus(frontend);
      await expectLater(
        status.executeActionAndWait(
          SlideshowAction.pause,
          true,
          timeout: const Duration(milliseconds: 1),
        ),
        throwsA(isA<TimeoutException>()),
      );
      await status.close();
      await frontend.actions.close();
    },
  );

  testWidgets('default display provider uses frame view geometry', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(2560, 1600);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final display = FrameFrontendController.readDisplayInfo()!;
    expect(display.physicalWidth, 2560);
    expect(display.physicalHeight, 1600);
    expect(display.logicalWidth, 1280);
    expect(display.logicalHeight, 800);
    expect(display.pixelRatio, 2);
  });
}
