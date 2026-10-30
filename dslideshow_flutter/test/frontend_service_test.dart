import 'dart:async';
import 'dart:ui' show Size;

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_flutter/src/route_bloc.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';

import 'support/frontend_remote.dart';
import 'support/ota_frontend.dart' show otaSystemInfo;

void frontendTest(String name, Future<void> Function(WidgetTester, FrontendHarness) body) {
  testWidgets(name, (tester) async {
    final h = FrontendHarness();
    try {
      await body(tester, h);
    } finally {
      await tester.runAsync(h.close);
    }
  });
}

void main() {
  frontendTest('storage facade keeps concurrent current and next responses separate and propagates failure', (
    tester,
    h,
  ) async {
    final current = h.frontend.getStorageCurrentItem();
    final next = h.frontend.getStorageNextItem();
    final advance = h.frontend.storageNext();
    final reads = h.backend.requests.whereType<GetMediaItemCommand>().toList();
    expect(reads.map((command) => command.isCurrent), [true, false]);
    expect(reads.map((command) => command.id).toSet(), hasLength(2));
    final advanceCommand = h.backend.requests.whereType<StorageNextCommand>().single;
    final failed = expectLater(advance, throwsA(isA<RpcErrorResultException>()));
    h.backend.respond(advanceCommand, ErrorResult(id: advanceCommand.id, error: 'advance rejected'));
    h.backend.respond(
      reads.last,
      GetMediaItemCommandResult(id: reads.last.id, mediaId: 'next', mediaUri: Uri.file('/next.jpg')),
    );
    h.backend.respond(
      reads.first,
      GetMediaItemCommandResult(id: reads.first.id, mediaId: 'current', mediaUri: Uri.file('/current.jpg')),
    );
    expect((await next).id, 'next');
    expect((await current).uri, Uri.file('/current.jpg'));
    await failed;
    expect(h.backend.requests.whereType<StorageNextCommand>(), hasLength(1));
  });

  frontendTest('periodic SystemInfo polling reports backend errors and updates live status', (tester, h) async {
    final records = <LogRecord>[];
    final oldLevel = Logger.root.level;
    Logger.root.level = Level.ALL;
    final logs = Logger.root.onRecord.where((record) => record.loggerName == 'FrontendService').listen(records.add);
    addTearDown(() async {
      await logs.cancel();
      Logger.root.level = oldLevel;
    });
    final events = <SystemInfo>[];
    final updates = h.frontend.onSystemInfoUpdate.listen(events.add);
    addTearDown(updates.cancel);
    final first = h.backend.requests.whereType<GetSystemInfoCommand>().single;
    expect(h.backend.requests.whereType<GetSystemInfoCommand>(), hasLength(1));
    h.backend.respond(first, ErrorResult(id: first.id, error: 'https://secret-code/private'));
    await tester.pump();
    expect(events, isEmpty);
    await tester.pump(const Duration(minutes: 1));
    expect(h.backend.requests.whereType<GetSystemInfoCommand>(), hasLength(2));
    final second = h.backend.requests.whereType<GetSystemInfoCommand>().last;
    expect(second.id, isNot(first.id));
    final info = otaSystemInfo().copyWith(networkInfo: otaSystemInfo().networkInfo.copyWith(hasInternet: false));
    h.backend.respond(second, GetSystemInfoCommandResult(id: second.id, systemInfo: info));
    await tester.pump();
    expect(events, [info]);
    expect(h.status.state.hasInternet, isFalse);
    expect(
      records.any((record) => record.level == Level.WARNING && record.message.startsWith('systemInfo failed')),
      isTrue,
    );
    expect(records.any((record) => record.message.startsWith('systemInfo completed')), isTrue);
    expect(records.every((record) => record.error == null && !record.message.contains('secret-code')), isTrue);
  });

  frontendTest('disposal cancels timer and pending local waits, consuming late external failures', (tester, h) async {
    final events = <SystemInfo>[];
    var done = false;
    h.frontend.onSystemInfoUpdate.listen(events.add, onDone: () => done = true);
    final read = h.frontend.getStorageCurrentItem();
    final closedRead = expectLater(read, throwsStateError);
    final pending = List<RpcCommand>.of(h.backend.requests);
    await tester.runAsync(h.close);
    await closedRead;
    expect(done, isTrue);
    for (final request in pending) {
      h.backend.fail(request, StateError('late private response'));
    }
    await tester.pump(const Duration(minutes: 5));
    expect(h.backend.requests, hasLength(pending.length));
    expect(events, isEmpty);
    await expectLater(h.frontend.storageNext(), throwsStateError);
    final response = await h.rpc.executeCommand(
      const ButtonChangeStateCommand(
        id: 42,
        button: ButtonType.button1,
        event: ButtonEventType.released,
        durationMs: 300,
      ),
    );
    expect(response, isA<ErrorResult>().having((result) => result.id, 'request ID', 42));
    for (final command in [
      const GetFrameFrontendStateCommand(id: 43),
      const SetFrameControlCommand(id: 44, control: FrameControl.menu, enabled: true),
    ]) {
      final result = await h.rpc.executeCommand(command);
      expect(
        result,
        isA<ErrorResult>()
            .having((result) => result.id, 'request ID', command.id)
            .having((result) => result.error, 'shutdown reason', contains('Frontend service is closed')),
      );
    }
  });

  frontendTest('incoming RPC delivers button, screen, action and OTA events through the real facade', (
    tester,
    h,
  ) async {
    final buttons = <ButtonEvent>[];
    final screens = <bool>[];
    final ready = <bool>[];
    final info = <OTAInfo>[];
    final output = <String>[];
    final subscriptions = <StreamSubscription<dynamic>>[
      h.frontend.onButtonEvent.listen(buttons.add),
      h.frontend.onScreenStateChangePreparation.listen(screens.add),
      h.frontend.onOTAReady.listen(ready.add),
      h.frontend.onOTAInfo.listen(info.add),
      h.frontend.onOTAOutput.listen(output.add),
    ];
    addTearDown(() async {
      for (final subscription in subscriptions) {
        await subscription.cancel();
      }
    });
    const ota = OTAInfo(
      status: OTAStatus.issue,
      uploadingPercent: 0,
      code: 'private-code',
      errorText: 'installer rejected',
    );
    final commands = <RpcCommand>[
      const ButtonChangeStateCommand(
        id: 20,
        button: ButtonType.button2,
        event: ButtonEventType.released,
        durationMs: 321,
      ),
      const ScreenTurnCommand(id: 21, enabled: false),
      const ExecuteSSActionCommand(id: 22, action: SlideshowAction.pause, value: true),
      const OTAReadyCommand(id: 23, ready: true),
      const OTAGetInfoCommand(id: 24, info: ota),
      const OTAOutputCommand(id: 25, output: 'installer line'),
    ];
    for (final command in commands) {
      final response = await h.rpc.executeCommand(command);
      expect(response, isA<EmptyResult>().having((result) => result.id, 'ID', command.id));
    }
    await tester.pump();
    expect(buttons.single.button, ButtonType.button2);
    expect(buttons.single.durationMs, 321);
    expect(screens, [false]);
    expect(h.status.state.isPaused, isTrue);
    expect(ready, [true]);
    expect(info, [ota]);
    expect(output, ['installer line']);
    final malformed = await h.rpc.executeCommand(const OTAGetInfoCommand(id: 26));
    expect(malformed, isA<ErrorResult>().having((result) => result.id, 'ID', 26));
  });

  frontendTest('frame state and control RPC use the running RouteBloc and SlideshowStatusBloc', (tester, h) async {
    tester.view.physicalSize = const Size(2560, 1600);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    h.route.add(ChangePageEvent(RoutePage.slideshow));
    await tester.pump();
    final pending = h.rpc.executeCommand(
      const SetFrameControlCommand(id: 30, control: FrameControl.menu, enabled: true),
    );
    await tester.pump();
    final response = await pending;
    expect(response, isA<EmptyResult>());
    final state = await h.rpc.executeCommand(const GetFrameFrontendStateCommand(id: 31)) as GetFrameFrontendStateResult;
    expect(state.state.isMenu, isTrue);
    expect(state.state.page, FramePage.slideshow);
    expect(state.state.display!.physicalWidth, 2560);
    expect(state.state.display!.logicalWidth, 1280);
    tester.view.physicalSize = const Size(1600, 2560);
    final resized =
        await h.rpc.executeCommand(const GetFrameFrontendStateCommand(id: 32)) as GetFrameFrontendStateResult;
    expect(resized.state.display!.physicalWidth, 1600);
    expect(resized.state.display!.logicalHeight, 1280);
    expect(h.backend.requests.whereType<UpdateFrontendStateCommand>().single.isMenu, isTrue);
  });

  frontendTest('frame RPC returns the source request ID on a backend rejection and keeps logs safe', (tester, h) async {
    final records = <LogRecord>[];
    final level = Logger.root.level;
    Logger.root.level = Level.ALL;
    final subscription = Logger.root.onRecord.listen(records.add);
    addTearDown(() async {
      await subscription.cancel();
      Logger.root.level = level;
    });
    final pending = h.rpc.executeCommand(
      const SetFrameControlCommand(id: 33, control: FrameControl.screen, enabled: false),
    );
    await tester.pump();
    final lock = h.backend.requests.whereType<ScreenLockCommand>().single;
    const privateFailure = 'https://private-code/private-path';
    h.backend.respond(lock, ErrorResult(id: lock.id, error: privateFailure));
    await tester.pump();
    expect(await pending, isA<ErrorResult>().having((result) => result.id, 'request ID', 33));
    expect(h.backend.requests.whereType<ScreenTurnCommand>(), isEmpty);
    final failed = records.singleWhere((record) => record.message.startsWith('command failed '));
    expect(failed.level, Level.WARNING);
    expect(failed.message, contains('requestId=33'));
    expect(records.any((record) => record.message.startsWith('command start requestId=33 ')), isTrue);
    expect(records.any((record) => record.message.startsWith('command result requestId=33 ')), isTrue);
    expect(
      records.any(
        (record) =>
            record.loggerName == 'SlideshowStatusBloc' &&
            record.message.startsWith('Unable to apply screen control type='),
      ),
      isTrue,
    );
    expect(records.every((record) => record.error == null && record.stackTrace == null), isTrue);
    expect(records.map((record) => record.message).join('\n'), isNot(contains(privateFailure)));
  });

  frontendTest('OTA and SystemInfo read facades route to their respective remotes', (tester, h) async {
    final ota = h.frontend.getOTAInfo();
    final system = h.frontend.getSystemInfo();
    final otaCommand = h.ota.requests.single as OTAGetInfoCommand;
    final systemCommand = h.backend.requests.whereType<GetSystemInfoCommand>().last;
    const expectedOta = OTAInfo(status: OTAStatus.ready, uploadingPercent: 0, code: 'private-code');
    final expectedSystem = otaSystemInfo();
    h.ota.respond(otaCommand, OTAGetInfoCommandResult(id: otaCommand.id, info: expectedOta));
    h.backend.respond(systemCommand, GetSystemInfoCommandResult(id: systemCommand.id, systemInfo: expectedSystem));
    expect(await ota, expectedOta);
    expect(await system, expectedSystem);
    expect(h.backend.requests.whereType<OTAGetInfoCommand>(), isEmpty);
  });
  frontendTest('outgoing control facades preserve their command fields and web-server result', (tester, h) async {
    final lock = h.frontend.changeScreenLock(true);
    final lockCommand = h.backend.requests.last as ScreenLockCommand;
    expect(lockCommand.isLock, isTrue);
    h.backend.respond(lockCommand, EmptyResult.respond(lockCommand));
    await lock;

    final screen = h.frontend.screenTurn(false);
    final screenCommand = h.backend.requests.last as ScreenTurnCommand;
    expect(screenCommand.enabled, isFalse);
    h.backend.respond(screenCommand, EmptyResult.respond(screenCommand));
    await screen;

    final led = h.frontend.swithLED(LEDType.power, true);
    final ledCommand = h.backend.requests.last as LEDControlCommand;
    expect((ledCommand.led, ledCommand.value), (LEDType.power, true));
    h.backend.respond(ledCommand, EmptyResult.respond(ledCommand));
    await led;

    final push = h.frontend.emulatePushButton(ButtonType.button2, 450);
    final pushCommand = h.backend.requests.last as EmulatePushButtonCommand;
    expect((pushCommand.button, pushCommand.durationMs), (ButtonType.button2, 450));
    h.backend.respond(pushCommand, EmptyResult.respond(pushCommand));
    await push;

    final ready = h.frontend.backendIsReady();
    final readyCommand = h.backend.requests.last;
    expect(readyCommand, isA<AreYouReadyCommand>());
    h.backend.respond(readyCommand, EmptyResult.respond(readyCommand));
    await ready;

    final code = h.frontend.startWebServer();
    final start = h.backend.requests.last as WebServerControlCommand;
    expect(start.enable, isTrue);
    h.backend.respond(start, WebServerControlCommandResult(id: start.id, code: '00017', enable: true));
    expect(await code, '00017');
    final stop = h.frontend.stopWebServer();
    final stopCommand = h.backend.requests.last as WebServerControlCommand;
    expect(stopCommand.enable, isFalse);
    h.backend.respond(stopCommand, WebServerControlCommandResult(id: stopCommand.id, code: '', enable: false));
    await stop;
    expect(h.ota.requests, isEmpty);
  });

  test('refresh interval must be positive before any RPC or timer is started', () {
    final backend = ControlledFrontendRemote();
    final ota = ControlledFrontendRemote();
    for (final interval in [Duration.zero, const Duration(seconds: -1)]) {
      expect(
        () => FrontendService(AppConfig.fromJson({}), backend, ota, systemInfoInterval: interval),
        throwsArgumentError,
      );
    }
    expect(backend.requests, isEmpty);
    expect(ota.requests, isEmpty);
  });
}
