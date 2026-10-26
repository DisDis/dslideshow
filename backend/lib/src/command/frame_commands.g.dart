// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frame_commands.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FrameDisplayInfo _$FrameDisplayInfoFromJson(Map<String, dynamic> json) =>
    FrameDisplayInfo(
      physicalWidth: (json['physicalWidth'] as num).toDouble(),
      physicalHeight: (json['physicalHeight'] as num).toDouble(),
      logicalWidth: (json['logicalWidth'] as num).toDouble(),
      logicalHeight: (json['logicalHeight'] as num).toDouble(),
      pixelRatio: (json['pixelRatio'] as num).toDouble(),
    );

Map<String, dynamic> _$FrameDisplayInfoToJson(FrameDisplayInfo instance) =>
    <String, dynamic>{
      'physicalWidth': instance.physicalWidth,
      'physicalHeight': instance.physicalHeight,
      'logicalWidth': instance.logicalWidth,
      'logicalHeight': instance.logicalHeight,
      'pixelRatio': instance.pixelRatio,
    };

FrameFrontendState _$FrameFrontendStateFromJson(Map<String, dynamic> json) =>
    FrameFrontendState(
      isPaused: json['isPaused'] as bool,
      isMenu: json['isMenu'] as bool,
      page:
          $enumDecodeNullable(
            _$FramePageEnumMap,
            json['page'],
            unknownValue: FramePage.unknown,
          ) ??
          FramePage.unknown,
      frontendVersion: json['frontendVersion'] as String,
      display: json['display'] == null
          ? null
          : FrameDisplayInfo.fromJson(json['display'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FrameFrontendStateToJson(FrameFrontendState instance) =>
    <String, dynamic>{
      'isPaused': instance.isPaused,
      'isMenu': instance.isMenu,
      'page': _$FramePageEnumMap[instance.page]!,
      'frontendVersion': instance.frontendVersion,
      'display': instance.display?.toJson(),
    };

const _$FramePageEnumMap = {
  FramePage.unknown: 'unknown',
  FramePage.welcome: 'welcome',
  FramePage.slideshow: 'slideshow',
  FramePage.config: 'config',
  FramePage.ota: 'ota',
};

FrameState _$FrameStateFromJson(Map<String, dynamic> json) => FrameState(
  sampledAt: DateTime.parse(json['sampledAt'] as String),
  presence:
      $enumDecodeNullable(
        _$FramePresenceEnumMap,
        json['presence'],
        unknownValue: FramePresence.unknown,
      ) ??
      FramePresence.unknown,
  presenceObservedAt: json['presenceObservedAt'] == null
      ? null
      : DateTime.parse(json['presenceObservedAt'] as String),
  isScreenLocked: json['isScreenLocked'] as bool,
  isScreenOn: json['isScreenOn'] as bool?,
  screenPhase:
      $enumDecodeNullable(
        _$FrameScreenPhaseEnumMap,
        json['screenPhase'],
        unknownValue: FrameScreenPhase.unknown,
      ) ??
      FrameScreenPhase.unknown,
  backendVersion: json['backendVersion'] as String,
  frontend: json['frontend'] == null
      ? null
      : FrameFrontendState.fromJson(json['frontend'] as Map<String, dynamic>),
);

Map<String, dynamic> _$FrameStateToJson(FrameState instance) =>
    <String, dynamic>{
      'sampledAt': instance.sampledAt.toIso8601String(),
      'presence': _$FramePresenceEnumMap[instance.presence]!,
      'presenceObservedAt': instance.presenceObservedAt?.toIso8601String(),
      'isScreenLocked': instance.isScreenLocked,
      'isScreenOn': instance.isScreenOn,
      'screenPhase': _$FrameScreenPhaseEnumMap[instance.screenPhase]!,
      'backendVersion': instance.backendVersion,
      'frontend': instance.frontend?.toJson(),
    };

const _$FramePresenceEnumMap = {
  FramePresence.unknown: 'unknown',
  FramePresence.present: 'present',
  FramePresence.absent: 'absent',
};

const _$FrameScreenPhaseEnumMap = {
  FrameScreenPhase.unknown: 'unknown',
  FrameScreenPhase.on: 'on',
  FrameScreenPhase.waitingOff: 'waitingOff',
  FrameScreenPhase.fadingOut: 'fadingOut',
  FrameScreenPhase.poweringOff: 'poweringOff',
  FrameScreenPhase.off: 'off',
  FrameScreenPhase.wakingUp: 'wakingUp',
  FrameScreenPhase.fadingIn: 'fadingIn',
  FrameScreenPhase.failed: 'failed',
};

GetFrameStateCommand _$GetFrameStateCommandFromJson(
  Map<String, dynamic> json,
) => GetFrameStateCommand(
  id: (json['id'] as num).toInt(),
  type: json['type'] as String? ?? GetFrameStateCommand.TYPE,
);

Map<String, dynamic> _$GetFrameStateCommandToJson(
  GetFrameStateCommand instance,
) => <String, dynamic>{'id': instance.id, 'type': instance.type};

GetFrameStateResult _$GetFrameStateResultFromJson(Map<String, dynamic> json) =>
    GetFrameStateResult(
      id: (json['id'] as num).toInt(),
      state: FrameState.fromJson(json['state'] as Map<String, dynamic>),
      type: json['type'] as String? ?? GetFrameStateResult.TYPE,
    );

Map<String, dynamic> _$GetFrameStateResultToJson(
  GetFrameStateResult instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'state': instance.state.toJson(),
};

GetFrameFrontendStateCommand _$GetFrameFrontendStateCommandFromJson(
  Map<String, dynamic> json,
) => GetFrameFrontendStateCommand(
  id: (json['id'] as num).toInt(),
  type: json['type'] as String? ?? GetFrameFrontendStateCommand.TYPE,
);

Map<String, dynamic> _$GetFrameFrontendStateCommandToJson(
  GetFrameFrontendStateCommand instance,
) => <String, dynamic>{'id': instance.id, 'type': instance.type};

GetFrameFrontendStateResult _$GetFrameFrontendStateResultFromJson(
  Map<String, dynamic> json,
) => GetFrameFrontendStateResult(
  id: (json['id'] as num).toInt(),
  state: FrameFrontendState.fromJson(json['state'] as Map<String, dynamic>),
  type: json['type'] as String? ?? GetFrameFrontendStateResult.TYPE,
);

Map<String, dynamic> _$GetFrameFrontendStateResultToJson(
  GetFrameFrontendStateResult instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'state': instance.state.toJson(),
};

SetFrameControlCommand _$SetFrameControlCommandFromJson(
  Map<String, dynamic> json,
) => SetFrameControlCommand(
  id: (json['id'] as num).toInt(),
  control: $enumDecode(_$FrameControlEnumMap, json['control']),
  enabled: json['enabled'] as bool,
  type: json['type'] as String? ?? SetFrameControlCommand.TYPE,
);

Map<String, dynamic> _$SetFrameControlCommandToJson(
  SetFrameControlCommand instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'control': _$FrameControlEnumMap[instance.control]!,
  'enabled': instance.enabled,
};

const _$FrameControlEnumMap = {
  FrameControl.pause: 'pause',
  FrameControl.menu: 'menu',
  FrameControl.screen: 'screen',
};
