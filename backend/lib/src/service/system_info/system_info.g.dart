// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SystemInfo> _$systemInfoSerializer = new _$SystemInfoSerializer();

class _$SystemInfoSerializer implements StructuredSerializer<SystemInfo> {
  @override
  final Iterable<Type> types = const [SystemInfo, _$SystemInfo];
  @override
  final String wireName = 'SystemInfo';

  @override
  Iterable<Object> serialize(Serializers serializers, SystemInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'cpuInfo',
      serializers.serialize(object.cpuInfo,
          specifiedType: const FullType(CpuInfo)),
      'networkInfo',
      serializers.serialize(object.networkInfo,
          specifiedType: const FullType(NetworkInfo)),
      'osInfo',
      serializers.serialize(object.osInfo,
          specifiedType: const FullType(OSInfo)),
      'updateInfo',
      serializers.serialize(object.updateInfo,
          specifiedType: const FullType(UpdateInfo)),
    ];

    return result;
  }

  @override
  SystemInfo deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SystemInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'cpuInfo':
          result.cpuInfo.replace(serializers.deserialize(value,
              specifiedType: const FullType(CpuInfo)) as CpuInfo);
          break;
        case 'networkInfo':
          result.networkInfo.replace(serializers.deserialize(value,
              specifiedType: const FullType(NetworkInfo)) as NetworkInfo);
          break;
        case 'osInfo':
          result.osInfo.replace(serializers.deserialize(value,
              specifiedType: const FullType(OSInfo)) as OSInfo);
          break;
        case 'updateInfo':
          result.updateInfo.replace(serializers.deserialize(value,
              specifiedType: const FullType(UpdateInfo)) as UpdateInfo);
          break;
      }
    }

    return result.build();
  }
}

class _$SystemInfo extends SystemInfo {
  @override
  final CpuInfo cpuInfo;
  @override
  final NetworkInfo networkInfo;
  @override
  final OSInfo osInfo;
  @override
  final UpdateInfo updateInfo;

  factory _$SystemInfo([void Function(SystemInfoBuilder)? updates]) =>
      (new SystemInfoBuilder()..update(updates)).build();

  _$SystemInfo._({this.cpuInfo, this.networkInfo, this.osInfo, this.updateInfo})
      : super._() {
    if (cpuInfo == null) {
      throw new BuiltValueNullFieldError('SystemInfo', 'cpuInfo');
    }
    if (networkInfo == null) {
      throw new BuiltValueNullFieldError('SystemInfo', 'networkInfo');
    }
    if (osInfo == null) {
      throw new BuiltValueNullFieldError('SystemInfo', 'osInfo');
    }
    if (updateInfo == null) {
      throw new BuiltValueNullFieldError('SystemInfo', 'updateInfo');
    }
  }

  @override
  SystemInfo rebuild(void Function(SystemInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SystemInfoBuilder toBuilder() => new SystemInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SystemInfo &&
        cpuInfo == other.cpuInfo &&
        networkInfo == other.networkInfo &&
        osInfo == other.osInfo &&
        updateInfo == other.updateInfo;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, cpuInfo.hashCode), networkInfo.hashCode),
            osInfo.hashCode),
        updateInfo.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SystemInfo')
          ..add('cpuInfo', cpuInfo)
          ..add('networkInfo', networkInfo)
          ..add('osInfo', osInfo)
          ..add('updateInfo', updateInfo))
        .toString();
  }
}

class SystemInfoBuilder implements Builder<SystemInfo, SystemInfoBuilder> {
  _$SystemInfo _$v;

  CpuInfoBuilder _cpuInfo;
  CpuInfoBuilder get cpuInfo => _$this._cpuInfo ??= new CpuInfoBuilder();
  set cpuInfo(CpuInfoBuilder cpuInfo) => _$this._cpuInfo = cpuInfo;

  NetworkInfoBuilder _networkInfo;
  NetworkInfoBuilder get networkInfo =>
      _$this._networkInfo ??= new NetworkInfoBuilder();
  set networkInfo(NetworkInfoBuilder networkInfo) =>
      _$this._networkInfo = networkInfo;

  OSInfoBuilder _osInfo;
  OSInfoBuilder get osInfo => _$this._osInfo ??= new OSInfoBuilder();
  set osInfo(OSInfoBuilder osInfo) => _$this._osInfo = osInfo;

  UpdateInfoBuilder _updateInfo;
  UpdateInfoBuilder get updateInfo =>
      _$this._updateInfo ??= new UpdateInfoBuilder();
  set updateInfo(UpdateInfoBuilder updateInfo) =>
      _$this._updateInfo = updateInfo;

  SystemInfoBuilder();

  SystemInfoBuilder get _$this {
    if (_$v != null) {
      _cpuInfo = _$v.cpuInfo?.toBuilder();
      _networkInfo = _$v.networkInfo?.toBuilder();
      _osInfo = _$v.osInfo?.toBuilder();
      _updateInfo = _$v.updateInfo?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SystemInfo other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SystemInfo;
  }

  @override
  void update(void Function(SystemInfoBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SystemInfo build() {
    _$SystemInfo _$result;
    try {
      _$result = _$v ??
          new _$SystemInfo._(
              cpuInfo: cpuInfo.build(),
              networkInfo: networkInfo.build(),
              osInfo: osInfo.build(),
              updateInfo: updateInfo.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'cpuInfo';
        cpuInfo.build();
        _$failedField = 'networkInfo';
        networkInfo.build();
        _$failedField = 'osInfo';
        osInfo.build();
        _$failedField = 'updateInfo';
        updateInfo.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SystemInfo', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
