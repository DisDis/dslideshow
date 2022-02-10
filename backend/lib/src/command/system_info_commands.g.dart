// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_info_commands.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GetSystemInfoCommand> _$getSystemInfoCommandSerializer =
    new _$GetSystemInfoCommandSerializer();
Serializer<GetSystemInfoCommandResult> _$getSystemInfoCommandResultSerializer =
    new _$GetSystemInfoCommandResultSerializer();

class _$GetSystemInfoCommandSerializer
    implements StructuredSerializer<GetSystemInfoCommand> {
  @override
  final Iterable<Type> types = const [
    GetSystemInfoCommand,
    _$GetSystemInfoCommand
  ];
  @override
  final String wireName = 'GetSystemInfoCommand';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GetSystemInfoCommand object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GetSystemInfoCommand deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GetSystemInfoCommandBuilder();

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

class _$GetSystemInfoCommandResultSerializer
    implements StructuredSerializer<GetSystemInfoCommandResult> {
  @override
  final Iterable<Type> types = const [
    GetSystemInfoCommandResult,
    _$GetSystemInfoCommandResult
  ];
  @override
  final String wireName = 'GetSystemInfoCommandResult';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GetSystemInfoCommandResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'systemInfo',
      serializers.serialize(object.systemInfo,
          specifiedType: const FullType(SystemInfo)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GetSystemInfoCommandResult deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GetSystemInfoCommandResultBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'systemInfo':
          result.systemInfo.replace(serializers.deserialize(value,
              specifiedType: const FullType(SystemInfo))! as SystemInfo);
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

class _$GetSystemInfoCommand extends GetSystemInfoCommand {
  @override
  final int id;

  factory _$GetSystemInfoCommand(
          [void Function(GetSystemInfoCommandBuilder)? updates]) =>
      (new GetSystemInfoCommandBuilder()..update(updates)).build();

  _$GetSystemInfoCommand._({required this.id}) : super._() {
    BuiltValueNullFieldError.checkNotNull(id, 'GetSystemInfoCommand', 'id');
  }

  @override
  GetSystemInfoCommand rebuild(
          void Function(GetSystemInfoCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetSystemInfoCommandBuilder toBuilder() =>
      new GetSystemInfoCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetSystemInfoCommand && id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc(0, id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GetSystemInfoCommand')..add('id', id))
        .toString();
  }
}

class GetSystemInfoCommandBuilder
    implements Builder<GetSystemInfoCommand, GetSystemInfoCommandBuilder> {
  _$GetSystemInfoCommand? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  GetSystemInfoCommandBuilder();

  GetSystemInfoCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetSystemInfoCommand other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetSystemInfoCommand;
  }

  @override
  void update(void Function(GetSystemInfoCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GetSystemInfoCommand build() {
    final _$result = _$v ??
        new _$GetSystemInfoCommand._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, 'GetSystemInfoCommand', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$GetSystemInfoCommandResult extends GetSystemInfoCommandResult {
  @override
  final SystemInfo systemInfo;
  @override
  final int id;

  factory _$GetSystemInfoCommandResult(
          [void Function(GetSystemInfoCommandResultBuilder)? updates]) =>
      (new GetSystemInfoCommandResultBuilder()..update(updates)).build();

  _$GetSystemInfoCommandResult._({required this.systemInfo, required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        systemInfo, 'GetSystemInfoCommandResult', 'systemInfo');
    BuiltValueNullFieldError.checkNotNull(
        id, 'GetSystemInfoCommandResult', 'id');
  }

  @override
  GetSystemInfoCommandResult rebuild(
          void Function(GetSystemInfoCommandResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetSystemInfoCommandResultBuilder toBuilder() =>
      new GetSystemInfoCommandResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetSystemInfoCommandResult &&
        systemInfo == other.systemInfo &&
        id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, systemInfo.hashCode), id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GetSystemInfoCommandResult')
          ..add('systemInfo', systemInfo)
          ..add('id', id))
        .toString();
  }
}

class GetSystemInfoCommandResultBuilder
    implements
        Builder<GetSystemInfoCommandResult, GetSystemInfoCommandResultBuilder> {
  _$GetSystemInfoCommandResult? _$v;

  SystemInfoBuilder? _systemInfo;
  SystemInfoBuilder get systemInfo =>
      _$this._systemInfo ??= new SystemInfoBuilder();
  set systemInfo(SystemInfoBuilder? systemInfo) =>
      _$this._systemInfo = systemInfo;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  GetSystemInfoCommandResultBuilder();

  GetSystemInfoCommandResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _systemInfo = $v.systemInfo.toBuilder();
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetSystemInfoCommandResult other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetSystemInfoCommandResult;
  }

  @override
  void update(void Function(GetSystemInfoCommandResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GetSystemInfoCommandResult build() {
    _$GetSystemInfoCommandResult _$result;
    try {
      _$result = _$v ??
          new _$GetSystemInfoCommandResult._(
              systemInfo: systemInfo.build(),
              id: BuiltValueNullFieldError.checkNotNull(
                  id, 'GetSystemInfoCommandResult', 'id'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'systemInfo';
        systemInfo.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GetSystemInfoCommandResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
