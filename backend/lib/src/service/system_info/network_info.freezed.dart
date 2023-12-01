// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NetworkInfo _$NetworkInfoFromJson(Map<String, dynamic> json) {
  return _NetworkInfo.fromJson(json);
}

/// @nodoc
mixin _$NetworkInfo {
  int get lastUpdate => throw _privateConstructorUsedError;
  bool get hasInternet => throw _privateConstructorUsedError;
  List<NetworkInterfaceInfo>? get interfaces =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NetworkInfoCopyWith<NetworkInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NetworkInfoCopyWith<$Res> {
  factory $NetworkInfoCopyWith(
          NetworkInfo value, $Res Function(NetworkInfo) then) =
      _$NetworkInfoCopyWithImpl<$Res, NetworkInfo>;
  @useResult
  $Res call(
      {int lastUpdate,
      bool hasInternet,
      List<NetworkInterfaceInfo>? interfaces});
}

/// @nodoc
class _$NetworkInfoCopyWithImpl<$Res, $Val extends NetworkInfo>
    implements $NetworkInfoCopyWith<$Res> {
  _$NetworkInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastUpdate = null,
    Object? hasInternet = null,
    Object? interfaces = freezed,
  }) {
    return _then(_value.copyWith(
      lastUpdate: null == lastUpdate
          ? _value.lastUpdate
          : lastUpdate // ignore: cast_nullable_to_non_nullable
              as int,
      hasInternet: null == hasInternet
          ? _value.hasInternet
          : hasInternet // ignore: cast_nullable_to_non_nullable
              as bool,
      interfaces: freezed == interfaces
          ? _value.interfaces
          : interfaces // ignore: cast_nullable_to_non_nullable
              as List<NetworkInterfaceInfo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NetworkInfoImplCopyWith<$Res>
    implements $NetworkInfoCopyWith<$Res> {
  factory _$$NetworkInfoImplCopyWith(
          _$NetworkInfoImpl value, $Res Function(_$NetworkInfoImpl) then) =
      __$$NetworkInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int lastUpdate,
      bool hasInternet,
      List<NetworkInterfaceInfo>? interfaces});
}

/// @nodoc
class __$$NetworkInfoImplCopyWithImpl<$Res>
    extends _$NetworkInfoCopyWithImpl<$Res, _$NetworkInfoImpl>
    implements _$$NetworkInfoImplCopyWith<$Res> {
  __$$NetworkInfoImplCopyWithImpl(
      _$NetworkInfoImpl _value, $Res Function(_$NetworkInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastUpdate = null,
    Object? hasInternet = null,
    Object? interfaces = freezed,
  }) {
    return _then(_$NetworkInfoImpl(
      lastUpdate: null == lastUpdate
          ? _value.lastUpdate
          : lastUpdate // ignore: cast_nullable_to_non_nullable
              as int,
      hasInternet: null == hasInternet
          ? _value.hasInternet
          : hasInternet // ignore: cast_nullable_to_non_nullable
              as bool,
      interfaces: freezed == interfaces
          ? _value._interfaces
          : interfaces // ignore: cast_nullable_to_non_nullable
              as List<NetworkInterfaceInfo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NetworkInfoImpl implements _NetworkInfo {
  const _$NetworkInfoImpl(
      {required this.lastUpdate,
      required this.hasInternet,
      required final List<NetworkInterfaceInfo>? interfaces})
      : _interfaces = interfaces;

  factory _$NetworkInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$NetworkInfoImplFromJson(json);

  @override
  final int lastUpdate;
  @override
  final bool hasInternet;
  final List<NetworkInterfaceInfo>? _interfaces;
  @override
  List<NetworkInterfaceInfo>? get interfaces {
    final value = _interfaces;
    if (value == null) return null;
    if (_interfaces is EqualUnmodifiableListView) return _interfaces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'NetworkInfo(lastUpdate: $lastUpdate, hasInternet: $hasInternet, interfaces: $interfaces)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkInfoImpl &&
            (identical(other.lastUpdate, lastUpdate) ||
                other.lastUpdate == lastUpdate) &&
            (identical(other.hasInternet, hasInternet) ||
                other.hasInternet == hasInternet) &&
            const DeepCollectionEquality()
                .equals(other._interfaces, _interfaces));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, lastUpdate, hasInternet,
      const DeepCollectionEquality().hash(_interfaces));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkInfoImplCopyWith<_$NetworkInfoImpl> get copyWith =>
      __$$NetworkInfoImplCopyWithImpl<_$NetworkInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NetworkInfoImplToJson(
      this,
    );
  }
}

abstract class _NetworkInfo implements NetworkInfo {
  const factory _NetworkInfo(
          {required final int lastUpdate,
          required final bool hasInternet,
          required final List<NetworkInterfaceInfo>? interfaces}) =
      _$NetworkInfoImpl;

  factory _NetworkInfo.fromJson(Map<String, dynamic> json) =
      _$NetworkInfoImpl.fromJson;

  @override
  int get lastUpdate;
  @override
  bool get hasInternet;
  @override
  List<NetworkInterfaceInfo>? get interfaces;
  @override
  @JsonKey(ignore: true)
  _$$NetworkInfoImplCopyWith<_$NetworkInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NetworkInterfaceInfo _$NetworkInterfaceInfoFromJson(Map<String, dynamic> json) {
  return _NetworkInterfaceInfo.fromJson(json);
}

/// @nodoc
mixin _$NetworkInterfaceInfo {
  String get name => throw _privateConstructorUsedError;
  NetworkInterfaceStatus get status => throw _privateConstructorUsedError;
  String get ip4 => throw _privateConstructorUsedError;
  String get ip6 => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NetworkInterfaceInfoCopyWith<NetworkInterfaceInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NetworkInterfaceInfoCopyWith<$Res> {
  factory $NetworkInterfaceInfoCopyWith(NetworkInterfaceInfo value,
          $Res Function(NetworkInterfaceInfo) then) =
      _$NetworkInterfaceInfoCopyWithImpl<$Res, NetworkInterfaceInfo>;
  @useResult
  $Res call(
      {String name, NetworkInterfaceStatus status, String ip4, String ip6});
}

/// @nodoc
class _$NetworkInterfaceInfoCopyWithImpl<$Res,
        $Val extends NetworkInterfaceInfo>
    implements $NetworkInterfaceInfoCopyWith<$Res> {
  _$NetworkInterfaceInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? status = null,
    Object? ip4 = null,
    Object? ip6 = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as NetworkInterfaceStatus,
      ip4: null == ip4
          ? _value.ip4
          : ip4 // ignore: cast_nullable_to_non_nullable
              as String,
      ip6: null == ip6
          ? _value.ip6
          : ip6 // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NetworkInterfaceInfoImplCopyWith<$Res>
    implements $NetworkInterfaceInfoCopyWith<$Res> {
  factory _$$NetworkInterfaceInfoImplCopyWith(_$NetworkInterfaceInfoImpl value,
          $Res Function(_$NetworkInterfaceInfoImpl) then) =
      __$$NetworkInterfaceInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name, NetworkInterfaceStatus status, String ip4, String ip6});
}

/// @nodoc
class __$$NetworkInterfaceInfoImplCopyWithImpl<$Res>
    extends _$NetworkInterfaceInfoCopyWithImpl<$Res, _$NetworkInterfaceInfoImpl>
    implements _$$NetworkInterfaceInfoImplCopyWith<$Res> {
  __$$NetworkInterfaceInfoImplCopyWithImpl(_$NetworkInterfaceInfoImpl _value,
      $Res Function(_$NetworkInterfaceInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? status = null,
    Object? ip4 = null,
    Object? ip6 = null,
  }) {
    return _then(_$NetworkInterfaceInfoImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as NetworkInterfaceStatus,
      ip4: null == ip4
          ? _value.ip4
          : ip4 // ignore: cast_nullable_to_non_nullable
              as String,
      ip6: null == ip6
          ? _value.ip6
          : ip6 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NetworkInterfaceInfoImpl implements _NetworkInterfaceInfo {
  const _$NetworkInterfaceInfoImpl(
      {required this.name,
      required this.status,
      required this.ip4,
      required this.ip6});

  factory _$NetworkInterfaceInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$NetworkInterfaceInfoImplFromJson(json);

  @override
  final String name;
  @override
  final NetworkInterfaceStatus status;
  @override
  final String ip4;
  @override
  final String ip6;

  @override
  String toString() {
    return 'NetworkInterfaceInfo(name: $name, status: $status, ip4: $ip4, ip6: $ip6)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkInterfaceInfoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.ip4, ip4) || other.ip4 == ip4) &&
            (identical(other.ip6, ip6) || other.ip6 == ip6));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, status, ip4, ip6);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkInterfaceInfoImplCopyWith<_$NetworkInterfaceInfoImpl>
      get copyWith =>
          __$$NetworkInterfaceInfoImplCopyWithImpl<_$NetworkInterfaceInfoImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NetworkInterfaceInfoImplToJson(
      this,
    );
  }
}

abstract class _NetworkInterfaceInfo implements NetworkInterfaceInfo {
  const factory _NetworkInterfaceInfo(
      {required final String name,
      required final NetworkInterfaceStatus status,
      required final String ip4,
      required final String ip6}) = _$NetworkInterfaceInfoImpl;

  factory _NetworkInterfaceInfo.fromJson(Map<String, dynamic> json) =
      _$NetworkInterfaceInfoImpl.fromJson;

  @override
  String get name;
  @override
  NetworkInterfaceStatus get status;
  @override
  String get ip4;
  @override
  String get ip6;
  @override
  @JsonKey(ignore: true)
  _$$NetworkInterfaceInfoImplCopyWith<_$NetworkInterfaceInfoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
