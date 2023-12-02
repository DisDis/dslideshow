// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'system_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SystemInfo _$SystemInfoFromJson(Map<String, dynamic> json) {
  return _SystemInfo.fromJson(json);
}

/// @nodoc
mixin _$SystemInfo {
  CpuInfo get cpuInfo => throw _privateConstructorUsedError;
  NetworkInfo get networkInfo => throw _privateConstructorUsedError;
  OSInfo get osInfo => throw _privateConstructorUsedError;
  UpdateInfo get updateInfo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SystemInfoCopyWith<SystemInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SystemInfoCopyWith<$Res> {
  factory $SystemInfoCopyWith(
          SystemInfo value, $Res Function(SystemInfo) then) =
      _$SystemInfoCopyWithImpl<$Res, SystemInfo>;
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
class _$SystemInfoCopyWithImpl<$Res, $Val extends SystemInfo>
    implements $SystemInfoCopyWith<$Res> {
  _$SystemInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cpuInfo = null,
    Object? networkInfo = null,
    Object? osInfo = null,
    Object? updateInfo = null,
  }) {
    return _then(_value.copyWith(
      cpuInfo: null == cpuInfo
          ? _value.cpuInfo
          : cpuInfo // ignore: cast_nullable_to_non_nullable
              as CpuInfo,
      networkInfo: null == networkInfo
          ? _value.networkInfo
          : networkInfo // ignore: cast_nullable_to_non_nullable
              as NetworkInfo,
      osInfo: null == osInfo
          ? _value.osInfo
          : osInfo // ignore: cast_nullable_to_non_nullable
              as OSInfo,
      updateInfo: null == updateInfo
          ? _value.updateInfo
          : updateInfo // ignore: cast_nullable_to_non_nullable
              as UpdateInfo,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CpuInfoCopyWith<$Res> get cpuInfo {
    return $CpuInfoCopyWith<$Res>(_value.cpuInfo, (value) {
      return _then(_value.copyWith(cpuInfo: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $NetworkInfoCopyWith<$Res> get networkInfo {
    return $NetworkInfoCopyWith<$Res>(_value.networkInfo, (value) {
      return _then(_value.copyWith(networkInfo: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $OSInfoCopyWith<$Res> get osInfo {
    return $OSInfoCopyWith<$Res>(_value.osInfo, (value) {
      return _then(_value.copyWith(osInfo: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UpdateInfoCopyWith<$Res> get updateInfo {
    return $UpdateInfoCopyWith<$Res>(_value.updateInfo, (value) {
      return _then(_value.copyWith(updateInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SystemInfoImplCopyWith<$Res>
    implements $SystemInfoCopyWith<$Res> {
  factory _$$SystemInfoImplCopyWith(
          _$SystemInfoImpl value, $Res Function(_$SystemInfoImpl) then) =
      __$$SystemInfoImplCopyWithImpl<$Res>;
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
class __$$SystemInfoImplCopyWithImpl<$Res>
    extends _$SystemInfoCopyWithImpl<$Res, _$SystemInfoImpl>
    implements _$$SystemInfoImplCopyWith<$Res> {
  __$$SystemInfoImplCopyWithImpl(
      _$SystemInfoImpl _value, $Res Function(_$SystemInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cpuInfo = null,
    Object? networkInfo = null,
    Object? osInfo = null,
    Object? updateInfo = null,
  }) {
    return _then(_$SystemInfoImpl(
      cpuInfo: null == cpuInfo
          ? _value.cpuInfo
          : cpuInfo // ignore: cast_nullable_to_non_nullable
              as CpuInfo,
      networkInfo: null == networkInfo
          ? _value.networkInfo
          : networkInfo // ignore: cast_nullable_to_non_nullable
              as NetworkInfo,
      osInfo: null == osInfo
          ? _value.osInfo
          : osInfo // ignore: cast_nullable_to_non_nullable
              as OSInfo,
      updateInfo: null == updateInfo
          ? _value.updateInfo
          : updateInfo // ignore: cast_nullable_to_non_nullable
              as UpdateInfo,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SystemInfoImpl implements _SystemInfo {
  const _$SystemInfoImpl(
      {required this.cpuInfo,
      required this.networkInfo,
      required this.osInfo,
      required this.updateInfo});

  factory _$SystemInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SystemInfoImplFromJson(json);

  @override
  final CpuInfo cpuInfo;
  @override
  final NetworkInfo networkInfo;
  @override
  final OSInfo osInfo;
  @override
  final UpdateInfo updateInfo;

  @override
  String toString() {
    return 'SystemInfo(cpuInfo: $cpuInfo, networkInfo: $networkInfo, osInfo: $osInfo, updateInfo: $updateInfo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SystemInfoImpl &&
            (identical(other.cpuInfo, cpuInfo) || other.cpuInfo == cpuInfo) &&
            (identical(other.networkInfo, networkInfo) ||
                other.networkInfo == networkInfo) &&
            (identical(other.osInfo, osInfo) || other.osInfo == osInfo) &&
            (identical(other.updateInfo, updateInfo) ||
                other.updateInfo == updateInfo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, cpuInfo, networkInfo, osInfo, updateInfo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SystemInfoImplCopyWith<_$SystemInfoImpl> get copyWith =>
      __$$SystemInfoImplCopyWithImpl<_$SystemInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SystemInfoImplToJson(
      this,
    );
  }
}

abstract class _SystemInfo implements SystemInfo {
  const factory _SystemInfo(
      {required final CpuInfo cpuInfo,
      required final NetworkInfo networkInfo,
      required final OSInfo osInfo,
      required final UpdateInfo updateInfo}) = _$SystemInfoImpl;

  factory _SystemInfo.fromJson(Map<String, dynamic> json) =
      _$SystemInfoImpl.fromJson;

  @override
  CpuInfo get cpuInfo;
  @override
  NetworkInfo get networkInfo;
  @override
  OSInfo get osInfo;
  @override
  UpdateInfo get updateInfo;
  @override
  @JsonKey(ignore: true)
  _$$SystemInfoImplCopyWith<_$SystemInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
