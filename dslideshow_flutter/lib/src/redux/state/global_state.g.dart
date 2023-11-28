// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_state.dart';

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

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
