import 'dart:async';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/src/service/hardware/src/application_state_service.dart';
import 'package:dslideshow_backend/src/service/hardware/src/frame_state_reader.dart';
import 'package:dslideshow_backend/src/service/hardware/src/screen_service.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_common/version.dart';
import 'package:test/test.dart';

import 'frame_state_test.dart' show FrameRemote;
import 'helpers/capture_logs.dart';

class _Screen implements ScreenService {
  @override
  ScreenPhase phase = ScreenPhase.on;
  @override
  bool isScreenOffLock = false;
  @override
  bool? confirmedPower = true;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Application implements ApplicationStateService {
  @override
  bool? observedPresence;
  @override
  DateTime? presenceObservedAt;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _SyncFailureRemote implements RemoteService {
  @override
  Future<RpcResult> send<T extends RpcCommand>(T command) {
    throw StateError('Synchronous frontend failure');
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Fixture {
  final screen = _Screen();
  final application = _Application();
  final remote = FrameRemote();
  late final FrameStateReader reader;

  _Fixture({RemoteService? frontend}) {
    reader = FrameStateReader(
      frontendService: frontend ?? remote,
      screenService: screen,
      applicationStateService: application,
    );
  }
}

void main() {
  for (final (phase, expected) in [
    (ScreenPhase.on, FrameScreenPhase.on),
    (ScreenPhase.waitingOff, FrameScreenPhase.waitingOff),
    (ScreenPhase.fadingOut, FrameScreenPhase.fadingOut),
    (ScreenPhase.poweringOff, FrameScreenPhase.poweringOff),
    (ScreenPhase.off, FrameScreenPhase.off),
    (ScreenPhase.wakingUp, FrameScreenPhase.wakingUp),
    (ScreenPhase.fadingIn, FrameScreenPhase.fadingIn),
    (ScreenPhase.failed, FrameScreenPhase.failed),
    (ScreenPhase.disposed, FrameScreenPhase.unknown),
  ]) {
    test('snapshot reports screen phase $phase as $expected', () async {
      final fixture = _Fixture();
      fixture.screen.phase = phase;
      final state = await fixture.reader.read();
      expect(state.screenPhase, expected);
    });
  }

  test('snapshot uses backend observations after frontend completes', () async {
    final fixture = _Fixture();
    final pending = Completer<RpcResult>();
    fixture.remote.pendingState = pending;
    final response = fixture.reader.read();
    fixture.application.observedPresence = false;
    fixture.application.presenceObservedAt = DateTime.utc(2026, 10, 27, 10);
    fixture.screen.isScreenOffLock = true;
    fixture.screen.confirmedPower = null;
    fixture.screen.phase = ScreenPhase.failed;
    pending.complete(GetFrameFrontendStateResult(id: 0, state: fixture.remote.state));
    final state = await response;
    expect(state.presence, FramePresence.absent);
    expect(state.presenceObservedAt, fixture.application.presenceObservedAt);
    expect(state.isScreenLocked, isTrue);
    expect(state.isScreenOn, isNull);
    expect(state.screenPhase, FrameScreenPhase.failed);
    expect(state.sampledAt.isUtc, isTrue);
    expect(state.backendVersion, ApplicationInfo.backendVersion);
    expect(state.frontend, same(fixture.remote.state));
  });

  test('concurrent reads send independent frontend requests', () async {
    final fixture = _Fixture();
    final pending = Completer<RpcResult>();
    fixture.remote.pendingState = pending;
    final responses = List.generate(10, (_) => fixture.reader.read());
    expect(fixture.remote.commands, hasLength(10));
    pending.complete(GetFrameFrontendStateResult(id: 0, state: fixture.remote.state));
    final snapshots = await Future.wait(responses);
    expect(snapshots, hasLength(10));
    expect(snapshots.every((state) => identical(state.frontend, fixture.remote.state)), isTrue);
  });

  test('completed snapshots are not cached between reads', () async {
    final fixture = _Fixture();
    final first = await fixture.reader.read();
    fixture.remote.state = const FrameFrontendState(
      isPaused: true,
      isMenu: true,
      page: FramePage.config,
      frontendVersion: 'updated.frontend',
    );
    fixture.application.observedPresence = true;
    final second = await fixture.reader.read();
    expect(first.frontend!.isPaused, isFalse);
    expect(first.presence, FramePresence.unknown);
    expect(second.frontend, same(fixture.remote.state));
    expect(second.presence, FramePresence.present);
    expect(fixture.remote.commands, hasLength(2));
  });

  test(
    'async frontend failure returns backend state and a later read recovers',
    () => captureLogs((records) async {
      final fixture = _Fixture();
      final error = StateError('private frontend URL');
      fixture.remote.failure = error;
      final failed = await fixture.reader.read();
      expect(failed.frontend, isNull);
      expect(failed.isScreenOn, isTrue);
      expect(failed.backendVersion, ApplicationInfo.backendVersion);
      fixture.remote.failure = null;
      final recovered = await fixture.reader.read();
      expect(recovered.frontend, same(fixture.remote.state));
      expect(fixture.remote.commands, hasLength(2));
      expect(records.any((record) => record.message == 'Frontend state unavailable type=StateError'), isTrue);
      final diagnostic = records.singleWhere((record) => record.error != null);
      expect(diagnostic.error, same(error));
      expect(diagnostic.stackTrace.toString(), contains('frame_state_reader_test.dart'));
      expect(records.map((record) => record.message).join(), isNot(contains('private')));
    }),
  );

  test('unexpected frontend response leaves frontend state unknown', () async {
    final fixture = _Fixture();
    final pending = Completer<RpcResult>();
    fixture.remote.pendingState = pending;
    final response = fixture.reader.read();
    pending.complete(const EmptyResult(id: 0));
    final state = await response;
    expect(state.frontend, isNull);
    expect(state.isScreenOn, isTrue);
  });

  test('synchronous frontend failure preserves available backend state', () async {
    final fixture = _Fixture(frontend: _SyncFailureRemote());
    final state = await fixture.reader.read();
    expect(state.frontend, isNull);
    expect(state.isScreenOn, isTrue);
    expect(state.backendVersion, ApplicationInfo.backendVersion);
  });
}
