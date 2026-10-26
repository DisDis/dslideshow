import 'dart:convert';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'package:test/test.dart';

T roundTrip<T>(Object object) => serializers.deserialize(
  jsonDecode(jsonEncode(serializers.serialize(object))),
) as T;

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
      isScreenLocked: true,
      isScreenOn: null,
      screenPhase: FrameScreenPhase.failed,
      backendVersion: 'test.backend',
      frontend: frontend,
    );
    final decoded = roundTrip<GetFrameStateResult>(
      GetFrameStateResult(id: 17, state: state),
    );
    expect(decoded.id, 17);
    expect(decoded.state.toJson(), state.toJson());
    expect(decoded.state.sampledAt.isUtc, isTrue);
    expect(decoded.state.presenceObservedAt!.isUtc, isTrue);
    expect(decoded.state.frontend!.display!.physicalWidth, 2560);
    expect(decoded.state.frontend!.display!.pixelRatio, 2);
    expect(
      roundTrip<GetFrameStateCommand>(const GetFrameStateCommand(id: 18)).type,
      GetFrameStateCommand.TYPE,
    );
    expect(
      roundTrip<GetFrameFrontendStateCommand>(
        const GetFrameFrontendStateCommand(id: 19),
      ).type,
      GetFrameFrontendStateCommand.TYPE,
    );
    expect(
      roundTrip<GetFrameFrontendStateResult>(
        const GetFrameFrontendStateResult(id: 20, state: frontend),
      ).state.toJson(),
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
      'isScreenLocked': false,
      'isScreenOn': null,
      'backendVersion': 'test',
    };
    for (final value in [null, 'future']) {
      if (value != null) {
        state['presence'] = value;
        state['screenPhase'] = value;
      }
      final decoded = FrameState.fromJson(state);
      expect(decoded.presence, FramePresence.unknown);
      expect(decoded.screenPhase, FrameScreenPhase.unknown);
      expect(decoded.frontend, isNull);
      final frontendJson = frontend.toJson()..remove('page');
      if (value != null) frontendJson['page'] = value;
      expect(FrameFrontendState.fromJson(frontendJson).page, FramePage.unknown);
    }
  });

  test(
    'missing or unsupported control is rejected without choosing an action',
    () {
      for (final value in [null, 'future']) {
        expect(
          () => SetFrameControlCommand.fromJson({
            'id': 22,
            'enabled': false,
            if (value != null) 'control': value,
          }),
          throwsArgumentError,
        );
      }
    },
  );
}
