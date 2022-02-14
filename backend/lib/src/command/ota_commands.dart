import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:built_collection/built_collection.dart';

part 'ota_commands.g.dart';

abstract class OTAReadyCommand implements RpcCommand, Built<OTAReadyCommand, OTAReadyCommandBuilder> {
  static const String TYPE = 'ota_ready';
  @override
  String get type => TYPE;
  @override
  int get id;
  bool get ready;

  static Serializer<OTAReadyCommand> get serializer => _$oTAReadyCommandSerializer;

  factory OTAReadyCommand([void updates(OTAReadyCommandBuilder b)?]) = _$OTAReadyCommand;
  OTAReadyCommand._();
}

abstract class OTAGetInfoCommand implements RpcCommand, Built<OTAGetInfoCommand, OTAGetInfoCommandBuilder> {
  static const String TYPE = 'ota_getinfo';
  @override
  String get type => TYPE;
  @override
  int get id;

  OTAInfo? get info;

  static Serializer<OTAGetInfoCommand> get serializer => _$oTAGetInfoCommandSerializer;

  factory OTAGetInfoCommand([void updates(OTAGetInfoCommandBuilder b)?]) = _$OTAGetInfoCommand;
  OTAGetInfoCommand._();
}

abstract class OTAGetInfoCommandResult
    implements RpcResult, Built<OTAGetInfoCommandResult, OTAGetInfoCommandResultBuilder> {
  OTAInfo get info;
  @override
  int get id;

  static Serializer<OTAGetInfoCommandResult> get serializer => _$oTAGetInfoCommandResultSerializer;

  factory OTAGetInfoCommandResult([void updates(OTAGetInfoCommandResultBuilder b)]) = _$OTAGetInfoCommandResult;
  OTAGetInfoCommandResult._();
}

abstract class OTAOutputCommand implements RpcCommand, Built<OTAOutputCommand, OTAOutputCommandBuilder> {
  static const String TYPE = 'ota_output';
  @override
  String get type => TYPE;
  @override
  int get id;

  String get output;

  static Serializer<OTAOutputCommand> get serializer => _$oTAOutputCommandSerializer;

  factory OTAOutputCommand([void updates(OTAOutputCommandBuilder b)?]) = _$OTAOutputCommand;
  OTAOutputCommand._();
}

abstract class OTAInfo implements Built<OTAInfo, OTAInfoBuilder> {
  static Serializer<OTAInfo> get serializer => _$oTAInfoSerializer;

  OTAStatus get status;
  double get uploadingPercent;
  String get code;

  int? get exitCode;

  String? get errorText;

  factory OTAInfo([void updates(OTAInfoBuilder b)?]) = _$OTAInfo;
  OTAInfo._();
}

class OTAStatus extends EnumClass {
  static Serializer<OTAStatus> get serializer => _$oTAStatusSerializer;

  static const OTAStatus disabled = _$disabled;
  static const OTAStatus ready = _$ready;
  static const OTAStatus uploading = _$uploading;
  static const OTAStatus instaling = _$instaling;
  static const OTAStatus finished = _$finished;
  static const OTAStatus issue = _$issue;
  static const OTAStatus preReboot = _$preReboot;

  const OTAStatus._(String name) : super(name);

  static BuiltSet<OTAStatus> get values => _$valuesOTAStatus;
  static OTAStatus valueOf(String name) => _$valueOTAStatusOf(name);
}
