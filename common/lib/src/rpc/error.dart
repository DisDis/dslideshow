library rpc.error;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:dslideshow_common/rpc.dart';

part 'package:dslideshow_common/src/rpc/error.g.dart';

abstract class ErrorResult implements RpcErrorResult, Built<ErrorResult, ErrorResultBuilder> {
  String get error;
  int get id;

  static Serializer<ErrorResult> get serializer =>
      _$errorResultSerializer;

  factory ErrorResult([void updates(ErrorResultBuilder b)?]) = _$ErrorResult;
  ErrorResult._();
}