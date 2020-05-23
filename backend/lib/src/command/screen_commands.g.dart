// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen_commands.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ScreenTurnCommand> _$screenTurnCommandSerializer =
    new _$ScreenTurnCommandSerializer();

class _$ScreenTurnCommandSerializer
    implements StructuredSerializer<ScreenTurnCommand> {
  @override
  final Iterable<Type> types = const [ScreenTurnCommand, _$ScreenTurnCommand];
  @override
  final String wireName = 'ScreenTurnCommand';

  @override
  Iterable<Object> serialize(Serializers serializers, ScreenTurnCommand object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'enabled',
      serializers.serialize(object.enabled,
          specifiedType: const FullType(bool)),
    ];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  ScreenTurnCommand deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ScreenTurnCommandBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
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

class _$ScreenTurnCommand extends ScreenTurnCommand {
  @override
  final bool enabled;
  @override
  final int id;

  factory _$ScreenTurnCommand(
          [void Function(ScreenTurnCommandBuilder) updates]) =>
      (new ScreenTurnCommandBuilder()..update(updates)).build();

  _$ScreenTurnCommand._({this.enabled, this.id}) : super._() {
    if (enabled == null) {
      throw new BuiltValueNullFieldError('ScreenTurnCommand', 'enabled');
    }
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
  _$ScreenTurnCommand _$v;

  bool _enabled;
  bool get enabled => _$this._enabled;
  set enabled(bool enabled) => _$this._enabled = enabled;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  ScreenTurnCommandBuilder();

  ScreenTurnCommandBuilder get _$this {
    if (_$v != null) {
      _enabled = _$v.enabled;
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScreenTurnCommand other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ScreenTurnCommand;
  }

  @override
  void update(void Function(ScreenTurnCommandBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ScreenTurnCommand build() {
    final _$result = _$v ?? new _$ScreenTurnCommand._(enabled: enabled, id: id);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
