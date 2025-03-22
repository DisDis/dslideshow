// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sensor_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SensorInfo {
  String get name;
  String get value;

  /// Create a copy of SensorInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SensorInfoCopyWith<SensorInfo> get copyWith =>
      _$SensorInfoCopyWithImpl<SensorInfo>(this as SensorInfo, _$identity);

  /// Serializes this SensorInfo to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SensorInfo &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, value);

  @override
  String toString() {
    return 'SensorInfo(name: $name, value: $value)';
  }
}

/// @nodoc
abstract mixin class $SensorInfoCopyWith<$Res> {
  factory $SensorInfoCopyWith(
          SensorInfo value, $Res Function(SensorInfo) _then) =
      _$SensorInfoCopyWithImpl;
  @useResult
  $Res call({String name, String value});
}

/// @nodoc
class _$SensorInfoCopyWithImpl<$Res> implements $SensorInfoCopyWith<$Res> {
  _$SensorInfoCopyWithImpl(this._self, this._then);

  final SensorInfo _self;
  final $Res Function(SensorInfo) _then;

  /// Create a copy of SensorInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? value = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _SensorInfo implements SensorInfo {
  const _SensorInfo({required this.name, required this.value});
  factory _SensorInfo.fromJson(Map<String, dynamic> json) =>
      _$SensorInfoFromJson(json);

  @override
  final String name;
  @override
  final String value;

  /// Create a copy of SensorInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SensorInfoCopyWith<_SensorInfo> get copyWith =>
      __$SensorInfoCopyWithImpl<_SensorInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SensorInfoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SensorInfo &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, value);

  @override
  String toString() {
    return 'SensorInfo(name: $name, value: $value)';
  }
}

/// @nodoc
abstract mixin class _$SensorInfoCopyWith<$Res>
    implements $SensorInfoCopyWith<$Res> {
  factory _$SensorInfoCopyWith(
          _SensorInfo value, $Res Function(_SensorInfo) _then) =
      __$SensorInfoCopyWithImpl;
  @override
  @useResult
  $Res call({String name, String value});
}

/// @nodoc
class __$SensorInfoCopyWithImpl<$Res> implements _$SensorInfoCopyWith<$Res> {
  __$SensorInfoCopyWithImpl(this._self, this._then);

  final _SensorInfo _self;
  final $Res Function(_SensorInfo) _then;

  /// Create a copy of SensorInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? value = null,
  }) {
    return _then(_SensorInfo(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
