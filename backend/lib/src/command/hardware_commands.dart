import 'package:dslideshow_backend/src/command/button_type.dart';
import 'package:dslideshow_backend/src/command/led_type.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hardware_commands.g.dart';
part 'hardware_commands.freezed.dart';

@freezed
class AreYouReadyCommand with _$AreYouReadyCommand implements RpcCommand {
  static const String TYPE = 'are_you_ready?';
  const factory AreYouReadyCommand({
    required int id,
    @Default(AreYouReadyCommand.TYPE) String type,
  }) = _AreYouReadyCommand;

  factory AreYouReadyCommand.fromJson(Map<String, dynamic> json) => _$AreYouReadyCommandFromJson(json);
}

@freezed
class PushButtonCommand with _$PushButtonCommand implements RpcCommand {
  static const String TYPE = 'push_button';
  const factory PushButtonCommand({
    required ButtonType button,
    required int id,
    @Default(PushButtonCommand.TYPE) String type,
  }) = _PushButtonCommand;

  factory PushButtonCommand.fromJson(Map<String, dynamic> json) => _$PushButtonCommandFromJson(json);
}

@freezed
class LEDControlCommand with _$LEDControlCommand implements RpcCommand {
  static const String TYPE = 'led_control';
  const factory LEDControlCommand({
    required LEDType led,
    required bool value,
    required int id,
    @Default(LEDControlCommand.TYPE) String type,
  }) = _LEDControlCommand;

  factory LEDControlCommand.fromJson(Map<String, dynamic> json) => _$LEDControlCommandFromJson(json);
}
