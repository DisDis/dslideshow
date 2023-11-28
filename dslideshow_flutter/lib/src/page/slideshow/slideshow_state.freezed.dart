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
  bool get hasInternet => throw _privateConstructorUsedError;
  bool get isScreenLock => throw _privateConstructorUsedError;
  StorageStatusEnum get storageStatus => throw _privateConstructorUsedError;
  bool get isDebug => throw _privateConstructorUsedError;
  bool get isMenu => throw _privateConstructorUsedError;
  bool get isPaused => throw _privateConstructorUsedError;
  MediaItem get item => throw _privateConstructorUsedError;
  MediaSliderItemEffect get effect => throw _privateConstructorUsedError;

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
  $Res call(
      {bool hasInternet,
      bool isScreenLock,
      StorageStatusEnum storageStatus,
      bool isDebug,
      bool isMenu,
      bool isPaused,
      MediaItem item,
      MediaSliderItemEffect effect});
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
    Object? hasInternet = null,
    Object? isScreenLock = null,
    Object? storageStatus = null,
    Object? isDebug = null,
    Object? isMenu = null,
    Object? isPaused = null,
    Object? item = null,
    Object? effect = null,
  }) {
    return _then(_value.copyWith(
      hasInternet: null == hasInternet
          ? _value.hasInternet
          : hasInternet // ignore: cast_nullable_to_non_nullable
              as bool,
      isScreenLock: null == isScreenLock
          ? _value.isScreenLock
          : isScreenLock // ignore: cast_nullable_to_non_nullable
              as bool,
      storageStatus: null == storageStatus
          ? _value.storageStatus
          : storageStatus // ignore: cast_nullable_to_non_nullable
              as StorageStatusEnum,
      isDebug: null == isDebug
          ? _value.isDebug
          : isDebug // ignore: cast_nullable_to_non_nullable
              as bool,
      isMenu: null == isMenu
          ? _value.isMenu
          : isMenu // ignore: cast_nullable_to_non_nullable
              as bool,
      isPaused: null == isPaused
          ? _value.isPaused
          : isPaused // ignore: cast_nullable_to_non_nullable
              as bool,
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as MediaItem,
      effect: null == effect
          ? _value.effect
          : effect // ignore: cast_nullable_to_non_nullable
              as MediaSliderItemEffect,
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
  $Res call(
      {bool hasInternet,
      bool isScreenLock,
      StorageStatusEnum storageStatus,
      bool isDebug,
      bool isMenu,
      bool isPaused,
      MediaItem item,
      MediaSliderItemEffect effect});
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
    Object? hasInternet = null,
    Object? isScreenLock = null,
    Object? storageStatus = null,
    Object? isDebug = null,
    Object? isMenu = null,
    Object? isPaused = null,
    Object? item = null,
    Object? effect = null,
  }) {
    return _then(_$SlideshowWorkStateImpl(
      hasInternet: null == hasInternet
          ? _value.hasInternet
          : hasInternet // ignore: cast_nullable_to_non_nullable
              as bool,
      isScreenLock: null == isScreenLock
          ? _value.isScreenLock
          : isScreenLock // ignore: cast_nullable_to_non_nullable
              as bool,
      storageStatus: null == storageStatus
          ? _value.storageStatus
          : storageStatus // ignore: cast_nullable_to_non_nullable
              as StorageStatusEnum,
      isDebug: null == isDebug
          ? _value.isDebug
          : isDebug // ignore: cast_nullable_to_non_nullable
              as bool,
      isMenu: null == isMenu
          ? _value.isMenu
          : isMenu // ignore: cast_nullable_to_non_nullable
              as bool,
      isPaused: null == isPaused
          ? _value.isPaused
          : isPaused // ignore: cast_nullable_to_non_nullable
              as bool,
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as MediaItem,
      effect: null == effect
          ? _value.effect
          : effect // ignore: cast_nullable_to_non_nullable
              as MediaSliderItemEffect,
    ));
  }
}

/// @nodoc

class _$SlideshowWorkStateImpl implements _SlideshowWorkState {
  const _$SlideshowWorkStateImpl(
      {required this.hasInternet,
      required this.isScreenLock,
      this.storageStatus = StorageStatusEnum.done,
      required this.isDebug,
      required this.isMenu,
      required this.isPaused,
      required this.item,
      required this.effect});

  @override
  final bool hasInternet;
  @override
  final bool isScreenLock;
  @override
  @JsonKey()
  final StorageStatusEnum storageStatus;
  @override
  final bool isDebug;
  @override
  final bool isMenu;
  @override
  final bool isPaused;
  @override
  final MediaItem item;
  @override
  final MediaSliderItemEffect effect;

  @override
  String toString() {
    return 'SlideshowState(hasInternet: $hasInternet, isScreenLock: $isScreenLock, storageStatus: $storageStatus, isDebug: $isDebug, isMenu: $isMenu, isPaused: $isPaused, item: $item, effect: $effect)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SlideshowWorkStateImpl &&
            (identical(other.hasInternet, hasInternet) ||
                other.hasInternet == hasInternet) &&
            (identical(other.isScreenLock, isScreenLock) ||
                other.isScreenLock == isScreenLock) &&
            (identical(other.storageStatus, storageStatus) ||
                other.storageStatus == storageStatus) &&
            (identical(other.isDebug, isDebug) || other.isDebug == isDebug) &&
            (identical(other.isMenu, isMenu) || other.isMenu == isMenu) &&
            (identical(other.isPaused, isPaused) ||
                other.isPaused == isPaused) &&
            (identical(other.item, item) || other.item == item) &&
            (identical(other.effect, effect) || other.effect == effect));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hasInternet, isScreenLock,
      storageStatus, isDebug, isMenu, isPaused, item, effect);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SlideshowWorkStateImplCopyWith<_$SlideshowWorkStateImpl> get copyWith =>
      __$$SlideshowWorkStateImplCopyWithImpl<_$SlideshowWorkStateImpl>(
          this, _$identity);
}

abstract class _SlideshowWorkState implements SlideshowState {
  const factory _SlideshowWorkState(
      {required final bool hasInternet,
      required final bool isScreenLock,
      final StorageStatusEnum storageStatus,
      required final bool isDebug,
      required final bool isMenu,
      required final bool isPaused,
      required final MediaItem item,
      required final MediaSliderItemEffect effect}) = _$SlideshowWorkStateImpl;

  @override
  bool get hasInternet;
  @override
  bool get isScreenLock;
  @override
  StorageStatusEnum get storageStatus;
  @override
  bool get isDebug;
  @override
  bool get isMenu;
  @override
  bool get isPaused;
  @override
  MediaItem get item;
  @override
  MediaSliderItemEffect get effect;
  @override
  @JsonKey(ignore: true)
  _$$SlideshowWorkStateImplCopyWith<_$SlideshowWorkStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$IndicatorState {
  bool get hasInternet => throw _privateConstructorUsedError;
  StorageStatusEnum get storageStatus => throw _privateConstructorUsedError;
  bool get isDebug => throw _privateConstructorUsedError;
  bool get isMenu => throw _privateConstructorUsedError;
  bool get isPaused => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $IndicatorStateCopyWith<IndicatorState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IndicatorStateCopyWith<$Res> {
  factory $IndicatorStateCopyWith(
          IndicatorState value, $Res Function(IndicatorState) then) =
      _$IndicatorStateCopyWithImpl<$Res, IndicatorState>;
  @useResult
  $Res call(
      {bool hasInternet,
      StorageStatusEnum storageStatus,
      bool isDebug,
      bool isMenu,
      bool isPaused});
}

/// @nodoc
class _$IndicatorStateCopyWithImpl<$Res, $Val extends IndicatorState>
    implements $IndicatorStateCopyWith<$Res> {
  _$IndicatorStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasInternet = null,
    Object? storageStatus = null,
    Object? isDebug = null,
    Object? isMenu = null,
    Object? isPaused = null,
  }) {
    return _then(_value.copyWith(
      hasInternet: null == hasInternet
          ? _value.hasInternet
          : hasInternet // ignore: cast_nullable_to_non_nullable
              as bool,
      storageStatus: null == storageStatus
          ? _value.storageStatus
          : storageStatus // ignore: cast_nullable_to_non_nullable
              as StorageStatusEnum,
      isDebug: null == isDebug
          ? _value.isDebug
          : isDebug // ignore: cast_nullable_to_non_nullable
              as bool,
      isMenu: null == isMenu
          ? _value.isMenu
          : isMenu // ignore: cast_nullable_to_non_nullable
              as bool,
      isPaused: null == isPaused
          ? _value.isPaused
          : isPaused // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IndicatorStateImplCopyWith<$Res>
    implements $IndicatorStateCopyWith<$Res> {
  factory _$$IndicatorStateImplCopyWith(_$IndicatorStateImpl value,
          $Res Function(_$IndicatorStateImpl) then) =
      __$$IndicatorStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool hasInternet,
      StorageStatusEnum storageStatus,
      bool isDebug,
      bool isMenu,
      bool isPaused});
}

/// @nodoc
class __$$IndicatorStateImplCopyWithImpl<$Res>
    extends _$IndicatorStateCopyWithImpl<$Res, _$IndicatorStateImpl>
    implements _$$IndicatorStateImplCopyWith<$Res> {
  __$$IndicatorStateImplCopyWithImpl(
      _$IndicatorStateImpl _value, $Res Function(_$IndicatorStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasInternet = null,
    Object? storageStatus = null,
    Object? isDebug = null,
    Object? isMenu = null,
    Object? isPaused = null,
  }) {
    return _then(_$IndicatorStateImpl(
      hasInternet: null == hasInternet
          ? _value.hasInternet
          : hasInternet // ignore: cast_nullable_to_non_nullable
              as bool,
      storageStatus: null == storageStatus
          ? _value.storageStatus
          : storageStatus // ignore: cast_nullable_to_non_nullable
              as StorageStatusEnum,
      isDebug: null == isDebug
          ? _value.isDebug
          : isDebug // ignore: cast_nullable_to_non_nullable
              as bool,
      isMenu: null == isMenu
          ? _value.isMenu
          : isMenu // ignore: cast_nullable_to_non_nullable
              as bool,
      isPaused: null == isPaused
          ? _value.isPaused
          : isPaused // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$IndicatorStateImpl implements _IndicatorState {
  const _$IndicatorStateImpl(
      {required this.hasInternet,
      required this.storageStatus,
      required this.isDebug,
      required this.isMenu,
      required this.isPaused});

  @override
  final bool hasInternet;
  @override
  final StorageStatusEnum storageStatus;
  @override
  final bool isDebug;
  @override
  final bool isMenu;
  @override
  final bool isPaused;

  @override
  String toString() {
    return 'IndicatorState(hasInternet: $hasInternet, storageStatus: $storageStatus, isDebug: $isDebug, isMenu: $isMenu, isPaused: $isPaused)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IndicatorStateImpl &&
            (identical(other.hasInternet, hasInternet) ||
                other.hasInternet == hasInternet) &&
            (identical(other.storageStatus, storageStatus) ||
                other.storageStatus == storageStatus) &&
            (identical(other.isDebug, isDebug) || other.isDebug == isDebug) &&
            (identical(other.isMenu, isMenu) || other.isMenu == isMenu) &&
            (identical(other.isPaused, isPaused) ||
                other.isPaused == isPaused));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, hasInternet, storageStatus, isDebug, isMenu, isPaused);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IndicatorStateImplCopyWith<_$IndicatorStateImpl> get copyWith =>
      __$$IndicatorStateImplCopyWithImpl<_$IndicatorStateImpl>(
          this, _$identity);
}

abstract class _IndicatorState implements IndicatorState {
  const factory _IndicatorState(
      {required final bool hasInternet,
      required final StorageStatusEnum storageStatus,
      required final bool isDebug,
      required final bool isMenu,
      required final bool isPaused}) = _$IndicatorStateImpl;

  @override
  bool get hasInternet;
  @override
  StorageStatusEnum get storageStatus;
  @override
  bool get isDebug;
  @override
  bool get isMenu;
  @override
  bool get isPaused;
  @override
  @JsonKey(ignore: true)
  _$$IndicatorStateImplCopyWith<_$IndicatorStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
