import 'package:dslideshow_common/rpc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'screen_commands.g.dart';
part 'screen_commands.freezed.dart';

@freezed
sealed class ScreenTurnCommand with _$ScreenTurnCommand implements RpcCommand {
  static const String TYPE = 'screen_turn';
  const factory ScreenTurnCommand({
    required bool enabled,
    required int id,
    @Default(ScreenTurnCommand.TYPE) String type,
  }) = _ScreenTurnCommand;

  factory ScreenTurnCommand.fromJson(Map<String, dynamic> json) => _$ScreenTurnCommandFromJson(json);
}

@freezed
sealed class ScreenToggleCommand with _$ScreenToggleCommand implements RpcCommand {
  static const String TYPE = 'screen_toggle';

  const factory ScreenToggleCommand({required int id, @Default(ScreenToggleCommand.TYPE) String type}) =
      _ScreenToggleCommand;

  factory ScreenToggleCommand.fromJson(Map<String, dynamic> json) => _$ScreenToggleCommandFromJson(json);
}
