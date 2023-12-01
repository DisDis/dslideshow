// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sensor_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SensorInfo _$SensorInfoFromJson(Map<String, dynamic> json) {
  return _SensorInfo.fromJson(json);
}

/// @nodoc
mixin _$SensorInfo {
  String get name => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SensorInfoCopyWith<SensorInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SensorInfoCopyWith<$Res> {
  factory $SensorInfoCopyWith(
          SensorInfo value, $Res Function(SensorInfo) then) =
      _$SensorInfoCopyWithImpl<$Res, SensorInfo>;
  @useResult
  $Res call({String name, String value});
}

/// @nodoc
class _$SensorInfoCopyWithImpl<$Res, $Val extends SensorInfo>
    implements $SensorInfoCopyWith<$Res> {
  _$SensorInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SensorInfoImplCopyWith<$Res>
    implements $SensorInfoCopyWith<$Res> {
  factory _$$SensorInfoImplCopyWith(
          _$SensorInfoImpl value, $Res Function(_$SensorInfoImpl) then) =
      __$$SensorInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String value});
}

/// @nodoc
class __$$SensorInfoImplCopyWithImpl<$Res>
    extends _$SensorInfoCopyWithImpl<$Res, _$SensorInfoImpl>
    implements _$$SensorInfoImplCopyWith<$Res> {
  __$$SensorInfoImplCopyWithImpl(
      _$SensorInfoImpl _value, $Res Function(_$SensorInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? value = null,
  }) {
    return _then(_$SensorInfoImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SensorInfoImpl implements _SensorInfo {
  const _$SensorInfoImpl({required this.name, required this.value});

  factory _$SensorInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SensorInfoImplFromJson(json);

  @override
  final String name;
  @override
  final String value;

  @override
  String toString() {
    return 'SensorInfo(name: $name, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SensorInfoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SensorInfoImplCopyWith<_$SensorInfoImpl> get copyWith =>
      __$$SensorInfoImplCopyWithImpl<_$SensorInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SensorInfoImplToJson(
      this,
    );
  }
}

abstract class _SensorInfo implements SensorInfo {
  const factory _SensorInfo(
      {required final String name,
      required final String value}) = _$SensorInfoImpl;

  factory _SensorInfo.fromJson(Map<String, dynamic> json) =
      _$SensorInfoImpl.fromJson;

  @override
  String get name;
  @override
  String get value;
  @override
  @JsonKey(ignore: true)
  _$$SensorInfoImplCopyWith<_$SensorInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
