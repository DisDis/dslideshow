import 'package:dslideshow_common/rpc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'empty_result.freezed.dart';
part 'empty_result.g.dart';

@freezed
sealed class EmptyResult with _$EmptyResult implements RpcResult {
  static EmptyResult respond(RpcCommand command) => EmptyResult(id: command.id);
  const factory EmptyResult({required int id}) = _EmptyResult;
  factory EmptyResult.fromJson(Map<String, dynamic> json) =>
      _$EmptyResultFromJson(json);
}
