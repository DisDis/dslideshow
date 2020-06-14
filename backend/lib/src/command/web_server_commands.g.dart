// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_server_commands.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<WebServerControlCommand> _$webServerControlCommandSerializer =
    new _$WebServerControlCommandSerializer();

class _$WebServerControlCommandSerializer
    implements StructuredSerializer<WebServerControlCommand> {
  @override
  final Iterable<Type> types = const [
    WebServerControlCommand,
    _$WebServerControlCommand
  ];
  @override
  final String wireName = 'WebServerControlCommand';

  @override
  Iterable<Object> serialize(
      Serializers serializers, WebServerControlCommand object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'enable',
      serializers.serialize(object.enable, specifiedType: const FullType(bool)),
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
  WebServerControlCommand deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WebServerControlCommandBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'enable':
          result.enable = serializers.deserialize(value,
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

class _$WebServerControlCommand extends WebServerControlCommand {
  @override
  final bool enable;
  @override
  final int id;

  factory _$WebServerControlCommand(
          [void Function(WebServerControlCommandBuilder) updates]) =>
      (new WebServerControlCommandBuilder()..update(updates)).build();

  _$WebServerControlCommand._({this.enable, this.id}) : super._() {
    if (enable == null) {
      throw new BuiltValueNullFieldError('WebServerControlCommand', 'enable');
    }
  }

  @override
  WebServerControlCommand rebuild(
          void Function(WebServerControlCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WebServerControlCommandBuilder toBuilder() =>
      new WebServerControlCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WebServerControlCommand &&
        enable == other.enable &&
        id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, enable.hashCode), id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('WebServerControlCommand')
          ..add('enable', enable)
          ..add('id', id))
        .toString();
  }
}

class WebServerControlCommandBuilder
    implements
        Builder<WebServerControlCommand, WebServerControlCommandBuilder> {
  _$WebServerControlCommand _$v;

  bool _enable;
  bool get enable => _$this._enable;
  set enable(bool enable) => _$this._enable = enable;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  WebServerControlCommandBuilder();

  WebServerControlCommandBuilder get _$this {
    if (_$v != null) {
      _enable = _$v.enable;
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WebServerControlCommand other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$WebServerControlCommand;
  }

  @override
  void update(void Function(WebServerControlCommandBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$WebServerControlCommand build() {
    final _$result =
        _$v ?? new _$WebServerControlCommand._(enable: enable, id: id);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
