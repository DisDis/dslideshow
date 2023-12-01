library rpc.error;

import 'package:dslideshow_common/rpc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'error.g.dart';
part 'error.freezed.dart';

@freezed
class ErrorResult with _$ErrorResult implements RpcErrorResult {
  const factory ErrorResult({
    required String error,
    required int id,
  }) = _ErrorResult;

  factory ErrorResult.fromJson(Map<String, dynamic> json) => _$ErrorResultFromJson(json);
}
