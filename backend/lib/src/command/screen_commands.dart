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
sealed class ScreenLockCommand with _$ScreenLockCommand implements RpcCommand {
  static const String TYPE = 'screen_lock';

  const factory ScreenLockCommand({
    required bool isLock,
    required int id,
    @Default(ScreenLockCommand.TYPE) String type,
  }) = _ScreenLockCommand;

  factory ScreenLockCommand.fromJson(Map<String, dynamic> json) => _$ScreenLockCommandFromJson(json);
}
