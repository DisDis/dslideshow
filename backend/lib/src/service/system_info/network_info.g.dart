// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const NetworkInterfaceStatus _$running =
    const NetworkInterfaceStatus._('running');
const NetworkInterfaceStatus _$offline =
    const NetworkInterfaceStatus._('offline');

NetworkInterfaceStatus _$valueNetStatusOf(String name) {
  switch (name) {
    case 'running':
      return _$running;
    case 'offline':
      return _$offline;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<NetworkInterfaceStatus> _$valuesNetStatus =
    new BuiltSet<NetworkInterfaceStatus>(const <NetworkInterfaceStatus>[
  _$running,
  _$offline,
]);

Serializer<NetworkInfo> _$networkInfoSerializer = new _$NetworkInfoSerializer();
Serializer<NetworkInterfaceInfo> _$networkInterfaceInfoSerializer =
    new _$NetworkInterfaceInfoSerializer();
Serializer<NetworkInterfaceStatus> _$networkInterfaceStatusSerializer =
    new _$NetworkInterfaceStatusSerializer();

class _$NetworkInfoSerializer implements StructuredSerializer<NetworkInfo> {
  @override
  final Iterable<Type> types = const [NetworkInfo, _$NetworkInfo];
  @override
  final String wireName = 'NetworkInfo';

  @override
  Iterable<Object?> serialize(Serializers serializers, NetworkInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'lastUpdate',
      serializers.serialize(object.lastUpdate,
          specifiedType: const FullType(int)),
      'hasInternet',
      serializers.serialize(object.hasInternet,
          specifiedType: const FullType(bool)),
    ];
    Object? value;
    value = object.interfaces;
    if (value != null) {
      result
        ..add('interfaces')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(NetworkInterfaceInfo)])));
    }
    return result;
  }

  @override
  NetworkInfo deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new NetworkInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'lastUpdate':
          result.lastUpdate = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'hasInternet':
          result.hasInternet = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'interfaces':
          result.interfaces.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(NetworkInterfaceInfo)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$NetworkInterfaceInfoSerializer
    implements StructuredSerializer<NetworkInterfaceInfo> {
  @override
  final Iterable<Type> types = const [
    NetworkInterfaceInfo,
    _$NetworkInterfaceInfo
  ];
  @override
  final String wireName = 'NetworkInterfaceInfo';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, NetworkInterfaceInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'status',
      serializers.serialize(object.status,
          specifiedType: const FullType(NetworkInterfaceStatus)),
    ];
    Object? value;
    value = object.ip4;
    if (value != null) {
      result
        ..add('ip4')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.ip6;
    if (value != null) {
      result
        ..add('ip6')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  NetworkInterfaceInfo deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new NetworkInterfaceInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
                  specifiedType: const FullType(NetworkInterfaceStatus))
              as NetworkInterfaceStatus;
          break;
        case 'ip4':
          result.ip4 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'ip6':
          result.ip6 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$NetworkInterfaceStatusSerializer
    implements PrimitiveSerializer<NetworkInterfaceStatus> {
  @override
  final Iterable<Type> types = const <Type>[NetworkInterfaceStatus];
  @override
  final String wireName = 'NetworkInterfaceStatus';

  @override
  Object serialize(Serializers serializers, NetworkInterfaceStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  NetworkInterfaceStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      NetworkInterfaceStatus.valueOf(serialized as String);
}

class _$NetworkInfo extends NetworkInfo {
  @override
  final int lastUpdate;
  @override
  final bool hasInternet;
  @override
  final BuiltList<NetworkInterfaceInfo>? interfaces;

  factory _$NetworkInfo([void Function(NetworkInfoBuilder)? updates]) =>
      (new NetworkInfoBuilder()..update(updates)).build();

  _$NetworkInfo._(
      {required this.lastUpdate, required this.hasInternet, this.interfaces})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        lastUpdate, 'NetworkInfo', 'lastUpdate');
    BuiltValueNullFieldError.checkNotNull(
        hasInternet, 'NetworkInfo', 'hasInternet');
  }

  @override
  NetworkInfo rebuild(void Function(NetworkInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NetworkInfoBuilder toBuilder() => new NetworkInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NetworkInfo &&
        lastUpdate == other.lastUpdate &&
        hasInternet == other.hasInternet &&
        interfaces == other.interfaces;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, lastUpdate.hashCode), hasInternet.hashCode),
        interfaces.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('NetworkInfo')
          ..add('lastUpdate', lastUpdate)
          ..add('hasInternet', hasInternet)
          ..add('interfaces', interfaces))
        .toString();
  }
}

class NetworkInfoBuilder implements Builder<NetworkInfo, NetworkInfoBuilder> {
  _$NetworkInfo? _$v;

  int? _lastUpdate;
  int? get lastUpdate => _$this._lastUpdate;
  set lastUpdate(int? lastUpdate) => _$this._lastUpdate = lastUpdate;

  bool? _hasInternet;
  bool? get hasInternet => _$this._hasInternet;
  set hasInternet(bool? hasInternet) => _$this._hasInternet = hasInternet;

  ListBuilder<NetworkInterfaceInfo>? _interfaces;
  ListBuilder<NetworkInterfaceInfo> get interfaces =>
      _$this._interfaces ??= new ListBuilder<NetworkInterfaceInfo>();
  set interfaces(ListBuilder<NetworkInterfaceInfo>? interfaces) =>
      _$this._interfaces = interfaces;

  NetworkInfoBuilder();

  NetworkInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _lastUpdate = $v.lastUpdate;
      _hasInternet = $v.hasInternet;
      _interfaces = $v.interfaces?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NetworkInfo other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$NetworkInfo;
  }

  @override
  void update(void Function(NetworkInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$NetworkInfo build() {
    _$NetworkInfo _$result;
    try {
      _$result = _$v ??
          new _$NetworkInfo._(
              lastUpdate: BuiltValueNullFieldError.checkNotNull(
                  lastUpdate, 'NetworkInfo', 'lastUpdate'),
              hasInternet: BuiltValueNullFieldError.checkNotNull(
                  hasInternet, 'NetworkInfo', 'hasInternet'),
              interfaces: _interfaces?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'interfaces';
        _interfaces?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'NetworkInfo', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$NetworkInterfaceInfo extends NetworkInterfaceInfo {
  @override
  final String name;
  @override
  final NetworkInterfaceStatus status;
  @override
  final String? ip4;
  @override
  final String? ip6;

  factory _$NetworkInterfaceInfo(
          [void Function(NetworkInterfaceInfoBuilder)? updates]) =>
      (new NetworkInterfaceInfoBuilder()..update(updates)).build();

  _$NetworkInterfaceInfo._(
      {required this.name, required this.status, this.ip4, this.ip6})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(name, 'NetworkInterfaceInfo', 'name');
    BuiltValueNullFieldError.checkNotNull(
        status, 'NetworkInterfaceInfo', 'status');
  }

  @override
  NetworkInterfaceInfo rebuild(
          void Function(NetworkInterfaceInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NetworkInterfaceInfoBuilder toBuilder() =>
      new NetworkInterfaceInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NetworkInterfaceInfo &&
        name == other.name &&
        status == other.status &&
        ip4 == other.ip4 &&
        ip6 == other.ip6;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, name.hashCode), status.hashCode), ip4.hashCode),
        ip6.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('NetworkInterfaceInfo')
          ..add('name', name)
          ..add('status', status)
          ..add('ip4', ip4)
          ..add('ip6', ip6))
        .toString();
  }
}

class NetworkInterfaceInfoBuilder
    implements Builder<NetworkInterfaceInfo, NetworkInterfaceInfoBuilder> {
  _$NetworkInterfaceInfo? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  NetworkInterfaceStatus? _status;
  NetworkInterfaceStatus? get status => _$this._status;
  set status(NetworkInterfaceStatus? status) => _$this._status = status;

  String? _ip4;
  String? get ip4 => _$this._ip4;
  set ip4(String? ip4) => _$this._ip4 = ip4;

  String? _ip6;
  String? get ip6 => _$this._ip6;
  set ip6(String? ip6) => _$this._ip6 = ip6;

  NetworkInterfaceInfoBuilder();

  NetworkInterfaceInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _status = $v.status;
      _ip4 = $v.ip4;
      _ip6 = $v.ip6;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NetworkInterfaceInfo other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$NetworkInterfaceInfo;
  }

  @override
  void update(void Function(NetworkInterfaceInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$NetworkInterfaceInfo build() {
    final _$result = _$v ??
        new _$NetworkInterfaceInfo._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, 'NetworkInterfaceInfo', 'name'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, 'NetworkInterfaceInfo', 'status'),
            ip4: ip4,
            ip6: ip6);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
