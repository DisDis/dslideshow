// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen_commands.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ScreenTurnCommand> _$screenTurnCommandSerializer =
    new _$ScreenTurnCommandSerializer();
Serializer<ScreenLockCommand> _$screenLockCommandSerializer =
    new _$ScreenLockCommandSerializer();

class _$ScreenTurnCommandSerializer
    implements StructuredSerializer<ScreenTurnCommand> {
  @override
  final Iterable<Type> types = const [ScreenTurnCommand, _$ScreenTurnCommand];
  @override
  final String wireName = 'ScreenTurnCommand';

  @override
  Iterable<Object?> serialize(Serializers serializers, ScreenTurnCommand object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'enabled',
      serializers.serialize(object.enabled,
          specifiedType: const FullType(bool)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  ScreenTurnCommand deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ScreenTurnCommandBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'enabled':
          result.enabled = serializers.deserialize(value,
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

class _$ScreenLockCommandSerializer
    implements StructuredSerializer<ScreenLockCommand> {
  @override
  final Iterable<Type> types = const [ScreenLockCommand, _$ScreenLockCommand];
  @override
  final String wireName = 'ScreenLockCommand';

  @override
  Iterable<Object?> serialize(Serializers serializers, ScreenLockCommand object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'isLock',
      serializers.serialize(object.isLock, specifiedType: const FullType(bool)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  ScreenLockCommand deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ScreenLockCommandBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'isLock':
          result.isLock = serializers.deserialize(value,
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

class _$ScreenTurnCommand extends ScreenTurnCommand {
  @override
  final bool enabled;
  @override
  final int id;

  factory _$ScreenTurnCommand(
          [void Function(ScreenTurnCommandBuilder)? updates]) =>
      (new ScreenTurnCommandBuilder()..update(updates)).build();

  _$ScreenTurnCommand._({required this.enabled, required this.id}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        enabled, 'ScreenTurnCommand', 'enabled');
    BuiltValueNullFieldError.checkNotNull(id, 'ScreenTurnCommand', 'id');
  }

  @override
  ScreenTurnCommand rebuild(void Function(ScreenTurnCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ScreenTurnCommandBuilder toBuilder() =>
      new ScreenTurnCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScreenTurnCommand &&
        enabled == other.enabled &&
        id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, enabled.hashCode), id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ScreenTurnCommand')
          ..add('enabled', enabled)
          ..add('id', id))
        .toString();
  }
}

class ScreenTurnCommandBuilder
    implements Builder<ScreenTurnCommand, ScreenTurnCommandBuilder> {
  _$ScreenTurnCommand? _$v;

  bool? _enabled;
  bool? get enabled => _$this._enabled;
  set enabled(bool? enabled) => _$this._enabled = enabled;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  ScreenTurnCommandBuilder();

  ScreenTurnCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _enabled = $v.enabled;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScreenTurnCommand other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ScreenTurnCommand;
  }

  @override
  void update(void Function(ScreenTurnCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ScreenTurnCommand build() {
    final _$result = _$v ??
        new _$ScreenTurnCommand._(
            enabled: BuiltValueNullFieldError.checkNotNull(
                enabled, 'ScreenTurnCommand', 'enabled'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, 'ScreenTurnCommand', 'id'));
    replace(_$result);
    return _$result;
  }
}

class _$ScreenLockCommand extends ScreenLockCommand {
  @override
  final bool isLock;
  @override
  final int id;

  factory _$ScreenLockCommand(
          [void Function(ScreenLockCommandBuilder)? updates]) =>
      (new ScreenLockCommandBuilder()..update(updates)).build();

  _$ScreenLockCommand._({required this.isLock, required this.id}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        isLock, 'ScreenLockCommand', 'isLock');
    BuiltValueNullFieldError.checkNotNull(id, 'ScreenLockCommand', 'id');
  }

  @override
  ScreenLockCommand rebuild(void Function(ScreenLockCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ScreenLockCommandBuilder toBuilder() =>
      new ScreenLockCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScreenLockCommand &&
        isLock == other.isLock &&
        id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, isLock.hashCode), id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ScreenLockCommand')
          ..add('isLock', isLock)
          ..add('id', id))
        .toString();
  }
}

class ScreenLockCommandBuilder
    implements Builder<ScreenLockCommand, ScreenLockCommandBuilder> {
  _$ScreenLockCommand? _$v;

  bool? _isLock;
  bool? get isLock => _$this._isLock;
  set isLock(bool? isLock) => _$this._isLock = isLock;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  ScreenLockCommandBuilder();

  ScreenLockCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isLock = $v.isLock;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScreenLockCommand other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ScreenLockCommand;
  }

  @override
  void update(void Function(ScreenLockCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ScreenLockCommand build() {
    final _$result = _$v ??
        new _$ScreenLockCommand._(
            isLock: BuiltValueNullFieldError.checkNotNull(
                isLock, 'ScreenLockCommand', 'isLock'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, 'ScreenLockCommand', 'id'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
