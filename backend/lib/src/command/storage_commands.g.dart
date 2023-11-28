// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_commands.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GetMediaItemCommand> _$getMediaItemCommandSerializer =
    new _$GetMediaItemCommandSerializer();
Serializer<GetMediaItemCommandResult> _$getMediaItemCommandResultSerializer =
    new _$GetMediaItemCommandResultSerializer();
Serializer<StorageNextCommand> _$storageNextCommandSerializer =
    new _$StorageNextCommandSerializer();

class _$GetMediaItemCommandSerializer
    implements StructuredSerializer<GetMediaItemCommand> {
  @override
  final Iterable<Type> types = const [
    GetMediaItemCommand,
    _$GetMediaItemCommand
  ];
  @override
  final String wireName = 'GetMediaItemCommand';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GetMediaItemCommand object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'isCurrent',
      serializers.serialize(object.isCurrent,
          specifiedType: const FullType(bool)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GetMediaItemCommand deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GetMediaItemCommandBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'isCurrent':
          result.isCurrent = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GetMediaItemCommandResultSerializer
    implements StructuredSerializer<GetMediaItemCommandResult> {
  @override
  final Iterable<Type> types = const [
    GetMediaItemCommandResult,
    _$GetMediaItemCommandResult
  ];
  @override
  final String wireName = 'GetMediaItemCommandResult';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GetMediaItemCommandResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];
    Object? value;
    value = object.mediaId;
    if (value != null) {
      result
        ..add('mediaId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.mediaUri;
    if (value != null) {
      result
        ..add('mediaUri')
        ..add(serializers.serialize(value, specifiedType: const FullType(Uri)));
    }
    return result;
  }

  @override
  GetMediaItemCommandResult deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GetMediaItemCommandResultBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'mediaId':
          result.mediaId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'mediaUri':
          result.mediaUri = serializers.deserialize(value,
              specifiedType: const FullType(Uri)) as Uri?;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$StorageNextCommandSerializer
    implements StructuredSerializer<StorageNextCommand> {
  @override
  final Iterable<Type> types = const [StorageNextCommand, _$StorageNextCommand];
  @override
  final String wireName = 'StorageNextCommand';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, StorageNextCommand object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  StorageNextCommand deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new StorageNextCommandBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GetMediaItemCommand extends GetMediaItemCommand {
  @override
  final bool isCurrent;
  @override
  final int id;

  factory _$GetMediaItemCommand(
          [void Function(GetMediaItemCommandBuilder)? updates]) =>
      (new GetMediaItemCommandBuilder()..update(updates))._build();

  _$GetMediaItemCommand._({required this.isCurrent, required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        isCurrent, r'GetMediaItemCommand', 'isCurrent');
    BuiltValueNullFieldError.checkNotNull(id, r'GetMediaItemCommand', 'id');
  }

  @override
  GetMediaItemCommand rebuild(
          void Function(GetMediaItemCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetMediaItemCommandBuilder toBuilder() =>
      new GetMediaItemCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetMediaItemCommand &&
        isCurrent == other.isCurrent &&
        id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, isCurrent.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GetMediaItemCommand')
          ..add('isCurrent', isCurrent)
          ..add('id', id))
        .toString();
  }
}

class GetMediaItemCommandBuilder
    implements Builder<GetMediaItemCommand, GetMediaItemCommandBuilder> {
  _$GetMediaItemCommand? _$v;

  bool? _isCurrent;
  bool? get isCurrent => _$this._isCurrent;
  set isCurrent(bool? isCurrent) => _$this._isCurrent = isCurrent;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  GetMediaItemCommandBuilder() {
    GetMediaItemCommand._setDefaults(this);
  }

  GetMediaItemCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isCurrent = $v.isCurrent;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetMediaItemCommand other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetMediaItemCommand;
  }

  @override
  void update(void Function(GetMediaItemCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetMediaItemCommand build() => _build();

  _$GetMediaItemCommand _build() {
    final _$result = _$v ??
        new _$GetMediaItemCommand._(
            isCurrent: BuiltValueNullFieldError.checkNotNull(
                isCurrent, r'GetMediaItemCommand', 'isCurrent'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GetMediaItemCommand', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$GetMediaItemCommandResult extends GetMediaItemCommandResult {
  @override
  final String? mediaId;
  @override
  final Uri? mediaUri;
  @override
  final int id;

  factory _$GetMediaItemCommandResult(
          [void Function(GetMediaItemCommandResultBuilder)? updates]) =>
      (new GetMediaItemCommandResultBuilder()..update(updates))._build();

  _$GetMediaItemCommandResult._({this.mediaId, this.mediaUri, required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        id, r'GetMediaItemCommandResult', 'id');
  }

  @override
  GetMediaItemCommandResult rebuild(
          void Function(GetMediaItemCommandResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetMediaItemCommandResultBuilder toBuilder() =>
      new GetMediaItemCommandResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetMediaItemCommandResult &&
        mediaId == other.mediaId &&
        mediaUri == other.mediaUri &&
        id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, mediaId.hashCode);
    _$hash = $jc(_$hash, mediaUri.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GetMediaItemCommandResult')
          ..add('mediaId', mediaId)
          ..add('mediaUri', mediaUri)
          ..add('id', id))
        .toString();
  }
}

class GetMediaItemCommandResultBuilder
    implements
        Builder<GetMediaItemCommandResult, GetMediaItemCommandResultBuilder> {
  _$GetMediaItemCommandResult? _$v;

  String? _mediaId;
  String? get mediaId => _$this._mediaId;
  set mediaId(String? mediaId) => _$this._mediaId = mediaId;

  Uri? _mediaUri;
  Uri? get mediaUri => _$this._mediaUri;
  set mediaUri(Uri? mediaUri) => _$this._mediaUri = mediaUri;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  GetMediaItemCommandResultBuilder();

  GetMediaItemCommandResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _mediaId = $v.mediaId;
      _mediaUri = $v.mediaUri;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetMediaItemCommandResult other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetMediaItemCommandResult;
  }

  @override
  void update(void Function(GetMediaItemCommandResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetMediaItemCommandResult build() => _build();

  _$GetMediaItemCommandResult _build() {
    final _$result = _$v ??
        new _$GetMediaItemCommandResult._(
            mediaId: mediaId,
            mediaUri: mediaUri,
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GetMediaItemCommandResult', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$StorageNextCommand extends StorageNextCommand {
  @override
  final int id;

  factory _$StorageNextCommand(
          [void Function(StorageNextCommandBuilder)? updates]) =>
      (new StorageNextCommandBuilder()..update(updates))._build();

  _$StorageNextCommand._({required this.id}) : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'StorageNextCommand', 'id');
  }

  @override
  StorageNextCommand rebuild(
          void Function(StorageNextCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StorageNextCommandBuilder toBuilder() =>
      new StorageNextCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StorageNextCommand && id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StorageNextCommand')..add('id', id))
        .toString();
  }
}

class StorageNextCommandBuilder
    implements Builder<StorageNextCommand, StorageNextCommandBuilder> {
  _$StorageNextCommand? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  StorageNextCommandBuilder() {
    StorageNextCommand._setDefaults(this);
  }

  StorageNextCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StorageNextCommand other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$StorageNextCommand;
  }

  @override
  void update(void Function(StorageNextCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StorageNextCommand build() => _build();

  _$StorageNextCommand _build() {
    final _$result = _$v ??
        new _$StorageNextCommand._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'StorageNextCommand', 'id'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
