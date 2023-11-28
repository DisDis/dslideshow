// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SensorInfo> _$sensorInfoSerializer = new _$SensorInfoSerializer();

class _$SensorInfoSerializer implements StructuredSerializer<SensorInfo> {
  @override
  final Iterable<Type> types = const [SensorInfo, _$SensorInfo];
  @override
  final String wireName = 'SensorInfo';

  @override
  Iterable<Object?> serialize(Serializers serializers, SensorInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'value',
      serializers.serialize(object.value,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  SensorInfo deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SensorInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'value':
          result.value = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$SensorInfo extends SensorInfo {
  @override
  final String name;
  @override
  final String value;

  factory _$SensorInfo([void Function(SensorInfoBuilder)? updates]) =>
      (new SensorInfoBuilder()..update(updates))._build();

  _$SensorInfo._({required this.name, required this.value}) : super._() {
    BuiltValueNullFieldError.checkNotNull(name, r'SensorInfo', 'name');
    BuiltValueNullFieldError.checkNotNull(value, r'SensorInfo', 'value');
  }

  @override
  SensorInfo rebuild(void Function(SensorInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SensorInfoBuilder toBuilder() => new SensorInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SensorInfo && name == other.name && value == other.value;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SensorInfo')
          ..add('name', name)
          ..add('value', value))
        .toString();
  }
}

class SensorInfoBuilder implements Builder<SensorInfo, SensorInfoBuilder> {
  _$SensorInfo? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _value;
  String? get value => _$this._value;
  set value(String? value) => _$this._value = value;

  SensorInfoBuilder();

  SensorInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SensorInfo other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SensorInfo;
  }

  @override
  void update(void Function(SensorInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SensorInfo build() => _build();

  _$SensorInfo _build() {
    final _$result = _$v ??
        new _$SensorInfo._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'SensorInfo', 'name'),
            value: BuiltValueNullFieldError.checkNotNull(
                value, r'SensorInfo', 'value'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
