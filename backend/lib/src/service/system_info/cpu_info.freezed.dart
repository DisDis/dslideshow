// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cpu_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CpuInfo _$CpuInfoFromJson(Map<String, dynamic> json) {
  return _CpuInfo.fromJson(json);
}

/// @nodoc
mixin _$CpuInfo {
  int get cores => throw _privateConstructorUsedError;
  String get hardware => throw _privateConstructorUsedError;
  String get model => throw _privateConstructorUsedError;
  String get revision => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CpuInfoCopyWith<CpuInfo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CpuInfoCopyWith<$Res> {
  factory $CpuInfoCopyWith(CpuInfo value, $Res Function(CpuInfo) then) =
      _$CpuInfoCopyWithImpl<$Res, CpuInfo>;
  @useResult
  $Res call({int cores, String hardware, String model, String revision});
}

/// @nodoc
class _$CpuInfoCopyWithImpl<$Res, $Val extends CpuInfo>
    implements $CpuInfoCopyWith<$Res> {
  _$CpuInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cores = null,
    Object? hardware = null,
    Object? model = null,
    Object? revision = null,
  }) {
    return _then(_value.copyWith(
      cores: null == cores
          ? _value.cores
          : cores // ignore: cast_nullable_to_non_nullable
              as int,
      hardware: null == hardware
          ? _value.hardware
          : hardware // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      revision: null == revision
          ? _value.revision
          : revision // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CpuInfoImplCopyWith<$Res> implements $CpuInfoCopyWith<$Res> {
  factory _$$CpuInfoImplCopyWith(
          _$CpuInfoImpl value, $Res Function(_$CpuInfoImpl) then) =
      __$$CpuInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int cores, String hardware, String model, String revision});
}

/// @nodoc
class __$$CpuInfoImplCopyWithImpl<$Res>
    extends _$CpuInfoCopyWithImpl<$Res, _$CpuInfoImpl>
    implements _$$CpuInfoImplCopyWith<$Res> {
  __$$CpuInfoImplCopyWithImpl(
      _$CpuInfoImpl _value, $Res Function(_$CpuInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cores = null,
    Object? hardware = null,
    Object? model = null,
    Object? revision = null,
  }) {
    return _then(_$CpuInfoImpl(
      cores: null == cores
          ? _value.cores
          : cores // ignore: cast_nullable_to_non_nullable
              as int,
      hardware: null == hardware
          ? _value.hardware
          : hardware // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      revision: null == revision
          ? _value.revision
          : revision // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CpuInfoImpl implements _CpuInfo {
  const _$CpuInfoImpl(
      {required this.cores,
      required this.hardware,
      required this.model,
      required this.revision});

  factory _$CpuInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CpuInfoImplFromJson(json);

  @override
  final int cores;
  @override
  final String hardware;
  @override
  final String model;
  @override
  final String revision;

  @override
  String toString() {
    return 'CpuInfo(cores: $cores, hardware: $hardware, model: $model, revision: $revision)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CpuInfoImpl &&
            (identical(other.cores, cores) || other.cores == cores) &&
            (identical(other.hardware, hardware) ||
                other.hardware == hardware) &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.revision, revision) ||
                other.revision == revision));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, cores, hardware, model, revision);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CpuInfoImplCopyWith<_$CpuInfoImpl> get copyWith =>
      __$$CpuInfoImplCopyWithImpl<_$CpuInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CpuInfoImplToJson(
      this,
    );
  }
}

abstract class _CpuInfo implements CpuInfo {
  const factory _CpuInfo(
      {required final int cores,
      required final String hardware,
      required final String model,
      required final String revision}) = _$CpuInfoImpl;

  factory _CpuInfo.fromJson(Map<String, dynamic> json) = _$CpuInfoImpl.fromJson;

  @override
  int get cores;
  @override
  String get hardware;
  @override
  String get model;
  @override
  String get revision;
  @override
  @JsonKey(ignore: true)
  _$$CpuInfoImplCopyWith<_$CpuInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
