// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slideshow_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SlideshowState {
  MediaItem get item;

  /// Create a copy of SlideshowState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SlideshowStateCopyWith<SlideshowState> get copyWith =>
      _$SlideshowStateCopyWithImpl<SlideshowState>(
          this as SlideshowState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SlideshowState &&
            (identical(other.item, item) || other.item == item));
  }

  @override
  int get hashCode => Object.hash(runtimeType, item);

  @override
  String toString() {
    return 'SlideshowState(item: $item)';
  }
}

/// @nodoc
abstract mixin class $SlideshowStateCopyWith<$Res> {
  factory $SlideshowStateCopyWith(
          SlideshowState value, $Res Function(SlideshowState) _then) =
      _$SlideshowStateCopyWithImpl;
  @useResult
  $Res call({MediaItem item});
}

/// @nodoc
class _$SlideshowStateCopyWithImpl<$Res>
    implements $SlideshowStateCopyWith<$Res> {
  _$SlideshowStateCopyWithImpl(this._self, this._then);

  final SlideshowState _self;
  final $Res Function(SlideshowState) _then;

  /// Create a copy of SlideshowState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
  }) {
    return _then(_self.copyWith(
      item: null == item
          ? _self.item
          : item // ignore: cast_nullable_to_non_nullable
              as MediaItem,
    ));
  }
}

/// @nodoc

class _SlideshowWorkState implements SlideshowState {
  const _SlideshowWorkState({required this.item});

  @override
  final MediaItem item;

  /// Create a copy of SlideshowState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SlideshowWorkStateCopyWith<_SlideshowWorkState> get copyWith =>
      __$SlideshowWorkStateCopyWithImpl<_SlideshowWorkState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SlideshowWorkState &&
            (identical(other.item, item) || other.item == item));
  }

  @override
  int get hashCode => Object.hash(runtimeType, item);

  @override
  String toString() {
    return 'SlideshowState(item: $item)';
  }
}

/// @nodoc
abstract mixin class _$SlideshowWorkStateCopyWith<$Res>
    implements $SlideshowStateCopyWith<$Res> {
  factory _$SlideshowWorkStateCopyWith(
          _SlideshowWorkState value, $Res Function(_SlideshowWorkState) _then) =
      __$SlideshowWorkStateCopyWithImpl;
  @override
  @useResult
  $Res call({MediaItem item});
}

/// @nodoc
class __$SlideshowWorkStateCopyWithImpl<$Res>
    implements _$SlideshowWorkStateCopyWith<$Res> {
  __$SlideshowWorkStateCopyWithImpl(this._self, this._then);

  final _SlideshowWorkState _self;
  final $Res Function(_SlideshowWorkState) _then;

  /// Create a copy of SlideshowState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? item = null,
  }) {
    return _then(_SlideshowWorkState(
      item: null == item
          ? _self.item
          : item // ignore: cast_nullable_to_non_nullable
              as MediaItem,
    ));
  }
}

// dart format on
