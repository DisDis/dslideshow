// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'os_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<OSInfo> _$oSInfoSerializer = new _$OSInfoSerializer();

class _$OSInfoSerializer implements StructuredSerializer<OSInfo> {
  @override
  final Iterable<Type> types = const [OSInfo, _$OSInfo];
  @override
  final String wireName = 'OSInfo';

  @override
  Iterable<Object> serialize(Serializers serializers, OSInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  OSInfo deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OSInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$OSInfo extends OSInfo {
  @override
  final String name;

  factory _$OSInfo([void Function(OSInfoBuilder) updates]) =>
      (new OSInfoBuilder()..update(updates)).build();

  _$OSInfo._({this.name}) : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('OSInfo', 'name');
    }
  }

  @override
  OSInfo rebuild(void Function(OSInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OSInfoBuilder toBuilder() => new OSInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OSInfo && name == other.name;
  }

  @override
  int get hashCode {
    return $jf($jc(0, name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OSInfo')..add('name', name))
        .toString();
  }
}

class OSInfoBuilder implements Builder<OSInfo, OSInfoBuilder> {
  _$OSInfo _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  OSInfoBuilder();

  OSInfoBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OSInfo other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$OSInfo;
  }

  @override
  void update(void Function(OSInfoBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$OSInfo build() {
    final _$result = _$v ?? new _$OSInfo._(name: name);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
