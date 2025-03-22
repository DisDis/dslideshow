// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'os_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OSInfo {
  String get name;
  OSType get osType;

  /// Create a copy of OSInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OSInfoCopyWith<OSInfo> get copyWith =>
      _$OSInfoCopyWithImpl<OSInfo>(this as OSInfo, _$identity);

  /// Serializes this OSInfo to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OSInfo &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.osType, osType) || other.osType == osType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, osType);

  @override
  String toString() {
    return 'OSInfo(name: $name, osType: $osType)';
  }
}

/// @nodoc
abstract mixin class $OSInfoCopyWith<$Res> {
  factory $OSInfoCopyWith(OSInfo value, $Res Function(OSInfo) _then) =
      _$OSInfoCopyWithImpl;
  @useResult
  $Res call({String name, OSType osType});
}

/// @nodoc
class _$OSInfoCopyWithImpl<$Res> implements $OSInfoCopyWith<$Res> {
  _$OSInfoCopyWithImpl(this._self, this._then);

  final OSInfo _self;
  final $Res Function(OSInfo) _then;

  /// Create a copy of OSInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? osType = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      osType: null == osType
          ? _self.osType
          : osType // ignore: cast_nullable_to_non_nullable
              as OSType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _OSInfo implements OSInfo {
  const _OSInfo({required this.name, required this.osType});
  factory _OSInfo.fromJson(Map<String, dynamic> json) => _$OSInfoFromJson(json);

  @override
  final String name;
  @override
  final OSType osType;

  /// Create a copy of OSInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OSInfoCopyWith<_OSInfo> get copyWith =>
      __$OSInfoCopyWithImpl<_OSInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OSInfoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OSInfo &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.osType, osType) || other.osType == osType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, osType);

  @override
  String toString() {
    return 'OSInfo(name: $name, osType: $osType)';
  }
}

/// @nodoc
abstract mixin class _$OSInfoCopyWith<$Res> implements $OSInfoCopyWith<$Res> {
  factory _$OSInfoCopyWith(_OSInfo value, $Res Function(_OSInfo) _then) =
      __$OSInfoCopyWithImpl;
  @override
  @useResult
  $Res call({String name, OSType osType});
}

/// @nodoc
class __$OSInfoCopyWithImpl<$Res> implements _$OSInfoCopyWith<$Res> {
  __$OSInfoCopyWithImpl(this._self, this._then);

  final _OSInfo _self;
  final $Res Function(_OSInfo) _then;

  /// Create a copy of OSInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? osType = null,
  }) {
    return _then(_OSInfo(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      osType: null == osType
          ? _self.osType
          : osType // ignore: cast_nullable_to_non_nullable
              as OSType,
    ));
  }
}

// dart format on
