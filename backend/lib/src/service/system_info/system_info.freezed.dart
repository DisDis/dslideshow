// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'system_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SystemInfo {
  CpuInfo get cpuInfo;
  NetworkInfo get networkInfo;
  OSInfo get osInfo;
  UpdateInfo get updateInfo;

  /// Create a copy of SystemInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SystemInfoCopyWith<SystemInfo> get copyWith =>
      _$SystemInfoCopyWithImpl<SystemInfo>(this as SystemInfo, _$identity);

  /// Serializes this SystemInfo to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SystemInfo &&
            (identical(other.cpuInfo, cpuInfo) || other.cpuInfo == cpuInfo) &&
            (identical(other.networkInfo, networkInfo) ||
                other.networkInfo == networkInfo) &&
            (identical(other.osInfo, osInfo) || other.osInfo == osInfo) &&
            (identical(other.updateInfo, updateInfo) ||
                other.updateInfo == updateInfo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, cpuInfo, networkInfo, osInfo, updateInfo);

  @override
  String toString() {
    return 'SystemInfo(cpuInfo: $cpuInfo, networkInfo: $networkInfo, osInfo: $osInfo, updateInfo: $updateInfo)';
  }
}

/// @nodoc
abstract mixin class $SystemInfoCopyWith<$Res> {
  factory $SystemInfoCopyWith(
          SystemInfo value, $Res Function(SystemInfo) _then) =
      _$SystemInfoCopyWithImpl;
  @useResult
  $Res call(
      {CpuInfo cpuInfo,
      NetworkInfo networkInfo,
      OSInfo osInfo,
      UpdateInfo updateInfo});

  $CpuInfoCopyWith<$Res> get cpuInfo;
  $NetworkInfoCopyWith<$Res> get networkInfo;
  $OSInfoCopyWith<$Res> get osInfo;
  $UpdateInfoCopyWith<$Res> get updateInfo;
}

/// @nodoc
class _$SystemInfoCopyWithImpl<$Res> implements $SystemInfoCopyWith<$Res> {
  _$SystemInfoCopyWithImpl(this._self, this._then);

  final SystemInfo _self;
  final $Res Function(SystemInfo) _then;

  /// Create a copy of SystemInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cpuInfo = null,
    Object? networkInfo = null,
    Object? osInfo = null,
    Object? updateInfo = null,
  }) {
    return _then(_self.copyWith(
      cpuInfo: null == cpuInfo
          ? _self.cpuInfo
          : cpuInfo // ignore: cast_nullable_to_non_nullable
              as CpuInfo,
      networkInfo: null == networkInfo
          ? _self.networkInfo
          : networkInfo // ignore: cast_nullable_to_non_nullable
              as NetworkInfo,
      osInfo: null == osInfo
          ? _self.osInfo
          : osInfo // ignore: cast_nullable_to_non_nullable
              as OSInfo,
      updateInfo: null == updateInfo
          ? _self.updateInfo
          : updateInfo // ignore: cast_nullable_to_non_nullable
              as UpdateInfo,
    ));
  }

  /// Create a copy of SystemInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CpuInfoCopyWith<$Res> get cpuInfo {
    return $CpuInfoCopyWith<$Res>(_self.cpuInfo, (value) {
      return _then(_self.copyWith(cpuInfo: value));
    });
  }

  /// Create a copy of SystemInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NetworkInfoCopyWith<$Res> get networkInfo {
    return $NetworkInfoCopyWith<$Res>(_self.networkInfo, (value) {
      return _then(_self.copyWith(networkInfo: value));
    });
  }

  /// Create a copy of SystemInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OSInfoCopyWith<$Res> get osInfo {
    return $OSInfoCopyWith<$Res>(_self.osInfo, (value) {
      return _then(_self.copyWith(osInfo: value));
    });
  }

  /// Create a copy of SystemInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UpdateInfoCopyWith<$Res> get updateInfo {
    return $UpdateInfoCopyWith<$Res>(_self.updateInfo, (value) {
      return _then(_self.copyWith(updateInfo: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _SystemInfo implements SystemInfo {
  const _SystemInfo(
      {required this.cpuInfo,
      required this.networkInfo,
      required this.osInfo,
      required this.updateInfo});
  factory _SystemInfo.fromJson(Map<String, dynamic> json) =>
      _$SystemInfoFromJson(json);

  @override
  final CpuInfo cpuInfo;
  @override
  final NetworkInfo networkInfo;
  @override
  final OSInfo osInfo;
  @override
  final UpdateInfo updateInfo;

  /// Create a copy of SystemInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SystemInfoCopyWith<_SystemInfo> get copyWith =>
      __$SystemInfoCopyWithImpl<_SystemInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SystemInfoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SystemInfo &&
            (identical(other.cpuInfo, cpuInfo) || other.cpuInfo == cpuInfo) &&
            (identical(other.networkInfo, networkInfo) ||
                other.networkInfo == networkInfo) &&
            (identical(other.osInfo, osInfo) || other.osInfo == osInfo) &&
            (identical(other.updateInfo, updateInfo) ||
                other.updateInfo == updateInfo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, cpuInfo, networkInfo, osInfo, updateInfo);

  @override
  String toString() {
    return 'SystemInfo(cpuInfo: $cpuInfo, networkInfo: $networkInfo, osInfo: $osInfo, updateInfo: $updateInfo)';
  }
}

/// @nodoc
abstract mixin class _$SystemInfoCopyWith<$Res>
    implements $SystemInfoCopyWith<$Res> {
  factory _$SystemInfoCopyWith(
          _SystemInfo value, $Res Function(_SystemInfo) _then) =
      __$SystemInfoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {CpuInfo cpuInfo,
      NetworkInfo networkInfo,
      OSInfo osInfo,
      UpdateInfo updateInfo});

  @override
  $CpuInfoCopyWith<$Res> get cpuInfo;
  @override
  $NetworkInfoCopyWith<$Res> get networkInfo;
  @override
  $OSInfoCopyWith<$Res> get osInfo;
  @override
  $UpdateInfoCopyWith<$Res> get updateInfo;
}

/// @nodoc
class __$SystemInfoCopyWithImpl<$Res> implements _$SystemInfoCopyWith<$Res> {
  __$SystemInfoCopyWithImpl(this._self, this._then);

  final _SystemInfo _self;
  final $Res Function(_SystemInfo) _then;

  /// Create a copy of SystemInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? cpuInfo = null,
    Object? networkInfo = null,
    Object? osInfo = null,
    Object? updateInfo = null,
  }) {
    return _then(_SystemInfo(
      cpuInfo: null == cpuInfo
          ? _self.cpuInfo
          : cpuInfo // ignore: cast_nullable_to_non_nullable
              as CpuInfo,
      networkInfo: null == networkInfo
          ? _self.networkInfo
          : networkInfo // ignore: cast_nullable_to_non_nullable
              as NetworkInfo,
      osInfo: null == osInfo
          ? _self.osInfo
          : osInfo // ignore: cast_nullable_to_non_nullable
              as OSInfo,
      updateInfo: null == updateInfo
          ? _self.updateInfo
          : updateInfo // ignore: cast_nullable_to_non_nullable
              as UpdateInfo,
    ));
  }

  /// Create a copy of SystemInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CpuInfoCopyWith<$Res> get cpuInfo {
    return $CpuInfoCopyWith<$Res>(_self.cpuInfo, (value) {
      return _then(_self.copyWith(cpuInfo: value));
    });
  }

  /// Create a copy of SystemInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NetworkInfoCopyWith<$Res> get networkInfo {
    return $NetworkInfoCopyWith<$Res>(_self.networkInfo, (value) {
      return _then(_self.copyWith(networkInfo: value));
    });
  }

  /// Create a copy of SystemInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OSInfoCopyWith<$Res> get osInfo {
    return $OSInfoCopyWith<$Res>(_self.osInfo, (value) {
      return _then(_self.copyWith(osInfo: value));
    });
  }

  /// Create a copy of SystemInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UpdateInfoCopyWith<$Res> get updateInfo {
    return $UpdateInfoCopyWith<$Res>(_self.updateInfo, (value) {
      return _then(_self.copyWith(updateInfo: value));
    });
  }
}

// dart format on
