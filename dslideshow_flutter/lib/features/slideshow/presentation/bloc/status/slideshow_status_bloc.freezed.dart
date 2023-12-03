// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slideshow_status_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SlideshowStatusEvent {
  Object get value => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool value) toggleScreenLock,
    required TResult Function(bool value) pause,
    required TResult Function(bool value) showMenu,
    required TResult Function(bool value) showInfo,
    required TResult Function(bool value) changeInternetConnection,
    required TResult Function(bool value) showDebug,
    required TResult Function(StorageStatusEnum value) changeStorageStatus,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool value)? toggleScreenLock,
    TResult? Function(bool value)? pause,
    TResult? Function(bool value)? showMenu,
    TResult? Function(bool value)? showInfo,
    TResult? Function(bool value)? changeInternetConnection,
    TResult? Function(bool value)? showDebug,
    TResult? Function(StorageStatusEnum value)? changeStorageStatus,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool value)? toggleScreenLock,
    TResult Function(bool value)? pause,
    TResult Function(bool value)? showMenu,
    TResult Function(bool value)? showInfo,
    TResult Function(bool value)? changeInternetConnection,
    TResult Function(bool value)? showDebug,
    TResult Function(StorageStatusEnum value)? changeStorageStatus,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SlideshowScreenLockEvent value) toggleScreenLock,
    required TResult Function(SlideshowPauseEvent value) pause,
    required TResult Function(SlideshowMenuEvent value) showMenu,
    required TResult Function(SlideshowSystemInfoEvent value) showInfo,
    required TResult Function(SlideshowInternetEvent value)
        changeInternetConnection,
    required TResult Function(SlideshowDebugEvent value) showDebug,
    required TResult Function(SlideshowChangeStorageStatusEvent value)
        changeStorageStatus,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SlideshowScreenLockEvent value)? toggleScreenLock,
    TResult? Function(SlideshowPauseEvent value)? pause,
    TResult? Function(SlideshowMenuEvent value)? showMenu,
    TResult? Function(SlideshowSystemInfoEvent value)? showInfo,
    TResult? Function(SlideshowInternetEvent value)? changeInternetConnection,
    TResult? Function(SlideshowDebugEvent value)? showDebug,
    TResult? Function(SlideshowChangeStorageStatusEvent value)?
        changeStorageStatus,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SlideshowScreenLockEvent value)? toggleScreenLock,
    TResult Function(SlideshowPauseEvent value)? pause,
    TResult Function(SlideshowMenuEvent value)? showMenu,
    TResult Function(SlideshowSystemInfoEvent value)? showInfo,
    TResult Function(SlideshowInternetEvent value)? changeInternetConnection,
    TResult Function(SlideshowDebugEvent value)? showDebug,
    TResult Function(SlideshowChangeStorageStatusEvent value)?
        changeStorageStatus,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SlideshowStatusEventCopyWith<$Res> {
  factory $SlideshowStatusEventCopyWith(SlideshowStatusEvent value,
          $Res Function(SlideshowStatusEvent) then) =
      _$SlideshowStatusEventCopyWithImpl<$Res, SlideshowStatusEvent>;
}

/// @nodoc
class _$SlideshowStatusEventCopyWithImpl<$Res,
        $Val extends SlideshowStatusEvent>
    implements $SlideshowStatusEventCopyWith<$Res> {
  _$SlideshowStatusEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SlideshowScreenLockEventImplCopyWith<$Res> {
  factory _$$SlideshowScreenLockEventImplCopyWith(
          _$SlideshowScreenLockEventImpl value,
          $Res Function(_$SlideshowScreenLockEventImpl) then) =
      __$$SlideshowScreenLockEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool value});
}

/// @nodoc
class __$$SlideshowScreenLockEventImplCopyWithImpl<$Res>
    extends _$SlideshowStatusEventCopyWithImpl<$Res,
        _$SlideshowScreenLockEventImpl>
    implements _$$SlideshowScreenLockEventImplCopyWith<$Res> {
  __$$SlideshowScreenLockEventImplCopyWithImpl(
      _$SlideshowScreenLockEventImpl _value,
      $Res Function(_$SlideshowScreenLockEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$SlideshowScreenLockEventImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SlideshowScreenLockEventImpl implements SlideshowScreenLockEvent {
  const _$SlideshowScreenLockEventImpl(this.value);

  @override
  final bool value;

  @override
  String toString() {
    return 'SlideshowStatusEvent.toggleScreenLock(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SlideshowScreenLockEventImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SlideshowScreenLockEventImplCopyWith<_$SlideshowScreenLockEventImpl>
      get copyWith => __$$SlideshowScreenLockEventImplCopyWithImpl<
          _$SlideshowScreenLockEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool value) toggleScreenLock,
    required TResult Function(bool value) pause,
    required TResult Function(bool value) showMenu,
    required TResult Function(bool value) showInfo,
    required TResult Function(bool value) changeInternetConnection,
    required TResult Function(bool value) showDebug,
    required TResult Function(StorageStatusEnum value) changeStorageStatus,
  }) {
    return toggleScreenLock(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool value)? toggleScreenLock,
    TResult? Function(bool value)? pause,
    TResult? Function(bool value)? showMenu,
    TResult? Function(bool value)? showInfo,
    TResult? Function(bool value)? changeInternetConnection,
    TResult? Function(bool value)? showDebug,
    TResult? Function(StorageStatusEnum value)? changeStorageStatus,
  }) {
    return toggleScreenLock?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool value)? toggleScreenLock,
    TResult Function(bool value)? pause,
    TResult Function(bool value)? showMenu,
    TResult Function(bool value)? showInfo,
    TResult Function(bool value)? changeInternetConnection,
    TResult Function(bool value)? showDebug,
    TResult Function(StorageStatusEnum value)? changeStorageStatus,
    required TResult orElse(),
  }) {
    if (toggleScreenLock != null) {
      return toggleScreenLock(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SlideshowScreenLockEvent value) toggleScreenLock,
    required TResult Function(SlideshowPauseEvent value) pause,
    required TResult Function(SlideshowMenuEvent value) showMenu,
    required TResult Function(SlideshowSystemInfoEvent value) showInfo,
    required TResult Function(SlideshowInternetEvent value)
        changeInternetConnection,
    required TResult Function(SlideshowDebugEvent value) showDebug,
    required TResult Function(SlideshowChangeStorageStatusEvent value)
        changeStorageStatus,
  }) {
    return toggleScreenLock(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SlideshowScreenLockEvent value)? toggleScreenLock,
    TResult? Function(SlideshowPauseEvent value)? pause,
    TResult? Function(SlideshowMenuEvent value)? showMenu,
    TResult? Function(SlideshowSystemInfoEvent value)? showInfo,
    TResult? Function(SlideshowInternetEvent value)? changeInternetConnection,
    TResult? Function(SlideshowDebugEvent value)? showDebug,
    TResult? Function(SlideshowChangeStorageStatusEvent value)?
        changeStorageStatus,
  }) {
    return toggleScreenLock?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SlideshowScreenLockEvent value)? toggleScreenLock,
    TResult Function(SlideshowPauseEvent value)? pause,
    TResult Function(SlideshowMenuEvent value)? showMenu,
    TResult Function(SlideshowSystemInfoEvent value)? showInfo,
    TResult Function(SlideshowInternetEvent value)? changeInternetConnection,
    TResult Function(SlideshowDebugEvent value)? showDebug,
    TResult Function(SlideshowChangeStorageStatusEvent value)?
        changeStorageStatus,
    required TResult orElse(),
  }) {
    if (toggleScreenLock != null) {
      return toggleScreenLock(this);
    }
    return orElse();
  }
}

abstract class SlideshowScreenLockEvent implements SlideshowStatusEvent {
  const factory SlideshowScreenLockEvent(final bool value) =
      _$SlideshowScreenLockEventImpl;

  @override
  bool get value;
  @JsonKey(ignore: true)
  _$$SlideshowScreenLockEventImplCopyWith<_$SlideshowScreenLockEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SlideshowPauseEventImplCopyWith<$Res> {
  factory _$$SlideshowPauseEventImplCopyWith(_$SlideshowPauseEventImpl value,
          $Res Function(_$SlideshowPauseEventImpl) then) =
      __$$SlideshowPauseEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool value});
}

/// @nodoc
class __$$SlideshowPauseEventImplCopyWithImpl<$Res>
    extends _$SlideshowStatusEventCopyWithImpl<$Res, _$SlideshowPauseEventImpl>
    implements _$$SlideshowPauseEventImplCopyWith<$Res> {
  __$$SlideshowPauseEventImplCopyWithImpl(_$SlideshowPauseEventImpl _value,
      $Res Function(_$SlideshowPauseEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$SlideshowPauseEventImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SlideshowPauseEventImpl implements SlideshowPauseEvent {
  const _$SlideshowPauseEventImpl(this.value);

  @override
  final bool value;

  @override
  String toString() {
    return 'SlideshowStatusEvent.pause(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SlideshowPauseEventImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SlideshowPauseEventImplCopyWith<_$SlideshowPauseEventImpl> get copyWith =>
      __$$SlideshowPauseEventImplCopyWithImpl<_$SlideshowPauseEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool value) toggleScreenLock,
    required TResult Function(bool value) pause,
    required TResult Function(bool value) showMenu,
    required TResult Function(bool value) showInfo,
    required TResult Function(bool value) changeInternetConnection,
    required TResult Function(bool value) showDebug,
    required TResult Function(StorageStatusEnum value) changeStorageStatus,
  }) {
    return pause(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool value)? toggleScreenLock,
    TResult? Function(bool value)? pause,
    TResult? Function(bool value)? showMenu,
    TResult? Function(bool value)? showInfo,
    TResult? Function(bool value)? changeInternetConnection,
    TResult? Function(bool value)? showDebug,
    TResult? Function(StorageStatusEnum value)? changeStorageStatus,
  }) {
    return pause?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool value)? toggleScreenLock,
    TResult Function(bool value)? pause,
    TResult Function(bool value)? showMenu,
    TResult Function(bool value)? showInfo,
    TResult Function(bool value)? changeInternetConnection,
    TResult Function(bool value)? showDebug,
    TResult Function(StorageStatusEnum value)? changeStorageStatus,
    required TResult orElse(),
  }) {
    if (pause != null) {
      return pause(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SlideshowScreenLockEvent value) toggleScreenLock,
    required TResult Function(SlideshowPauseEvent value) pause,
    required TResult Function(SlideshowMenuEvent value) showMenu,
    required TResult Function(SlideshowSystemInfoEvent value) showInfo,
    required TResult Function(SlideshowInternetEvent value)
        changeInternetConnection,
    required TResult Function(SlideshowDebugEvent value) showDebug,
    required TResult Function(SlideshowChangeStorageStatusEvent value)
        changeStorageStatus,
  }) {
    return pause(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SlideshowScreenLockEvent value)? toggleScreenLock,
    TResult? Function(SlideshowPauseEvent value)? pause,
    TResult? Function(SlideshowMenuEvent value)? showMenu,
    TResult? Function(SlideshowSystemInfoEvent value)? showInfo,
    TResult? Function(SlideshowInternetEvent value)? changeInternetConnection,
    TResult? Function(SlideshowDebugEvent value)? showDebug,
    TResult? Function(SlideshowChangeStorageStatusEvent value)?
        changeStorageStatus,
  }) {
    return pause?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SlideshowScreenLockEvent value)? toggleScreenLock,
    TResult Function(SlideshowPauseEvent value)? pause,
    TResult Function(SlideshowMenuEvent value)? showMenu,
    TResult Function(SlideshowSystemInfoEvent value)? showInfo,
    TResult Function(SlideshowInternetEvent value)? changeInternetConnection,
    TResult Function(SlideshowDebugEvent value)? showDebug,
    TResult Function(SlideshowChangeStorageStatusEvent value)?
        changeStorageStatus,
    required TResult orElse(),
  }) {
    if (pause != null) {
      return pause(this);
    }
    return orElse();
  }
}

abstract class SlideshowPauseEvent implements SlideshowStatusEvent {
  const factory SlideshowPauseEvent(final bool value) =
      _$SlideshowPauseEventImpl;

  @override
  bool get value;
  @JsonKey(ignore: true)
  _$$SlideshowPauseEventImplCopyWith<_$SlideshowPauseEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SlideshowMenuEventImplCopyWith<$Res> {
  factory _$$SlideshowMenuEventImplCopyWith(_$SlideshowMenuEventImpl value,
          $Res Function(_$SlideshowMenuEventImpl) then) =
      __$$SlideshowMenuEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool value});
}

/// @nodoc
class __$$SlideshowMenuEventImplCopyWithImpl<$Res>
    extends _$SlideshowStatusEventCopyWithImpl<$Res, _$SlideshowMenuEventImpl>
    implements _$$SlideshowMenuEventImplCopyWith<$Res> {
  __$$SlideshowMenuEventImplCopyWithImpl(_$SlideshowMenuEventImpl _value,
      $Res Function(_$SlideshowMenuEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$SlideshowMenuEventImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SlideshowMenuEventImpl implements SlideshowMenuEvent {
  const _$SlideshowMenuEventImpl(this.value);

  @override
  final bool value;

  @override
  String toString() {
    return 'SlideshowStatusEvent.showMenu(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SlideshowMenuEventImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SlideshowMenuEventImplCopyWith<_$SlideshowMenuEventImpl> get copyWith =>
      __$$SlideshowMenuEventImplCopyWithImpl<_$SlideshowMenuEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool value) toggleScreenLock,
    required TResult Function(bool value) pause,
    required TResult Function(bool value) showMenu,
    required TResult Function(bool value) showInfo,
    required TResult Function(bool value) changeInternetConnection,
    required TResult Function(bool value) showDebug,
    required TResult Function(StorageStatusEnum value) changeStorageStatus,
  }) {
    return showMenu(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool value)? toggleScreenLock,
    TResult? Function(bool value)? pause,
    TResult? Function(bool value)? showMenu,
    TResult? Function(bool value)? showInfo,
    TResult? Function(bool value)? changeInternetConnection,
    TResult? Function(bool value)? showDebug,
    TResult? Function(StorageStatusEnum value)? changeStorageStatus,
  }) {
    return showMenu?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool value)? toggleScreenLock,
    TResult Function(bool value)? pause,
    TResult Function(bool value)? showMenu,
    TResult Function(bool value)? showInfo,
    TResult Function(bool value)? changeInternetConnection,
    TResult Function(bool value)? showDebug,
    TResult Function(StorageStatusEnum value)? changeStorageStatus,
    required TResult orElse(),
  }) {
    if (showMenu != null) {
      return showMenu(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SlideshowScreenLockEvent value) toggleScreenLock,
    required TResult Function(SlideshowPauseEvent value) pause,
    required TResult Function(SlideshowMenuEvent value) showMenu,
    required TResult Function(SlideshowSystemInfoEvent value) showInfo,
    required TResult Function(SlideshowInternetEvent value)
        changeInternetConnection,
    required TResult Function(SlideshowDebugEvent value) showDebug,
    required TResult Function(SlideshowChangeStorageStatusEvent value)
        changeStorageStatus,
  }) {
    return showMenu(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SlideshowScreenLockEvent value)? toggleScreenLock,
    TResult? Function(SlideshowPauseEvent value)? pause,
    TResult? Function(SlideshowMenuEvent value)? showMenu,
    TResult? Function(SlideshowSystemInfoEvent value)? showInfo,
    TResult? Function(SlideshowInternetEvent value)? changeInternetConnection,
    TResult? Function(SlideshowDebugEvent value)? showDebug,
    TResult? Function(SlideshowChangeStorageStatusEvent value)?
        changeStorageStatus,
  }) {
    return showMenu?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SlideshowScreenLockEvent value)? toggleScreenLock,
    TResult Function(SlideshowPauseEvent value)? pause,
    TResult Function(SlideshowMenuEvent value)? showMenu,
    TResult Function(SlideshowSystemInfoEvent value)? showInfo,
    TResult Function(SlideshowInternetEvent value)? changeInternetConnection,
    TResult Function(SlideshowDebugEvent value)? showDebug,
    TResult Function(SlideshowChangeStorageStatusEvent value)?
        changeStorageStatus,
    required TResult orElse(),
  }) {
    if (showMenu != null) {
      return showMenu(this);
    }
    return orElse();
  }
}

abstract class SlideshowMenuEvent implements SlideshowStatusEvent {
  const factory SlideshowMenuEvent(final bool value) = _$SlideshowMenuEventImpl;

  @override
  bool get value;
  @JsonKey(ignore: true)
  _$$SlideshowMenuEventImplCopyWith<_$SlideshowMenuEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SlideshowSystemInfoEventImplCopyWith<$Res> {
  factory _$$SlideshowSystemInfoEventImplCopyWith(
          _$SlideshowSystemInfoEventImpl value,
          $Res Function(_$SlideshowSystemInfoEventImpl) then) =
      __$$SlideshowSystemInfoEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool value});
}

/// @nodoc
class __$$SlideshowSystemInfoEventImplCopyWithImpl<$Res>
    extends _$SlideshowStatusEventCopyWithImpl<$Res,
        _$SlideshowSystemInfoEventImpl>
    implements _$$SlideshowSystemInfoEventImplCopyWith<$Res> {
  __$$SlideshowSystemInfoEventImplCopyWithImpl(
      _$SlideshowSystemInfoEventImpl _value,
      $Res Function(_$SlideshowSystemInfoEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$SlideshowSystemInfoEventImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SlideshowSystemInfoEventImpl implements SlideshowSystemInfoEvent {
  const _$SlideshowSystemInfoEventImpl(this.value);

  @override
  final bool value;

  @override
  String toString() {
    return 'SlideshowStatusEvent.showInfo(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SlideshowSystemInfoEventImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SlideshowSystemInfoEventImplCopyWith<_$SlideshowSystemInfoEventImpl>
      get copyWith => __$$SlideshowSystemInfoEventImplCopyWithImpl<
          _$SlideshowSystemInfoEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool value) toggleScreenLock,
    required TResult Function(bool value) pause,
    required TResult Function(bool value) showMenu,
    required TResult Function(bool value) showInfo,
    required TResult Function(bool value) changeInternetConnection,
    required TResult Function(bool value) showDebug,
    required TResult Function(StorageStatusEnum value) changeStorageStatus,
  }) {
    return showInfo(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool value)? toggleScreenLock,
    TResult? Function(bool value)? pause,
    TResult? Function(bool value)? showMenu,
    TResult? Function(bool value)? showInfo,
    TResult? Function(bool value)? changeInternetConnection,
    TResult? Function(bool value)? showDebug,
    TResult? Function(StorageStatusEnum value)? changeStorageStatus,
  }) {
    return showInfo?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool value)? toggleScreenLock,
    TResult Function(bool value)? pause,
    TResult Function(bool value)? showMenu,
    TResult Function(bool value)? showInfo,
    TResult Function(bool value)? changeInternetConnection,
    TResult Function(bool value)? showDebug,
    TResult Function(StorageStatusEnum value)? changeStorageStatus,
    required TResult orElse(),
  }) {
    if (showInfo != null) {
      return showInfo(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SlideshowScreenLockEvent value) toggleScreenLock,
    required TResult Function(SlideshowPauseEvent value) pause,
    required TResult Function(SlideshowMenuEvent value) showMenu,
    required TResult Function(SlideshowSystemInfoEvent value) showInfo,
    required TResult Function(SlideshowInternetEvent value)
        changeInternetConnection,
    required TResult Function(SlideshowDebugEvent value) showDebug,
    required TResult Function(SlideshowChangeStorageStatusEvent value)
        changeStorageStatus,
  }) {
    return showInfo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SlideshowScreenLockEvent value)? toggleScreenLock,
    TResult? Function(SlideshowPauseEvent value)? pause,
    TResult? Function(SlideshowMenuEvent value)? showMenu,
    TResult? Function(SlideshowSystemInfoEvent value)? showInfo,
    TResult? Function(SlideshowInternetEvent value)? changeInternetConnection,
    TResult? Function(SlideshowDebugEvent value)? showDebug,
    TResult? Function(SlideshowChangeStorageStatusEvent value)?
        changeStorageStatus,
  }) {
    return showInfo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SlideshowScreenLockEvent value)? toggleScreenLock,
    TResult Function(SlideshowPauseEvent value)? pause,
    TResult Function(SlideshowMenuEvent value)? showMenu,
    TResult Function(SlideshowSystemInfoEvent value)? showInfo,
    TResult Function(SlideshowInternetEvent value)? changeInternetConnection,
    TResult Function(SlideshowDebugEvent value)? showDebug,
    TResult Function(SlideshowChangeStorageStatusEvent value)?
        changeStorageStatus,
    required TResult orElse(),
  }) {
    if (showInfo != null) {
      return showInfo(this);
    }
    return orElse();
  }
}

abstract class SlideshowSystemInfoEvent implements SlideshowStatusEvent {
  const factory SlideshowSystemInfoEvent(final bool value) =
      _$SlideshowSystemInfoEventImpl;

  @override
  bool get value;
  @JsonKey(ignore: true)
  _$$SlideshowSystemInfoEventImplCopyWith<_$SlideshowSystemInfoEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SlideshowInternetEventImplCopyWith<$Res> {
  factory _$$SlideshowInternetEventImplCopyWith(
          _$SlideshowInternetEventImpl value,
          $Res Function(_$SlideshowInternetEventImpl) then) =
      __$$SlideshowInternetEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool value});
}

/// @nodoc
class __$$SlideshowInternetEventImplCopyWithImpl<$Res>
    extends _$SlideshowStatusEventCopyWithImpl<$Res,
        _$SlideshowInternetEventImpl>
    implements _$$SlideshowInternetEventImplCopyWith<$Res> {
  __$$SlideshowInternetEventImplCopyWithImpl(
      _$SlideshowInternetEventImpl _value,
      $Res Function(_$SlideshowInternetEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$SlideshowInternetEventImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SlideshowInternetEventImpl implements SlideshowInternetEvent {
  const _$SlideshowInternetEventImpl(this.value);

  @override
  final bool value;

  @override
  String toString() {
    return 'SlideshowStatusEvent.changeInternetConnection(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SlideshowInternetEventImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SlideshowInternetEventImplCopyWith<_$SlideshowInternetEventImpl>
      get copyWith => __$$SlideshowInternetEventImplCopyWithImpl<
          _$SlideshowInternetEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool value) toggleScreenLock,
    required TResult Function(bool value) pause,
    required TResult Function(bool value) showMenu,
    required TResult Function(bool value) showInfo,
    required TResult Function(bool value) changeInternetConnection,
    required TResult Function(bool value) showDebug,
    required TResult Function(StorageStatusEnum value) changeStorageStatus,
  }) {
    return changeInternetConnection(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool value)? toggleScreenLock,
    TResult? Function(bool value)? pause,
    TResult? Function(bool value)? showMenu,
    TResult? Function(bool value)? showInfo,
    TResult? Function(bool value)? changeInternetConnection,
    TResult? Function(bool value)? showDebug,
    TResult? Function(StorageStatusEnum value)? changeStorageStatus,
  }) {
    return changeInternetConnection?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool value)? toggleScreenLock,
    TResult Function(bool value)? pause,
    TResult Function(bool value)? showMenu,
    TResult Function(bool value)? showInfo,
    TResult Function(bool value)? changeInternetConnection,
    TResult Function(bool value)? showDebug,
    TResult Function(StorageStatusEnum value)? changeStorageStatus,
    required TResult orElse(),
  }) {
    if (changeInternetConnection != null) {
      return changeInternetConnection(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SlideshowScreenLockEvent value) toggleScreenLock,
    required TResult Function(SlideshowPauseEvent value) pause,
    required TResult Function(SlideshowMenuEvent value) showMenu,
    required TResult Function(SlideshowSystemInfoEvent value) showInfo,
    required TResult Function(SlideshowInternetEvent value)
        changeInternetConnection,
    required TResult Function(SlideshowDebugEvent value) showDebug,
    required TResult Function(SlideshowChangeStorageStatusEvent value)
        changeStorageStatus,
  }) {
    return changeInternetConnection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SlideshowScreenLockEvent value)? toggleScreenLock,
    TResult? Function(SlideshowPauseEvent value)? pause,
    TResult? Function(SlideshowMenuEvent value)? showMenu,
    TResult? Function(SlideshowSystemInfoEvent value)? showInfo,
    TResult? Function(SlideshowInternetEvent value)? changeInternetConnection,
    TResult? Function(SlideshowDebugEvent value)? showDebug,
    TResult? Function(SlideshowChangeStorageStatusEvent value)?
        changeStorageStatus,
  }) {
    return changeInternetConnection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SlideshowScreenLockEvent value)? toggleScreenLock,
    TResult Function(SlideshowPauseEvent value)? pause,
    TResult Function(SlideshowMenuEvent value)? showMenu,
    TResult Function(SlideshowSystemInfoEvent value)? showInfo,
    TResult Function(SlideshowInternetEvent value)? changeInternetConnection,
    TResult Function(SlideshowDebugEvent value)? showDebug,
    TResult Function(SlideshowChangeStorageStatusEvent value)?
        changeStorageStatus,
    required TResult orElse(),
  }) {
    if (changeInternetConnection != null) {
      return changeInternetConnection(this);
    }
    return orElse();
  }
}

abstract class SlideshowInternetEvent implements SlideshowStatusEvent {
  const factory SlideshowInternetEvent(final bool value) =
      _$SlideshowInternetEventImpl;

  @override
  bool get value;
  @JsonKey(ignore: true)
  _$$SlideshowInternetEventImplCopyWith<_$SlideshowInternetEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SlideshowDebugEventImplCopyWith<$Res> {
  factory _$$SlideshowDebugEventImplCopyWith(_$SlideshowDebugEventImpl value,
          $Res Function(_$SlideshowDebugEventImpl) then) =
      __$$SlideshowDebugEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool value});
}

/// @nodoc
class __$$SlideshowDebugEventImplCopyWithImpl<$Res>
    extends _$SlideshowStatusEventCopyWithImpl<$Res, _$SlideshowDebugEventImpl>
    implements _$$SlideshowDebugEventImplCopyWith<$Res> {
  __$$SlideshowDebugEventImplCopyWithImpl(_$SlideshowDebugEventImpl _value,
      $Res Function(_$SlideshowDebugEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$SlideshowDebugEventImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SlideshowDebugEventImpl implements SlideshowDebugEvent {
  const _$SlideshowDebugEventImpl(this.value);

  @override
  final bool value;

  @override
  String toString() {
    return 'SlideshowStatusEvent.showDebug(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SlideshowDebugEventImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SlideshowDebugEventImplCopyWith<_$SlideshowDebugEventImpl> get copyWith =>
      __$$SlideshowDebugEventImplCopyWithImpl<_$SlideshowDebugEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool value) toggleScreenLock,
    required TResult Function(bool value) pause,
    required TResult Function(bool value) showMenu,
    required TResult Function(bool value) showInfo,
    required TResult Function(bool value) changeInternetConnection,
    required TResult Function(bool value) showDebug,
    required TResult Function(StorageStatusEnum value) changeStorageStatus,
  }) {
    return showDebug(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool value)? toggleScreenLock,
    TResult? Function(bool value)? pause,
    TResult? Function(bool value)? showMenu,
    TResult? Function(bool value)? showInfo,
    TResult? Function(bool value)? changeInternetConnection,
    TResult? Function(bool value)? showDebug,
    TResult? Function(StorageStatusEnum value)? changeStorageStatus,
  }) {
    return showDebug?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool value)? toggleScreenLock,
    TResult Function(bool value)? pause,
    TResult Function(bool value)? showMenu,
    TResult Function(bool value)? showInfo,
    TResult Function(bool value)? changeInternetConnection,
    TResult Function(bool value)? showDebug,
    TResult Function(StorageStatusEnum value)? changeStorageStatus,
    required TResult orElse(),
  }) {
    if (showDebug != null) {
      return showDebug(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SlideshowScreenLockEvent value) toggleScreenLock,
    required TResult Function(SlideshowPauseEvent value) pause,
    required TResult Function(SlideshowMenuEvent value) showMenu,
    required TResult Function(SlideshowSystemInfoEvent value) showInfo,
    required TResult Function(SlideshowInternetEvent value)
        changeInternetConnection,
    required TResult Function(SlideshowDebugEvent value) showDebug,
    required TResult Function(SlideshowChangeStorageStatusEvent value)
        changeStorageStatus,
  }) {
    return showDebug(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SlideshowScreenLockEvent value)? toggleScreenLock,
    TResult? Function(SlideshowPauseEvent value)? pause,
    TResult? Function(SlideshowMenuEvent value)? showMenu,
    TResult? Function(SlideshowSystemInfoEvent value)? showInfo,
    TResult? Function(SlideshowInternetEvent value)? changeInternetConnection,
    TResult? Function(SlideshowDebugEvent value)? showDebug,
    TResult? Function(SlideshowChangeStorageStatusEvent value)?
        changeStorageStatus,
  }) {
    return showDebug?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SlideshowScreenLockEvent value)? toggleScreenLock,
    TResult Function(SlideshowPauseEvent value)? pause,
    TResult Function(SlideshowMenuEvent value)? showMenu,
    TResult Function(SlideshowSystemInfoEvent value)? showInfo,
    TResult Function(SlideshowInternetEvent value)? changeInternetConnection,
    TResult Function(SlideshowDebugEvent value)? showDebug,
    TResult Function(SlideshowChangeStorageStatusEvent value)?
        changeStorageStatus,
    required TResult orElse(),
  }) {
    if (showDebug != null) {
      return showDebug(this);
    }
    return orElse();
  }
}

abstract class SlideshowDebugEvent implements SlideshowStatusEvent {
  const factory SlideshowDebugEvent(final bool value) =
      _$SlideshowDebugEventImpl;

  @override
  bool get value;
  @JsonKey(ignore: true)
  _$$SlideshowDebugEventImplCopyWith<_$SlideshowDebugEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SlideshowChangeStorageStatusEventImplCopyWith<$Res> {
  factory _$$SlideshowChangeStorageStatusEventImplCopyWith(
          _$SlideshowChangeStorageStatusEventImpl value,
          $Res Function(_$SlideshowChangeStorageStatusEventImpl) then) =
      __$$SlideshowChangeStorageStatusEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({StorageStatusEnum value});
}

/// @nodoc
class __$$SlideshowChangeStorageStatusEventImplCopyWithImpl<$Res>
    extends _$SlideshowStatusEventCopyWithImpl<$Res,
        _$SlideshowChangeStorageStatusEventImpl>
    implements _$$SlideshowChangeStorageStatusEventImplCopyWith<$Res> {
  __$$SlideshowChangeStorageStatusEventImplCopyWithImpl(
      _$SlideshowChangeStorageStatusEventImpl _value,
      $Res Function(_$SlideshowChangeStorageStatusEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$SlideshowChangeStorageStatusEventImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as StorageStatusEnum,
    ));
  }
}

/// @nodoc

class _$SlideshowChangeStorageStatusEventImpl
    implements SlideshowChangeStorageStatusEvent {
  const _$SlideshowChangeStorageStatusEventImpl(this.value);

  @override
  final StorageStatusEnum value;

  @override
  String toString() {
    return 'SlideshowStatusEvent.changeStorageStatus(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SlideshowChangeStorageStatusEventImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SlideshowChangeStorageStatusEventImplCopyWith<
          _$SlideshowChangeStorageStatusEventImpl>
      get copyWith => __$$SlideshowChangeStorageStatusEventImplCopyWithImpl<
          _$SlideshowChangeStorageStatusEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool value) toggleScreenLock,
    required TResult Function(bool value) pause,
    required TResult Function(bool value) showMenu,
    required TResult Function(bool value) showInfo,
    required TResult Function(bool value) changeInternetConnection,
    required TResult Function(bool value) showDebug,
    required TResult Function(StorageStatusEnum value) changeStorageStatus,
  }) {
    return changeStorageStatus(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool value)? toggleScreenLock,
    TResult? Function(bool value)? pause,
    TResult? Function(bool value)? showMenu,
    TResult? Function(bool value)? showInfo,
    TResult? Function(bool value)? changeInternetConnection,
    TResult? Function(bool value)? showDebug,
    TResult? Function(StorageStatusEnum value)? changeStorageStatus,
  }) {
    return changeStorageStatus?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool value)? toggleScreenLock,
    TResult Function(bool value)? pause,
    TResult Function(bool value)? showMenu,
    TResult Function(bool value)? showInfo,
    TResult Function(bool value)? changeInternetConnection,
    TResult Function(bool value)? showDebug,
    TResult Function(StorageStatusEnum value)? changeStorageStatus,
    required TResult orElse(),
  }) {
    if (changeStorageStatus != null) {
      return changeStorageStatus(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SlideshowScreenLockEvent value) toggleScreenLock,
    required TResult Function(SlideshowPauseEvent value) pause,
    required TResult Function(SlideshowMenuEvent value) showMenu,
    required TResult Function(SlideshowSystemInfoEvent value) showInfo,
    required TResult Function(SlideshowInternetEvent value)
        changeInternetConnection,
    required TResult Function(SlideshowDebugEvent value) showDebug,
    required TResult Function(SlideshowChangeStorageStatusEvent value)
        changeStorageStatus,
  }) {
    return changeStorageStatus(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SlideshowScreenLockEvent value)? toggleScreenLock,
    TResult? Function(SlideshowPauseEvent value)? pause,
    TResult? Function(SlideshowMenuEvent value)? showMenu,
    TResult? Function(SlideshowSystemInfoEvent value)? showInfo,
    TResult? Function(SlideshowInternetEvent value)? changeInternetConnection,
    TResult? Function(SlideshowDebugEvent value)? showDebug,
    TResult? Function(SlideshowChangeStorageStatusEvent value)?
        changeStorageStatus,
  }) {
    return changeStorageStatus?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SlideshowScreenLockEvent value)? toggleScreenLock,
    TResult Function(SlideshowPauseEvent value)? pause,
    TResult Function(SlideshowMenuEvent value)? showMenu,
    TResult Function(SlideshowSystemInfoEvent value)? showInfo,
    TResult Function(SlideshowInternetEvent value)? changeInternetConnection,
    TResult Function(SlideshowDebugEvent value)? showDebug,
    TResult Function(SlideshowChangeStorageStatusEvent value)?
        changeStorageStatus,
    required TResult orElse(),
  }) {
    if (changeStorageStatus != null) {
      return changeStorageStatus(this);
    }
    return orElse();
  }
}

abstract class SlideshowChangeStorageStatusEvent
    implements SlideshowStatusEvent {
  const factory SlideshowChangeStorageStatusEvent(
      final StorageStatusEnum value) = _$SlideshowChangeStorageStatusEventImpl;

  @override
  StorageStatusEnum get value;
  @JsonKey(ignore: true)
  _$$SlideshowChangeStorageStatusEventImplCopyWith<
          _$SlideshowChangeStorageStatusEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SlideshowStatusState {
  bool get hasInternet => throw _privateConstructorUsedError;
  bool get isScreenLock => throw _privateConstructorUsedError;
  StorageStatusEnum get storageStatus => throw _privateConstructorUsedError;
  bool get isDebug => throw _privateConstructorUsedError;
  bool get isMenu => throw _privateConstructorUsedError;
  bool get isInfo => throw _privateConstructorUsedError;
  bool get isPaused => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SlideshowStatusStateCopyWith<SlideshowStatusState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SlideshowStatusStateCopyWith<$Res> {
  factory $SlideshowStatusStateCopyWith(SlideshowStatusState value,
          $Res Function(SlideshowStatusState) then) =
      _$SlideshowStatusStateCopyWithImpl<$Res, SlideshowStatusState>;
  @useResult
  $Res call(
      {bool hasInternet,
      bool isScreenLock,
      StorageStatusEnum storageStatus,
      bool isDebug,
      bool isMenu,
      bool isInfo,
      bool isPaused});
}

/// @nodoc
class _$SlideshowStatusStateCopyWithImpl<$Res,
        $Val extends SlideshowStatusState>
    implements $SlideshowStatusStateCopyWith<$Res> {
  _$SlideshowStatusStateCopyWithImpl(this._value, this._then);

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
    Object? isInfo = null,
    Object? isPaused = null,
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
      isInfo: null == isInfo
          ? _value.isInfo
          : isInfo // ignore: cast_nullable_to_non_nullable
              as bool,
      isPaused: null == isPaused
          ? _value.isPaused
          : isPaused // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SlideshowStatusInitialImplCopyWith<$Res>
    implements $SlideshowStatusStateCopyWith<$Res> {
  factory _$$SlideshowStatusInitialImplCopyWith(
          _$SlideshowStatusInitialImpl value,
          $Res Function(_$SlideshowStatusInitialImpl) then) =
      __$$SlideshowStatusInitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool hasInternet,
      bool isScreenLock,
      StorageStatusEnum storageStatus,
      bool isDebug,
      bool isMenu,
      bool isInfo,
      bool isPaused});
}

/// @nodoc
class __$$SlideshowStatusInitialImplCopyWithImpl<$Res>
    extends _$SlideshowStatusStateCopyWithImpl<$Res,
        _$SlideshowStatusInitialImpl>
    implements _$$SlideshowStatusInitialImplCopyWith<$Res> {
  __$$SlideshowStatusInitialImplCopyWithImpl(
      _$SlideshowStatusInitialImpl _value,
      $Res Function(_$SlideshowStatusInitialImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasInternet = null,
    Object? isScreenLock = null,
    Object? storageStatus = null,
    Object? isDebug = null,
    Object? isMenu = null,
    Object? isInfo = null,
    Object? isPaused = null,
  }) {
    return _then(_$SlideshowStatusInitialImpl(
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
      isInfo: null == isInfo
          ? _value.isInfo
          : isInfo // ignore: cast_nullable_to_non_nullable
              as bool,
      isPaused: null == isPaused
          ? _value.isPaused
          : isPaused // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SlideshowStatusInitialImpl implements SlideshowStatusInitial {
  const _$SlideshowStatusInitialImpl(
      {this.hasInternet = true,
      this.isScreenLock = false,
      this.storageStatus = StorageStatusEnum.done,
      this.isDebug = false,
      this.isMenu = false,
      this.isInfo = false,
      this.isPaused = false});

  @override
  @JsonKey()
  final bool hasInternet;
  @override
  @JsonKey()
  final bool isScreenLock;
  @override
  @JsonKey()
  final StorageStatusEnum storageStatus;
  @override
  @JsonKey()
  final bool isDebug;
  @override
  @JsonKey()
  final bool isMenu;
  @override
  @JsonKey()
  final bool isInfo;
  @override
  @JsonKey()
  final bool isPaused;

  @override
  String toString() {
    return 'SlideshowStatusState(hasInternet: $hasInternet, isScreenLock: $isScreenLock, storageStatus: $storageStatus, isDebug: $isDebug, isMenu: $isMenu, isInfo: $isInfo, isPaused: $isPaused)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SlideshowStatusInitialImpl &&
            (identical(other.hasInternet, hasInternet) ||
                other.hasInternet == hasInternet) &&
            (identical(other.isScreenLock, isScreenLock) ||
                other.isScreenLock == isScreenLock) &&
            (identical(other.storageStatus, storageStatus) ||
                other.storageStatus == storageStatus) &&
            (identical(other.isDebug, isDebug) || other.isDebug == isDebug) &&
            (identical(other.isMenu, isMenu) || other.isMenu == isMenu) &&
            (identical(other.isInfo, isInfo) || other.isInfo == isInfo) &&
            (identical(other.isPaused, isPaused) ||
                other.isPaused == isPaused));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hasInternet, isScreenLock,
      storageStatus, isDebug, isMenu, isInfo, isPaused);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SlideshowStatusInitialImplCopyWith<_$SlideshowStatusInitialImpl>
      get copyWith => __$$SlideshowStatusInitialImplCopyWithImpl<
          _$SlideshowStatusInitialImpl>(this, _$identity);
}

abstract class SlideshowStatusInitial implements SlideshowStatusState {
  const factory SlideshowStatusInitial(
      {final bool hasInternet,
      final bool isScreenLock,
      final StorageStatusEnum storageStatus,
      final bool isDebug,
      final bool isMenu,
      final bool isInfo,
      final bool isPaused}) = _$SlideshowStatusInitialImpl;

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
  bool get isInfo;
  @override
  bool get isPaused;
  @override
  @JsonKey(ignore: true)
  _$$SlideshowStatusInitialImplCopyWith<_$SlideshowStatusInitialImpl>
      get copyWith => throw _privateConstructorUsedError;
}
