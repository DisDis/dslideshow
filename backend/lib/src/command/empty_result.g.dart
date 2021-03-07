// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'empty_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<EmptyResult> _$emptyResultSerializer = new _$EmptyResultSerializer();

class _$EmptyResultSerializer implements StructuredSerializer<EmptyResult> {
  @override
  final Iterable<Type> types = const [EmptyResult, _$EmptyResult];
  @override
  final String wireName = 'EmptyResult';

  @override
  Iterable<Object> serialize(Serializers serializers, EmptyResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  EmptyResult deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new EmptyResultBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
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

class _$EmptyResult extends EmptyResult {
  @override
  final int id;

  factory _$EmptyResult([void Function(EmptyResultBuilder)? updates]) =>
      (new EmptyResultBuilder()..update(updates)).build();

  _$EmptyResult._({this.id}) : super._();

  @override
  EmptyResult rebuild(void Function(EmptyResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EmptyResultBuilder toBuilder() => new EmptyResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EmptyResult && id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc(0, id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('EmptyResult')..add('id', id))
        .toString();
  }
}

class EmptyResultBuilder implements Builder<EmptyResult, EmptyResultBuilder> {
  _$EmptyResult _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  EmptyResultBuilder();

  EmptyResultBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EmptyResult other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$EmptyResult;
  }

  @override
  void update(void Function(EmptyResultBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$EmptyResult build() {
    final _$result = _$v ?? new _$EmptyResult._(id: id);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
