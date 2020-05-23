import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:dslideshow_common/rpc.dart';

part 'empty_result.g.dart';

abstract class EmptyResult implements RpcResult, Built<EmptyResult, EmptyResultBuilder> {
  @override
  @nullable
  int get id;

  static Serializer<EmptyResult> get serializer => _$emptyResultSerializer;


  factory EmptyResult([void updates(EmptyResultBuilder b)]) = _$EmptyResult;
  EmptyResult._();
}