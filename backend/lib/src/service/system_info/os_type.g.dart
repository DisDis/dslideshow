// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'os_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const OSType _$linux = const OSType._('linux');
const OSType _$android = const OSType._('android');
const OSType _$ios = const OSType._('ios');
const OSType _$unknown = const OSType._('unknown');

OSType _$valueOf(String name) {
  switch (name) {
    case 'linux':
      return _$linux;
    case 'android':
      return _$android;
    case 'ios':
      return _$ios;
    case 'unknown':
      return _$unknown;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<OSType> _$values = new BuiltSet<OSType>(const <OSType>[
  _$linux,
  _$android,
  _$ios,
  _$unknown,
]);

Serializer<OSType> _$oSTypeSerializer = new _$OSTypeSerializer();

class _$OSTypeSerializer implements PrimitiveSerializer<OSType> {
  @override
  final Iterable<Type> types = const <Type>[OSType];
  @override
  final String wireName = 'OSType';

  @override
  Object serialize(Serializers serializers, OSType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  OSType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OSType.valueOf(serialized as String);
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
