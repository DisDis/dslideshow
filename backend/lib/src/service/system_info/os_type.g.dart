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

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
