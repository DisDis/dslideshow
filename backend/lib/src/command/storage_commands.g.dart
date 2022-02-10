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
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'isCurrent':
          result.isCurrent = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
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
      final key = iterator.current as String;
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
              specifiedType: const FullType(int)) as int;
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
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
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
      (new GetMediaItemCommandBuilder()..update(updates)).build();

  _$GetMediaItemCommand._({required this.isCurrent, required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        isCurrent, 'GetMediaItemCommand', 'isCurrent');
    BuiltValueNullFieldError.checkNotNull(id, 'GetMediaItemCommand', 'id');
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
    return $jf($jc($jc(0, isCurrent.hashCode), id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GetMediaItemCommand')
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

  GetMediaItemCommandBuilder();

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
  _$GetMediaItemCommand build() {
    final _$result = _$v ??
        new _$GetMediaItemCommand._(
            isCurrent: BuiltValueNullFieldError.checkNotNull(
                isCurrent, 'GetMediaItemCommand', 'isCurrent'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, 'GetMediaItemCommand', 'id'));
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
      (new GetMediaItemCommandResultBuilder()..update(updates)).build();

  _$GetMediaItemCommandResult._({this.mediaId, this.mediaUri, required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        id, 'GetMediaItemCommandResult', 'id');
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
    return $jf(
        $jc($jc($jc(0, mediaId.hashCode), mediaUri.hashCode), id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GetMediaItemCommandResult')
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
  _$GetMediaItemCommandResult build() {
    final _$result = _$v ??
        new _$GetMediaItemCommandResult._(
            mediaId: mediaId,
            mediaUri: mediaUri,
            id: BuiltValueNullFieldError.checkNotNull(
                id, 'GetMediaItemCommandResult', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$StorageNextCommand extends StorageNextCommand {
  @override
  final int id;

  factory _$StorageNextCommand(
          [void Function(StorageNextCommandBuilder)? updates]) =>
      (new StorageNextCommandBuilder()..update(updates)).build();

  _$StorageNextCommand._({required this.id}) : super._() {
    BuiltValueNullFieldError.checkNotNull(id, 'StorageNextCommand', 'id');
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
    return $jf($jc(0, id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('StorageNextCommand')..add('id', id))
        .toString();
  }
}

class StorageNextCommandBuilder
    implements Builder<StorageNextCommand, StorageNextCommandBuilder> {
  _$StorageNextCommand? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  StorageNextCommandBuilder();

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
  _$StorageNextCommand build() {
    final _$result = _$v ??
        new _$StorageNextCommand._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, 'StorageNextCommand', 'id'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
