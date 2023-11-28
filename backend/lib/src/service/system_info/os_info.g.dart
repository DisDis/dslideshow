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
  Iterable<Object?> serialize(Serializers serializers, OSInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.osType;
    if (value != null) {
      result
        ..add('osType')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(OSType)));
    }
    return result;
  }

  @override
  OSInfo deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OSInfoBuilder();

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
        case 'osType':
          result.osType = serializers.deserialize(value,
              specifiedType: const FullType(OSType)) as OSType?;
          break;
      }
    }

    return result.build();
  }
}

class _$OSInfo extends OSInfo {
  @override
  final String name;
  @override
  final OSType? osType;

  factory _$OSInfo([void Function(OSInfoBuilder)? updates]) =>
      (new OSInfoBuilder()..update(updates))._build();

  _$OSInfo._({required this.name, this.osType}) : super._() {
    BuiltValueNullFieldError.checkNotNull(name, r'OSInfo', 'name');
  }

  @override
  OSInfo rebuild(void Function(OSInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OSInfoBuilder toBuilder() => new OSInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OSInfo && name == other.name && osType == other.osType;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, osType.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OSInfo')
          ..add('name', name)
          ..add('osType', osType))
        .toString();
  }
}

class OSInfoBuilder implements Builder<OSInfo, OSInfoBuilder> {
  _$OSInfo? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  OSType? _osType;
  OSType? get osType => _$this._osType;
  set osType(OSType? osType) => _$this._osType = osType;

  OSInfoBuilder();

  OSInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _osType = $v.osType;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OSInfo other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$OSInfo;
  }

  @override
  void update(void Function(OSInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OSInfo build() => _build();

  _$OSInfo _build() {
    final _$result = _$v ??
        new _$OSInfo._(
            name:
                BuiltValueNullFieldError.checkNotNull(name, r'OSInfo', 'name'),
            osType: osType);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
