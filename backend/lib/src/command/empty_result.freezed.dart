// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'empty_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EmptyResult {
  int get id;

  /// Create a copy of EmptyResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EmptyResultCopyWith<EmptyResult> get copyWith =>
      _$EmptyResultCopyWithImpl<EmptyResult>(this as EmptyResult, _$identity);

  /// Serializes this EmptyResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EmptyResult &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  @override
  String toString() {
    return 'EmptyResult(id: $id)';
  }
}

/// @nodoc
abstract mixin class $EmptyResultCopyWith<$Res> {
  factory $EmptyResultCopyWith(
          EmptyResult value, $Res Function(EmptyResult) _then) =
      _$EmptyResultCopyWithImpl;
  @useResult
  $Res call({int id});
}

/// @nodoc
class _$EmptyResultCopyWithImpl<$Res> implements $EmptyResultCopyWith<$Res> {
  _$EmptyResultCopyWithImpl(this._self, this._then);

  final EmptyResult _self;
  final $Res Function(EmptyResult) _then;

  /// Create a copy of EmptyResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _EmptyResult implements EmptyResult {
  const _EmptyResult({required this.id});
  factory _EmptyResult.fromJson(Map<String, dynamic> json) =>
      _$EmptyResultFromJson(json);

  @override
  final int id;

  /// Create a copy of EmptyResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EmptyResultCopyWith<_EmptyResult> get copyWith =>
      __$EmptyResultCopyWithImpl<_EmptyResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EmptyResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EmptyResult &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  @override
  String toString() {
    return 'EmptyResult(id: $id)';
  }
}

/// @nodoc
abstract mixin class _$EmptyResultCopyWith<$Res>
    implements $EmptyResultCopyWith<$Res> {
  factory _$EmptyResultCopyWith(
          _EmptyResult value, $Res Function(_EmptyResult) _then) =
      __$EmptyResultCopyWithImpl;
  @override
  @useResult
  $Res call({int id});
}

/// @nodoc
class __$EmptyResultCopyWithImpl<$Res> implements _$EmptyResultCopyWith<$Res> {
  __$EmptyResultCopyWithImpl(this._self, this._then);

  final _EmptyResult _self;
  final $Res Function(_EmptyResult) _then;

  /// Create a copy of EmptyResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
  }) {
    return _then(_EmptyResult(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
