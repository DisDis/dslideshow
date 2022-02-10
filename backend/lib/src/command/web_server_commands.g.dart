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
  Iterable<Object?> serialize(
      Serializers serializers, WebServerControlCommand object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'enable',
      serializers.serialize(object.enable, specifiedType: const FullType(bool)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  WebServerControlCommand deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WebServerControlCommandBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
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
          [void Function(WebServerControlCommandBuilder)? updates]) =>
      (new WebServerControlCommandBuilder()..update(updates)).build();

  _$WebServerControlCommand._({required this.enable, required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        enable, 'WebServerControlCommand', 'enable');
    BuiltValueNullFieldError.checkNotNull(id, 'WebServerControlCommand', 'id');
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
  _$WebServerControlCommand? _$v;

  bool? _enable;
  bool? get enable => _$this._enable;
  set enable(bool? enable) => _$this._enable = enable;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  WebServerControlCommandBuilder();

  WebServerControlCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _enable = $v.enable;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WebServerControlCommand other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WebServerControlCommand;
  }

  @override
  void update(void Function(WebServerControlCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$WebServerControlCommand build() {
    final _$result = _$v ??
        new _$WebServerControlCommand._(
            enable: BuiltValueNullFieldError.checkNotNull(
                enable, 'WebServerControlCommand', 'enable'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, 'WebServerControlCommand', 'id'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
