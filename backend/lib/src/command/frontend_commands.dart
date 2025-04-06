import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dslideshow_common/rpc.dart';

part 'frontend_commands.freezed.dart';
part 'frontend_commands.g.dart';

@freezed
sealed class UpdateFrontendStateCommand with _$UpdateFrontendStateCommand implements RpcCommand {
  static const String TYPE = 'updateFrontendState';
  const factory UpdateFrontendStateCommand({
    @Default(UpdateFrontendStateCommand.TYPE) String type,
    required int id,
    bool? isPaused,
    bool? isMenu,
  }) = _UpdateFrontendStateCommand;

  factory UpdateFrontendStateCommand.fromJson(Map<String, dynamic> json) => _$UpdateFrontendStateCommandFromJson(json);
}
