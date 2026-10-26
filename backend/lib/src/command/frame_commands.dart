import 'package:dslideshow_common/rpc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'frame_commands.g.dart';

/// Unsupported or missing controls are rejected when decoding a command.
enum FrameControl { pause, menu, screen }

enum FramePage { unknown, welcome, slideshow, config, ota }

enum FramePresence { unknown, present, absent }

enum FrameScreenPhase {
  unknown,
  on,
  waitingOff,
  fadingOut,
  poweringOff,
  off,
  wakingUp,
  fadingIn,
  failed,
}

@JsonSerializable()
class FrameDisplayInfo {
  final double physicalWidth;
  final double physicalHeight;
  final double logicalWidth;
  final double logicalHeight;
  final double pixelRatio;

  const FrameDisplayInfo({
    required this.physicalWidth,
    required this.physicalHeight,
    required this.logicalWidth,
    required this.logicalHeight,
    required this.pixelRatio,
  });

  factory FrameDisplayInfo.fromJson(Map<String, dynamic> json) =>
      _$FrameDisplayInfoFromJson(json);
  Map<String, dynamic> toJson() => _$FrameDisplayInfoToJson(this);
}

@JsonSerializable()
class FrameFrontendState {
  final bool isPaused;
  final bool isMenu;
  @JsonKey(unknownEnumValue: FramePage.unknown, defaultValue: FramePage.unknown)
  final FramePage page;
  final String frontendVersion;
  final FrameDisplayInfo? display;

  const FrameFrontendState({
    required this.isPaused,
    required this.isMenu,
    required this.page,
    required this.frontendVersion,
    this.display,
  });

  factory FrameFrontendState.fromJson(Map<String, dynamic> json) =>
      _$FrameFrontendStateFromJson(json);
  Map<String, dynamic> toJson() => _$FrameFrontendStateToJson(this);
}

@JsonSerializable()
class FrameState {
  final DateTime sampledAt;
  @JsonKey(
    unknownEnumValue: FramePresence.unknown,
    defaultValue: FramePresence.unknown,
  )
  final FramePresence presence;
  final DateTime? presenceObservedAt;
  final bool isScreenLocked;

  /// Last successfully commanded power, unknown after a hardware failure.
  final bool? isScreenOn;
  @JsonKey(
    unknownEnumValue: FrameScreenPhase.unknown,
    defaultValue: FrameScreenPhase.unknown,
  )
  final FrameScreenPhase screenPhase;
  final String backendVersion;
  final FrameFrontendState? frontend;

  const FrameState({
    required this.sampledAt,
    required this.presence,
    this.presenceObservedAt,
    required this.isScreenLocked,
    required this.isScreenOn,
    required this.screenPhase,
    required this.backendVersion,
    this.frontend,
  });

  factory FrameState.fromJson(Map<String, dynamic> json) =>
      _$FrameStateFromJson(json);
  Map<String, dynamic> toJson() => _$FrameStateToJson(this);
}

@JsonSerializable()
class GetFrameStateCommand implements RpcCommand {
  static const String TYPE = 'get_frame_state';
  @override
  final int id;
  @override
  final String type;

  const GetFrameStateCommand({
    required this.id,
    this.type = GetFrameStateCommand.TYPE,
  });
  factory GetFrameStateCommand.fromJson(Map<String, dynamic> json) =>
      _$GetFrameStateCommandFromJson(json);
  Map<String, dynamic> toJson() => _$GetFrameStateCommandToJson(this);
}

@JsonSerializable()
class GetFrameStateResult implements RpcResult {
  static const String TYPE = 'frame_state_result';
  @override
  final int id;
  final String type;
  final FrameState state;

  const GetFrameStateResult({
    required this.id,
    required this.state,
    this.type = GetFrameStateResult.TYPE,
  });
  factory GetFrameStateResult.fromJson(Map<String, dynamic> json) =>
      _$GetFrameStateResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetFrameStateResultToJson(this);
}

@JsonSerializable()
class GetFrameFrontendStateCommand implements RpcCommand {
  static const String TYPE = 'get_frame_frontend_state';
  @override
  final int id;
  @override
  final String type;

  const GetFrameFrontendStateCommand({
    required this.id,
    this.type = GetFrameFrontendStateCommand.TYPE,
  });
  factory GetFrameFrontendStateCommand.fromJson(Map<String, dynamic> json) =>
      _$GetFrameFrontendStateCommandFromJson(json);
  Map<String, dynamic> toJson() => _$GetFrameFrontendStateCommandToJson(this);
}

@JsonSerializable()
class GetFrameFrontendStateResult implements RpcResult {
  static const String TYPE = 'frame_frontend_state_result';
  @override
  final int id;
  final String type;
  final FrameFrontendState state;

  const GetFrameFrontendStateResult({
    required this.id,
    required this.state,
    this.type = GetFrameFrontendStateResult.TYPE,
  });
  factory GetFrameFrontendStateResult.fromJson(Map<String, dynamic> json) =>
      _$GetFrameFrontendStateResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetFrameFrontendStateResultToJson(this);
}

/// Absolute, idempotent intent. [enabled] means paused/menu open/screen on.
@JsonSerializable()
class SetFrameControlCommand implements RpcCommand {
  static const String TYPE = 'set_frame_control';
  @override
  final int id;
  @override
  final String type;
  final FrameControl control;
  final bool enabled;

  const SetFrameControlCommand({
    required this.id,
    required this.control,
    required this.enabled,
    this.type = SetFrameControlCommand.TYPE,
  });
  factory SetFrameControlCommand.fromJson(Map<String, dynamic> json) =>
      _$SetFrameControlCommandFromJson(json);
  Map<String, dynamic> toJson() => _$SetFrameControlCommandToJson(this);
}
