// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'echo.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<EchoCommand> _$echoCommandSerializer = new _$EchoCommandSerializer();
Serializer<EchoCommandResult> _$echoCommandResultSerializer =
    new _$EchoCommandResultSerializer();

class _$EchoCommandSerializer implements StructuredSerializer<EchoCommand> {
  @override
  final Iterable<Type> types = const [EchoCommand, _$EchoCommand];
  @override
  final String wireName = 'EchoCommand';

  @override
  Iterable<Object> serialize(Serializers serializers, EchoCommand object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'text',
      serializers.serialize(object.text, specifiedType: const FullType(String)),
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
  EchoCommand deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new EchoCommandBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'text':
          result.text = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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

class _$EchoCommandResultSerializer
    implements StructuredSerializer<EchoCommandResult> {
  @override
  final Iterable<Type> types = const [EchoCommandResult, _$EchoCommandResult];
  @override
  final String wireName = 'EchoCommandResult';

  @override
  Iterable<Object> serialize(Serializers serializers, EchoCommandResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'resultText',
      serializers.serialize(object.resultText,
          specifiedType: const FullType(String)),
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
  EchoCommandResult deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new EchoCommandResultBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'resultText':
          result.resultText = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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

class _$EchoCommand extends EchoCommand {
  @override
  final String text;
  @override
  final int id;

  factory _$EchoCommand([void Function(EchoCommandBuilder)? updates]) =>
      (new EchoCommandBuilder()..update(updates)).build();

  _$EchoCommand._({this.text, this.id}) : super._() {
    if (text == null) {
      throw new BuiltValueNullFieldError('EchoCommand', 'text');
    }
  }

  @override
  EchoCommand rebuild(void Function(EchoCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EchoCommandBuilder toBuilder() => new EchoCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EchoCommand && text == other.text && id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, text.hashCode), id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('EchoCommand')
          ..add('text', text)
          ..add('id', id))
        .toString();
  }
}

class EchoCommandBuilder implements Builder<EchoCommand, EchoCommandBuilder> {
  _$EchoCommand _$v;

  String _text;
  String get text => _$this._text;
  set text(String text) => _$this._text = text;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  EchoCommandBuilder();

  EchoCommandBuilder get _$this {
    if (_$v != null) {
      _text = _$v.text;
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EchoCommand other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$EchoCommand;
  }

  @override
  void update(void Function(EchoCommandBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$EchoCommand build() {
    final _$result = _$v ?? new _$EchoCommand._(text: text, id: id);
    replace(_$result);
    return _$result;
  }
}

class _$EchoCommandResult extends EchoCommandResult {
  @override
  final String resultText;
  @override
  final int id;

  factory _$EchoCommandResult(
          [void Function(EchoCommandResultBuilder)? updates]) =>
      (new EchoCommandResultBuilder()..update(updates)).build();

  _$EchoCommandResult._({this.resultText, this.id}) : super._() {
    if (resultText == null) {
      throw new BuiltValueNullFieldError('EchoCommandResult', 'resultText');
    }
  }

  @override
  EchoCommandResult rebuild(void Function(EchoCommandResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EchoCommandResultBuilder toBuilder() =>
      new EchoCommandResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EchoCommandResult &&
        resultText == other.resultText &&
        id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, resultText.hashCode), id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('EchoCommandResult')
          ..add('resultText', resultText)
          ..add('id', id))
        .toString();
  }
}

class EchoCommandResultBuilder
    implements Builder<EchoCommandResult, EchoCommandResultBuilder> {
  _$EchoCommandResult _$v;

  String _resultText;
  String get resultText => _$this._resultText;
  set resultText(String resultText) => _$this._resultText = resultText;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  EchoCommandResultBuilder();

  EchoCommandResultBuilder get _$this {
    if (_$v != null) {
      _resultText = _$v.resultText;
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EchoCommandResult other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$EchoCommandResult;
  }

  @override
  void update(void Function(EchoCommandResultBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$EchoCommandResult build() {
    final _$result =
        _$v ?? new _$EchoCommandResult._(resultText: resultText, id: id);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
