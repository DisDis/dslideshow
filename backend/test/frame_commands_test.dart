import 'dart:convert';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_common/storage_status.dart';
import 'package:test/test.dart';

T roundTrip<T>(Object object) => serializers.deserialize(jsonDecode(jsonEncode(serializers.serialize(object)))) as T;

void main() {
  const frontend = FrameFrontendState(
    isPaused: true,
    isMenu: false,
    page: FramePage.slideshow,
    frontendVersion: 'test.frontend',
    display: FrameDisplayInfo(
      physicalWidth: 2560,
      physicalHeight: 1600,
      logicalWidth: 1280,
      logicalHeight: 800,
      pixelRatio: 2,
    ),
  );

  test('commands and nested frame snapshots survive actual JSON transport', () {
    final state = FrameState(
      sampledAt: DateTime.utc(2026, 10, 26, 12),
      presence: FramePresence.absent,
      presenceObservedAt: DateTime.utc(2026, 10, 26, 11),
      autoWakeEnabled: false,
      isScreenOn: null,
      screenPhase: FrameScreenPhase.failed,
      storageStatus: StorageStatusEnum.error,
      backendVersion: 'test.backend',
      frontend: frontend,
      nightMode: NightModeState(
        enabled: true,
        inSchedule: true,
        automaticWakeBlocked: true,
        reason: AutomaticSleepReason.schedule,
        nextBoundary: DateTime(2026, 10, 27, 8),
      ),
      deviceLocalTime: DateTime(2026, 10, 26, 23),
    );
    final decoded = roundTrip<GetFrameStateResult>(GetFrameStateResult(id: 17, state: state));
    expect(decoded.id, 17);
    expect(decoded.state.toJson(), state.toJson());
    expect(decoded.state.sampledAt.isUtc, isTrue);
    expect(decoded.state.presenceObservedAt!.isUtc, isTrue);
    expect(decoded.state.frontend!.display!.physicalWidth, 2560);
    expect(decoded.state.frontend!.display!.pixelRatio, 2);
    expect(roundTrip<GetFrameStateCommand>(const GetFrameStateCommand(id: 18)).type, GetFrameStateCommand.TYPE);
    expect(
      roundTrip<GetFrameFrontendStateCommand>(const GetFrameFrontendStateCommand(id: 19)).type,
      GetFrameFrontendStateCommand.TYPE,
    );
    expect(
      roundTrip<GetFrameFrontendStateResult>(const GetFrameFrontendStateResult(id: 20, state: frontend)).state.toJson(),
      frontend.toJson(),
    );
    for (final control in FrameControl.values) {
      final command = roundTrip<SetFrameControlCommand>(
        SetFrameControlCommand(id: 21, control: control, enabled: true),
      );
      expect(command.type, SetFrameControlCommand.TYPE);
      expect(command.control, control);
      expect(command.enabled, isTrue);
    }
  });

  test('missing and future enum states are explicitly unknown', () {
    final state = {
      'sampledAt': '2026-10-26T12:00:00Z',
      'autoWakeEnabled': true,
      'isScreenOn': null,
      'backendVersion': 'test',
      'nightMode': const NightModeState().toJson(),
      'deviceLocalTime': '2026-10-26T12:00:00Z',
    };
    for (final value in [null, 'future']) {
      if (value != null) {
        state['presence'] = value;
        state['screenPhase'] = value;
        state['storageStatus'] = value;
      }
      final decoded = FrameState.fromJson(state);
      expect(decoded.presence, FramePresence.unknown);
      expect(decoded.screenPhase, FrameScreenPhase.unknown);
      expect(decoded.storageStatus, StorageStatusEnum.off);
      expect(decoded.frontend, isNull);
      final frontendJson = frontend.toJson()..remove('page');
      if (value != null) frontendJson['page'] = value;
      expect(FrameFrontendState.fromJson(frontendJson).page, FramePage.unknown);
    }
  });

  test('frame snapshots require all night mode and device clock fields', () {
    final json = FrameState(
      sampledAt: DateTime.utc(2026),
      autoWakeEnabled: true,
      isScreenOn: true,
      backendVersion: 'test',
      nightMode: const NightModeState(),
      deviceLocalTime: DateTime.utc(2026),
    ).toJson();
    for (final field in ['autoWakeEnabled', 'nightMode', 'deviceLocalTime']) {
      expect(() => FrameState.fromJson({...json}..remove(field)), throwsA(isA<TypeError>()), reason: field);
      expect(() => FrameState.fromJson({...json, field: null}), throwsA(isA<TypeError>()), reason: field);
    }
  });

  test('frame storage statuses survive JSON RPC transport and copyWith', () {
    for (final status in StorageStatusEnum.values) {
      final frame = FrameState(
        sampledAt: DateTime.utc(2026, 10, 31),
        autoWakeEnabled: true,
        isScreenOn: true,
        backendVersion: 'test',
        storageStatus: status,
        nightMode: const NightModeState(),
        deviceLocalTime: DateTime.utc(2026, 10, 31),
      );
      final decoded = roundTrip<GetFrameStateResult>(GetFrameStateResult(id: 23, state: frame)).state;
      expect(decoded.storageStatus, status);
      expect(decoded.toJson()['storageStatus'], status.name);
      expect(decoded, frame);
      expect(frame.copyWith(storageStatus: StorageStatusEnum.error).storageStatus, StorageStatusEnum.error);
    }
    expect(
      FrameState.fromJson({
        'sampledAt': '2026-10-31T12:00:00Z',
        'autoWakeEnabled': true,
        'isScreenOn': null,
        'backendVersion': 'test',
        'storageStatus': null,
        'nightMode': const NightModeState().toJson(),
        'deviceLocalTime': '2026-10-31T12:00:00Z',
      }).storageStatus,
      StorageStatusEnum.off,
    );
  });

  test('missing or unsupported control is rejected without choosing an action', () {
    for (final value in [null, 'future']) {
      expect(
        () => SetFrameControlCommand.fromJson({'id': 22, 'enabled': false, if (value != null) 'control': value}),
        throwsArgumentError,
      );
    }
  });
}
