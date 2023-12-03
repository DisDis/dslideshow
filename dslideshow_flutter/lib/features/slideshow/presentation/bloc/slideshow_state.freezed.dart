// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slideshow_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SlideshowState {
  MediaItem get item => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SlideshowStateCopyWith<SlideshowState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SlideshowStateCopyWith<$Res> {
  factory $SlideshowStateCopyWith(
          SlideshowState value, $Res Function(SlideshowState) then) =
      _$SlideshowStateCopyWithImpl<$Res, SlideshowState>;
  @useResult
  $Res call({MediaItem item});
}

/// @nodoc
class _$SlideshowStateCopyWithImpl<$Res, $Val extends SlideshowState>
    implements $SlideshowStateCopyWith<$Res> {
  _$SlideshowStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
  }) {
    return _then(_value.copyWith(
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as MediaItem,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SlideshowWorkStateImplCopyWith<$Res>
    implements $SlideshowStateCopyWith<$Res> {
  factory _$$SlideshowWorkStateImplCopyWith(_$SlideshowWorkStateImpl value,
          $Res Function(_$SlideshowWorkStateImpl) then) =
      __$$SlideshowWorkStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({MediaItem item});
}

/// @nodoc
class __$$SlideshowWorkStateImplCopyWithImpl<$Res>
    extends _$SlideshowStateCopyWithImpl<$Res, _$SlideshowWorkStateImpl>
    implements _$$SlideshowWorkStateImplCopyWith<$Res> {
  __$$SlideshowWorkStateImplCopyWithImpl(_$SlideshowWorkStateImpl _value,
      $Res Function(_$SlideshowWorkStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
  }) {
    return _then(_$SlideshowWorkStateImpl(
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as MediaItem,
    ));
  }
}

/// @nodoc

class _$SlideshowWorkStateImpl implements _SlideshowWorkState {
  const _$SlideshowWorkStateImpl({required this.item});

  @override
  final MediaItem item;

  @override
  String toString() {
    return 'SlideshowState(item: $item)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SlideshowWorkStateImpl &&
            (identical(other.item, item) || other.item == item));
  }

  @override
  int get hashCode => Object.hash(runtimeType, item);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SlideshowWorkStateImplCopyWith<_$SlideshowWorkStateImpl> get copyWith =>
      __$$SlideshowWorkStateImplCopyWithImpl<_$SlideshowWorkStateImpl>(
          this, _$identity);
}

abstract class _SlideshowWorkState implements SlideshowState {
  const factory _SlideshowWorkState({required final MediaItem item}) =
      _$SlideshowWorkStateImpl;

  @override
  MediaItem get item;
  @override
  @JsonKey(ignore: true)
  _$$SlideshowWorkStateImplCopyWith<_$SlideshowWorkStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
