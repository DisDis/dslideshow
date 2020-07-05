import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'os_type.g.dart';

class OSType extends EnumClass {
  static const OSType linux = _$linux;
  static const OSType android = _$android;
  static const OSType ios = _$ios;
  static const OSType unknown = _$unknown;

  static Serializer<OSType> get serializer => _$oSTypeSerializer;

  static BuiltSet<OSType> get values => _$values;

  const OSType._(String name) : super(name);
  static OSType valueOf(String name) => _$valueOf(name);
}
