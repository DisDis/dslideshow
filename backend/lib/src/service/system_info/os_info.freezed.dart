// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'os_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OSInfo _$OSInfoFromJson(Map<String, dynamic> json) {
  return _OSInfo.fromJson(json);
}

/// @nodoc
mixin _$OSInfo {
  String get name => throw _privateConstructorUsedError;
  OSType get osType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OSInfoCopyWith<OSInfo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OSInfoCopyWith<$Res> {
  factory $OSInfoCopyWith(OSInfo value, $Res Function(OSInfo) then) =
      _$OSInfoCopyWithImpl<$Res, OSInfo>;
  @useResult
  $Res call({String name, OSType osType});
}

/// @nodoc
class _$OSInfoCopyWithImpl<$Res, $Val extends OSInfo>
    implements $OSInfoCopyWith<$Res> {
  _$OSInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? osType = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      osType: null == osType
          ? _value.osType
          : osType // ignore: cast_nullable_to_non_nullable
              as OSType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OSInfoImplCopyWith<$Res> implements $OSInfoCopyWith<$Res> {
  factory _$$OSInfoImplCopyWith(
          _$OSInfoImpl value, $Res Function(_$OSInfoImpl) then) =
      __$$OSInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, OSType osType});
}

/// @nodoc
class __$$OSInfoImplCopyWithImpl<$Res>
    extends _$OSInfoCopyWithImpl<$Res, _$OSInfoImpl>
    implements _$$OSInfoImplCopyWith<$Res> {
  __$$OSInfoImplCopyWithImpl(
      _$OSInfoImpl _value, $Res Function(_$OSInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? osType = null,
  }) {
    return _then(_$OSInfoImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      osType: null == osType
          ? _value.osType
          : osType // ignore: cast_nullable_to_non_nullable
              as OSType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OSInfoImpl implements _OSInfo {
  const _$OSInfoImpl({required this.name, required this.osType});

  factory _$OSInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$OSInfoImplFromJson(json);

  @override
  final String name;
  @override
  final OSType osType;

  @override
  String toString() {
    return 'OSInfo(name: $name, osType: $osType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OSInfoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.osType, osType) || other.osType == osType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, osType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OSInfoImplCopyWith<_$OSInfoImpl> get copyWith =>
      __$$OSInfoImplCopyWithImpl<_$OSInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OSInfoImplToJson(
      this,
    );
  }
}

abstract class _OSInfo implements OSInfo {
  const factory _OSInfo(
      {required final String name,
      required final OSType osType}) = _$OSInfoImpl;

  factory _OSInfo.fromJson(Map<String, dynamic> json) = _$OSInfoImpl.fromJson;

  @override
  String get name;
  @override
  OSType get osType;
  @override
  @JsonKey(ignore: true)
  _$$OSInfoImplCopyWith<_$OSInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
