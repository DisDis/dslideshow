// GENERATED CODE - DO NOT MODIFY BY HAND

part of dslideshow.global.state;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const StorageStatusEnum _$download = const StorageStatusEnum._('download');
const StorageStatusEnum _$off = const StorageStatusEnum._('off');
const StorageStatusEnum _$done = const StorageStatusEnum._('done');

StorageStatusEnum _$valueOf(String name) {
  switch (name) {
    case 'download':
      return _$download;
    case 'off':
      return _$off;
    case 'done':
      return _$done;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<StorageStatusEnum> _$values =
    new BuiltSet<StorageStatusEnum>(const <StorageStatusEnum>[
  _$download,
  _$off,
  _$done,
]);

Serializer<StorageStatusEnum> _$storageStatusEnumSerializer =
    new _$StorageStatusEnumSerializer();

class _$StorageStatusEnumSerializer
    implements PrimitiveSerializer<StorageStatusEnum> {
  @override
  final Iterable<Type> types = const <Type>[StorageStatusEnum];
  @override
  final String wireName = 'StorageStatusEnum';

  @override
  Object serialize(Serializers serializers, StorageStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  StorageStatusEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      StorageStatusEnum.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
