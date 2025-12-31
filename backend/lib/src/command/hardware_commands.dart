import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/command/button_type.dart';
import 'package:dslideshow_backend/src/command/led_type.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hardware_commands.g.dart';
part 'hardware_commands.freezed.dart';

@freezed
sealed class AreYouReadyCommand
    with _$AreYouReadyCommand
    implements RpcCommand {
  static const String TYPE = 'are_you_ready?';
  const factory AreYouReadyCommand({
    required int id,
    @Default(AreYouReadyCommand.TYPE) String type,
  }) = _AreYouReadyCommand;

  factory AreYouReadyCommand.fromJson(Map<String, dynamic> json) =>
      _$AreYouReadyCommandFromJson(json);
}

@freezed
sealed class ButtonChangeStateCommand
    with _$ButtonChangeStateCommand
    implements RpcCommand {
  static const String TYPE = 'button_change_state';
  const factory ButtonChangeStateCommand({
    required ButtonType button,
    required ButtonEventType event,
    required int durationMs,
    required int id,
    @Default(ButtonChangeStateCommand.TYPE) String type,
  }) = _ButtonChangeStateCommand;

  factory ButtonChangeStateCommand.fromJson(Map<String, dynamic> json) =>
      _$ButtonChangeStateCommandFromJson(json);
}

@freezed
sealed class EmulatePushButtonCommand
    with _$EmulatePushButtonCommand
    implements RpcCommand {
  static const String TYPE = 'emulate_push_button';
  const factory EmulatePushButtonCommand({
    required ButtonType button,
    required int durationMs,
    required int id,
    @Default(EmulatePushButtonCommand.TYPE) String type,
  }) = _EmulatePushButtonCommand;

  factory EmulatePushButtonCommand.fromJson(Map<String, dynamic> json) =>
      _$EmulatePushButtonCommandFromJson(json);
}

@freezed
sealed class ExecuteSSActionCommand
    with _$ExecuteSSActionCommand
    implements RpcCommand {
  static const String TYPE = 'execute_action';
  const factory ExecuteSSActionCommand({
    required SlideshowAction action,
    required bool value,
    required int id,
    @Default(ExecuteSSActionCommand.TYPE) String type,
  }) = _ExecuteSSActionCommand;

  factory ExecuteSSActionCommand.fromJson(Map<String, dynamic> json) =>
      _$ExecuteSSActionCommandFromJson(json);
}

@freezed
sealed class LEDControlCommand with _$LEDControlCommand implements RpcCommand {
  static const String TYPE = 'led_control';
  const factory LEDControlCommand({
    required LEDType led,
    required bool value,
    required int id,
    @Default(LEDControlCommand.TYPE) String type,
  }) = _LEDControlCommand;

  factory LEDControlCommand.fromJson(Map<String, dynamic> json) =>
      _$LEDControlCommandFromJson(json);
}

@freezed
sealed class PowerOffCommand with _$PowerOffCommand implements RpcCommand {
  static const String TYPE = 'powerOff';
  const factory PowerOffCommand({
    @Default(PowerOffCommand.TYPE) String type,
    required int id,
  }) = _PowerOffCommand;

  factory PowerOffCommand.fromJson(Map<String, dynamic> json) =>
      _$PowerOffCommandFromJson(json);
}

@freezed
sealed class RestartAppCommand with _$RestartAppCommand implements RpcCommand {
  static const String TYPE = 'restartApp';
  const factory RestartAppCommand({
    @Default(RestartAppCommand.TYPE) String type,
    required int id,
  }) = _RestartAppCommand;

  factory RestartAppCommand.fromJson(Map<String, dynamic> json) =>
      _$RestartAppCommandFromJson(json);
}
