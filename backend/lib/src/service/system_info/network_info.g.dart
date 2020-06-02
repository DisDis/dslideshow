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

Serializer<NetworkInterfaceInfo> _$networkInterfaceInfoSerializer =
    new _$NetworkInterfaceInfoSerializer();
Serializer<NetworkInterfaceStatus> _$networkInterfaceStatusSerializer =
    new _$NetworkInterfaceStatusSerializer();

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
  Iterable<Object> serialize(
      Serializers serializers, NetworkInterfaceInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'status',
      serializers.serialize(object.status,
          specifiedType: const FullType(NetworkInterfaceStatus)),
    ];
    if (object.ip4 != null) {
      result
        ..add('ip4')
        ..add(serializers.serialize(object.ip4,
            specifiedType: const FullType(String)));
    }
    if (object.ip6 != null) {
      result
        ..add('ip6')
        ..add(serializers.serialize(object.ip6,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  NetworkInterfaceInfo deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new NetworkInterfaceInfoBuilder();

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
        case 'status':
          result.status = serializers.deserialize(value,
                  specifiedType: const FullType(NetworkInterfaceStatus))
              as NetworkInterfaceStatus;
          break;
        case 'ip4':
          result.ip4 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'ip6':
          result.ip6 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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

class _$NetworkInterfaceInfo extends NetworkInterfaceInfo {
  @override
  final String name;
  @override
  final NetworkInterfaceStatus status;
  @override
  final String ip4;
  @override
  final String ip6;

  factory _$NetworkInterfaceInfo(
          [void Function(NetworkInterfaceInfoBuilder) updates]) =>
      (new NetworkInterfaceInfoBuilder()..update(updates)).build();

  _$NetworkInterfaceInfo._({this.name, this.status, this.ip4, this.ip6})
      : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('NetworkInterfaceInfo', 'name');
    }
    if (status == null) {
      throw new BuiltValueNullFieldError('NetworkInterfaceInfo', 'status');
    }
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
  _$NetworkInterfaceInfo _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  NetworkInterfaceStatus _status;
  NetworkInterfaceStatus get status => _$this._status;
  set status(NetworkInterfaceStatus status) => _$this._status = status;

  String _ip4;
  String get ip4 => _$this._ip4;
  set ip4(String ip4) => _$this._ip4 = ip4;

  String _ip6;
  String get ip6 => _$this._ip6;
  set ip6(String ip6) => _$this._ip6 = ip6;

  NetworkInterfaceInfoBuilder();

  NetworkInterfaceInfoBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _status = _$v.status;
      _ip4 = _$v.ip4;
      _ip6 = _$v.ip6;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NetworkInterfaceInfo other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$NetworkInterfaceInfo;
  }

  @override
  void update(void Function(NetworkInterfaceInfoBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$NetworkInterfaceInfo build() {
    final _$result = _$v ??
        new _$NetworkInterfaceInfo._(
            name: name, status: status, ip4: ip4, ip6: ip6);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
