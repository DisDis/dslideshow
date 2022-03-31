// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ota_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$OtaStateTearOff {
  const _$OtaStateTearOff();

  _OtaInitialState initial({required OTAInfo info}) {
    return _OtaInitialState(
      info: info,
    );
  }

  _OtaReadyState ready({required OTAInfo info}) {
    return _OtaReadyState(
      info: info,
    );
  }

  _OtaProgressState progress({required OTAInfo info}) {
    return _OtaProgressState(
      info: info,
    );
  }

  _OtaSuccessState success({required OTAInfo info}) {
    return _OtaSuccessState(
      info: info,
    );
  }

  _OtaFailureState failure({required OTAInfo info}) {
    return _OtaFailureState(
      info: info,
    );
  }

  _OtaExitState exit({required OTAInfo info}) {
    return _OtaExitState(
      info: info,
    );
  }
}

/// @nodoc
const $OtaState = _$OtaStateTearOff();

/// @nodoc
mixin _$OtaState {
  OTAInfo get info => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(OTAInfo info) initial,
    required TResult Function(OTAInfo info) ready,
    required TResult Function(OTAInfo info) progress,
    required TResult Function(OTAInfo info) success,
    required TResult Function(OTAInfo info) failure,
    required TResult Function(OTAInfo info) exit,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(OTAInfo info)? initial,
    TResult Function(OTAInfo info)? ready,
    TResult Function(OTAInfo info)? progress,
    TResult Function(OTAInfo info)? success,
    TResult Function(OTAInfo info)? failure,
    TResult Function(OTAInfo info)? exit,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OTAInfo info)? initial,
    TResult Function(OTAInfo info)? ready,
    TResult Function(OTAInfo info)? progress,
    TResult Function(OTAInfo info)? success,
    TResult Function(OTAInfo info)? failure,
    TResult Function(OTAInfo info)? exit,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OtaInitialState value) initial,
    required TResult Function(_OtaReadyState value) ready,
    required TResult Function(_OtaProgressState value) progress,
    required TResult Function(_OtaSuccessState value) success,
    required TResult Function(_OtaFailureState value) failure,
    required TResult Function(_OtaExitState value) exit,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_OtaInitialState value)? initial,
    TResult Function(_OtaReadyState value)? ready,
    TResult Function(_OtaProgressState value)? progress,
    TResult Function(_OtaSuccessState value)? success,
    TResult Function(_OtaFailureState value)? failure,
    TResult Function(_OtaExitState value)? exit,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OtaInitialState value)? initial,
    TResult Function(_OtaReadyState value)? ready,
    TResult Function(_OtaProgressState value)? progress,
    TResult Function(_OtaSuccessState value)? success,
    TResult Function(_OtaFailureState value)? failure,
    TResult Function(_OtaExitState value)? exit,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OtaStateCopyWith<OtaState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtaStateCopyWith<$Res> {
  factory $OtaStateCopyWith(OtaState value, $Res Function(OtaState) then) =
      _$OtaStateCopyWithImpl<$Res>;
  $Res call({OTAInfo info});
}

/// @nodoc
class _$OtaStateCopyWithImpl<$Res> implements $OtaStateCopyWith<$Res> {
  _$OtaStateCopyWithImpl(this._value, this._then);

  final OtaState _value;
  // ignore: unused_field
  final $Res Function(OtaState) _then;

  @override
  $Res call({
    Object? info = freezed,
  }) {
    return _then(_value.copyWith(
      info: info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as OTAInfo,
    ));
  }
}

/// @nodoc
abstract class _$OtaInitialStateCopyWith<$Res>
    implements $OtaStateCopyWith<$Res> {
  factory _$OtaInitialStateCopyWith(
          _OtaInitialState value, $Res Function(_OtaInitialState) then) =
      __$OtaInitialStateCopyWithImpl<$Res>;
  @override
  $Res call({OTAInfo info});
}

/// @nodoc
class __$OtaInitialStateCopyWithImpl<$Res> extends _$OtaStateCopyWithImpl<$Res>
    implements _$OtaInitialStateCopyWith<$Res> {
  __$OtaInitialStateCopyWithImpl(
      _OtaInitialState _value, $Res Function(_OtaInitialState) _then)
      : super(_value, (v) => _then(v as _OtaInitialState));

  @override
  _OtaInitialState get _value => super._value as _OtaInitialState;

  @override
  $Res call({
    Object? info = freezed,
  }) {
    return _then(_OtaInitialState(
      info: info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as OTAInfo,
    ));
  }
}

/// @nodoc

class _$_OtaInitialState implements _OtaInitialState {
  const _$_OtaInitialState({required this.info});

  @override
  final OTAInfo info;

  @override
  String toString() {
    return 'OtaState.initial(info: $info)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OtaInitialState &&
            const DeepCollectionEquality().equals(other.info, info));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(info));

  @JsonKey(ignore: true)
  @override
  _$OtaInitialStateCopyWith<_OtaInitialState> get copyWith =>
      __$OtaInitialStateCopyWithImpl<_OtaInitialState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(OTAInfo info) initial,
    required TResult Function(OTAInfo info) ready,
    required TResult Function(OTAInfo info) progress,
    required TResult Function(OTAInfo info) success,
    required TResult Function(OTAInfo info) failure,
    required TResult Function(OTAInfo info) exit,
  }) {
    return initial(info);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(OTAInfo info)? initial,
    TResult Function(OTAInfo info)? ready,
    TResult Function(OTAInfo info)? progress,
    TResult Function(OTAInfo info)? success,
    TResult Function(OTAInfo info)? failure,
    TResult Function(OTAInfo info)? exit,
  }) {
    return initial?.call(info);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OTAInfo info)? initial,
    TResult Function(OTAInfo info)? ready,
    TResult Function(OTAInfo info)? progress,
    TResult Function(OTAInfo info)? success,
    TResult Function(OTAInfo info)? failure,
    TResult Function(OTAInfo info)? exit,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(info);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OtaInitialState value) initial,
    required TResult Function(_OtaReadyState value) ready,
    required TResult Function(_OtaProgressState value) progress,
    required TResult Function(_OtaSuccessState value) success,
    required TResult Function(_OtaFailureState value) failure,
    required TResult Function(_OtaExitState value) exit,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_OtaInitialState value)? initial,
    TResult Function(_OtaReadyState value)? ready,
    TResult Function(_OtaProgressState value)? progress,
    TResult Function(_OtaSuccessState value)? success,
    TResult Function(_OtaFailureState value)? failure,
    TResult Function(_OtaExitState value)? exit,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OtaInitialState value)? initial,
    TResult Function(_OtaReadyState value)? ready,
    TResult Function(_OtaProgressState value)? progress,
    TResult Function(_OtaSuccessState value)? success,
    TResult Function(_OtaFailureState value)? failure,
    TResult Function(_OtaExitState value)? exit,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _OtaInitialState implements OtaState {
  const factory _OtaInitialState({required OTAInfo info}) = _$_OtaInitialState;

  @override
  OTAInfo get info;
  @override
  @JsonKey(ignore: true)
  _$OtaInitialStateCopyWith<_OtaInitialState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$OtaReadyStateCopyWith<$Res>
    implements $OtaStateCopyWith<$Res> {
  factory _$OtaReadyStateCopyWith(
          _OtaReadyState value, $Res Function(_OtaReadyState) then) =
      __$OtaReadyStateCopyWithImpl<$Res>;
  @override
  $Res call({OTAInfo info});
}

/// @nodoc
class __$OtaReadyStateCopyWithImpl<$Res> extends _$OtaStateCopyWithImpl<$Res>
    implements _$OtaReadyStateCopyWith<$Res> {
  __$OtaReadyStateCopyWithImpl(
      _OtaReadyState _value, $Res Function(_OtaReadyState) _then)
      : super(_value, (v) => _then(v as _OtaReadyState));

  @override
  _OtaReadyState get _value => super._value as _OtaReadyState;

  @override
  $Res call({
    Object? info = freezed,
  }) {
    return _then(_OtaReadyState(
      info: info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as OTAInfo,
    ));
  }
}

/// @nodoc

class _$_OtaReadyState implements _OtaReadyState {
  const _$_OtaReadyState({required this.info});

  @override
  final OTAInfo info;

  @override
  String toString() {
    return 'OtaState.ready(info: $info)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OtaReadyState &&
            const DeepCollectionEquality().equals(other.info, info));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(info));

  @JsonKey(ignore: true)
  @override
  _$OtaReadyStateCopyWith<_OtaReadyState> get copyWith =>
      __$OtaReadyStateCopyWithImpl<_OtaReadyState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(OTAInfo info) initial,
    required TResult Function(OTAInfo info) ready,
    required TResult Function(OTAInfo info) progress,
    required TResult Function(OTAInfo info) success,
    required TResult Function(OTAInfo info) failure,
    required TResult Function(OTAInfo info) exit,
  }) {
    return ready(info);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(OTAInfo info)? initial,
    TResult Function(OTAInfo info)? ready,
    TResult Function(OTAInfo info)? progress,
    TResult Function(OTAInfo info)? success,
    TResult Function(OTAInfo info)? failure,
    TResult Function(OTAInfo info)? exit,
  }) {
    return ready?.call(info);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OTAInfo info)? initial,
    TResult Function(OTAInfo info)? ready,
    TResult Function(OTAInfo info)? progress,
    TResult Function(OTAInfo info)? success,
    TResult Function(OTAInfo info)? failure,
    TResult Function(OTAInfo info)? exit,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(info);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OtaInitialState value) initial,
    required TResult Function(_OtaReadyState value) ready,
    required TResult Function(_OtaProgressState value) progress,
    required TResult Function(_OtaSuccessState value) success,
    required TResult Function(_OtaFailureState value) failure,
    required TResult Function(_OtaExitState value) exit,
  }) {
    return ready(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_OtaInitialState value)? initial,
    TResult Function(_OtaReadyState value)? ready,
    TResult Function(_OtaProgressState value)? progress,
    TResult Function(_OtaSuccessState value)? success,
    TResult Function(_OtaFailureState value)? failure,
    TResult Function(_OtaExitState value)? exit,
  }) {
    return ready?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OtaInitialState value)? initial,
    TResult Function(_OtaReadyState value)? ready,
    TResult Function(_OtaProgressState value)? progress,
    TResult Function(_OtaSuccessState value)? success,
    TResult Function(_OtaFailureState value)? failure,
    TResult Function(_OtaExitState value)? exit,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(this);
    }
    return orElse();
  }
}

abstract class _OtaReadyState implements OtaState {
  const factory _OtaReadyState({required OTAInfo info}) = _$_OtaReadyState;

  @override
  OTAInfo get info;
  @override
  @JsonKey(ignore: true)
  _$OtaReadyStateCopyWith<_OtaReadyState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$OtaProgressStateCopyWith<$Res>
    implements $OtaStateCopyWith<$Res> {
  factory _$OtaProgressStateCopyWith(
          _OtaProgressState value, $Res Function(_OtaProgressState) then) =
      __$OtaProgressStateCopyWithImpl<$Res>;
  @override
  $Res call({OTAInfo info});
}

/// @nodoc
class __$OtaProgressStateCopyWithImpl<$Res> extends _$OtaStateCopyWithImpl<$Res>
    implements _$OtaProgressStateCopyWith<$Res> {
  __$OtaProgressStateCopyWithImpl(
      _OtaProgressState _value, $Res Function(_OtaProgressState) _then)
      : super(_value, (v) => _then(v as _OtaProgressState));

  @override
  _OtaProgressState get _value => super._value as _OtaProgressState;

  @override
  $Res call({
    Object? info = freezed,
  }) {
    return _then(_OtaProgressState(
      info: info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as OTAInfo,
    ));
  }
}

/// @nodoc

class _$_OtaProgressState implements _OtaProgressState {
  const _$_OtaProgressState({required this.info});

  @override
  final OTAInfo info;

  @override
  String toString() {
    return 'OtaState.progress(info: $info)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OtaProgressState &&
            const DeepCollectionEquality().equals(other.info, info));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(info));

  @JsonKey(ignore: true)
  @override
  _$OtaProgressStateCopyWith<_OtaProgressState> get copyWith =>
      __$OtaProgressStateCopyWithImpl<_OtaProgressState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(OTAInfo info) initial,
    required TResult Function(OTAInfo info) ready,
    required TResult Function(OTAInfo info) progress,
    required TResult Function(OTAInfo info) success,
    required TResult Function(OTAInfo info) failure,
    required TResult Function(OTAInfo info) exit,
  }) {
    return progress(info);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(OTAInfo info)? initial,
    TResult Function(OTAInfo info)? ready,
    TResult Function(OTAInfo info)? progress,
    TResult Function(OTAInfo info)? success,
    TResult Function(OTAInfo info)? failure,
    TResult Function(OTAInfo info)? exit,
  }) {
    return progress?.call(info);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OTAInfo info)? initial,
    TResult Function(OTAInfo info)? ready,
    TResult Function(OTAInfo info)? progress,
    TResult Function(OTAInfo info)? success,
    TResult Function(OTAInfo info)? failure,
    TResult Function(OTAInfo info)? exit,
    required TResult orElse(),
  }) {
    if (progress != null) {
      return progress(info);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OtaInitialState value) initial,
    required TResult Function(_OtaReadyState value) ready,
    required TResult Function(_OtaProgressState value) progress,
    required TResult Function(_OtaSuccessState value) success,
    required TResult Function(_OtaFailureState value) failure,
    required TResult Function(_OtaExitState value) exit,
  }) {
    return progress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_OtaInitialState value)? initial,
    TResult Function(_OtaReadyState value)? ready,
    TResult Function(_OtaProgressState value)? progress,
    TResult Function(_OtaSuccessState value)? success,
    TResult Function(_OtaFailureState value)? failure,
    TResult Function(_OtaExitState value)? exit,
  }) {
    return progress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OtaInitialState value)? initial,
    TResult Function(_OtaReadyState value)? ready,
    TResult Function(_OtaProgressState value)? progress,
    TResult Function(_OtaSuccessState value)? success,
    TResult Function(_OtaFailureState value)? failure,
    TResult Function(_OtaExitState value)? exit,
    required TResult orElse(),
  }) {
    if (progress != null) {
      return progress(this);
    }
    return orElse();
  }
}

abstract class _OtaProgressState implements OtaState {
  const factory _OtaProgressState({required OTAInfo info}) =
      _$_OtaProgressState;

  @override
  OTAInfo get info;
  @override
  @JsonKey(ignore: true)
  _$OtaProgressStateCopyWith<_OtaProgressState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$OtaSuccessStateCopyWith<$Res>
    implements $OtaStateCopyWith<$Res> {
  factory _$OtaSuccessStateCopyWith(
          _OtaSuccessState value, $Res Function(_OtaSuccessState) then) =
      __$OtaSuccessStateCopyWithImpl<$Res>;
  @override
  $Res call({OTAInfo info});
}

/// @nodoc
class __$OtaSuccessStateCopyWithImpl<$Res> extends _$OtaStateCopyWithImpl<$Res>
    implements _$OtaSuccessStateCopyWith<$Res> {
  __$OtaSuccessStateCopyWithImpl(
      _OtaSuccessState _value, $Res Function(_OtaSuccessState) _then)
      : super(_value, (v) => _then(v as _OtaSuccessState));

  @override
  _OtaSuccessState get _value => super._value as _OtaSuccessState;

  @override
  $Res call({
    Object? info = freezed,
  }) {
    return _then(_OtaSuccessState(
      info: info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as OTAInfo,
    ));
  }
}

/// @nodoc

class _$_OtaSuccessState implements _OtaSuccessState {
  const _$_OtaSuccessState({required this.info});

  @override
  final OTAInfo info;

  @override
  String toString() {
    return 'OtaState.success(info: $info)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OtaSuccessState &&
            const DeepCollectionEquality().equals(other.info, info));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(info));

  @JsonKey(ignore: true)
  @override
  _$OtaSuccessStateCopyWith<_OtaSuccessState> get copyWith =>
      __$OtaSuccessStateCopyWithImpl<_OtaSuccessState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(OTAInfo info) initial,
    required TResult Function(OTAInfo info) ready,
    required TResult Function(OTAInfo info) progress,
    required TResult Function(OTAInfo info) success,
    required TResult Function(OTAInfo info) failure,
    required TResult Function(OTAInfo info) exit,
  }) {
    return success(info);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(OTAInfo info)? initial,
    TResult Function(OTAInfo info)? ready,
    TResult Function(OTAInfo info)? progress,
    TResult Function(OTAInfo info)? success,
    TResult Function(OTAInfo info)? failure,
    TResult Function(OTAInfo info)? exit,
  }) {
    return success?.call(info);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OTAInfo info)? initial,
    TResult Function(OTAInfo info)? ready,
    TResult Function(OTAInfo info)? progress,
    TResult Function(OTAInfo info)? success,
    TResult Function(OTAInfo info)? failure,
    TResult Function(OTAInfo info)? exit,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(info);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OtaInitialState value) initial,
    required TResult Function(_OtaReadyState value) ready,
    required TResult Function(_OtaProgressState value) progress,
    required TResult Function(_OtaSuccessState value) success,
    required TResult Function(_OtaFailureState value) failure,
    required TResult Function(_OtaExitState value) exit,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_OtaInitialState value)? initial,
    TResult Function(_OtaReadyState value)? ready,
    TResult Function(_OtaProgressState value)? progress,
    TResult Function(_OtaSuccessState value)? success,
    TResult Function(_OtaFailureState value)? failure,
    TResult Function(_OtaExitState value)? exit,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OtaInitialState value)? initial,
    TResult Function(_OtaReadyState value)? ready,
    TResult Function(_OtaProgressState value)? progress,
    TResult Function(_OtaSuccessState value)? success,
    TResult Function(_OtaFailureState value)? failure,
    TResult Function(_OtaExitState value)? exit,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _OtaSuccessState implements OtaState {
  const factory _OtaSuccessState({required OTAInfo info}) = _$_OtaSuccessState;

  @override
  OTAInfo get info;
  @override
  @JsonKey(ignore: true)
  _$OtaSuccessStateCopyWith<_OtaSuccessState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$OtaFailureStateCopyWith<$Res>
    implements $OtaStateCopyWith<$Res> {
  factory _$OtaFailureStateCopyWith(
          _OtaFailureState value, $Res Function(_OtaFailureState) then) =
      __$OtaFailureStateCopyWithImpl<$Res>;
  @override
  $Res call({OTAInfo info});
}

/// @nodoc
class __$OtaFailureStateCopyWithImpl<$Res> extends _$OtaStateCopyWithImpl<$Res>
    implements _$OtaFailureStateCopyWith<$Res> {
  __$OtaFailureStateCopyWithImpl(
      _OtaFailureState _value, $Res Function(_OtaFailureState) _then)
      : super(_value, (v) => _then(v as _OtaFailureState));

  @override
  _OtaFailureState get _value => super._value as _OtaFailureState;

  @override
  $Res call({
    Object? info = freezed,
  }) {
    return _then(_OtaFailureState(
      info: info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as OTAInfo,
    ));
  }
}

/// @nodoc

class _$_OtaFailureState implements _OtaFailureState {
  const _$_OtaFailureState({required this.info});

  @override
  final OTAInfo info;

  @override
  String toString() {
    return 'OtaState.failure(info: $info)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OtaFailureState &&
            const DeepCollectionEquality().equals(other.info, info));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(info));

  @JsonKey(ignore: true)
  @override
  _$OtaFailureStateCopyWith<_OtaFailureState> get copyWith =>
      __$OtaFailureStateCopyWithImpl<_OtaFailureState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(OTAInfo info) initial,
    required TResult Function(OTAInfo info) ready,
    required TResult Function(OTAInfo info) progress,
    required TResult Function(OTAInfo info) success,
    required TResult Function(OTAInfo info) failure,
    required TResult Function(OTAInfo info) exit,
  }) {
    return failure(info);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(OTAInfo info)? initial,
    TResult Function(OTAInfo info)? ready,
    TResult Function(OTAInfo info)? progress,
    TResult Function(OTAInfo info)? success,
    TResult Function(OTAInfo info)? failure,
    TResult Function(OTAInfo info)? exit,
  }) {
    return failure?.call(info);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OTAInfo info)? initial,
    TResult Function(OTAInfo info)? ready,
    TResult Function(OTAInfo info)? progress,
    TResult Function(OTAInfo info)? success,
    TResult Function(OTAInfo info)? failure,
    TResult Function(OTAInfo info)? exit,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(info);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OtaInitialState value) initial,
    required TResult Function(_OtaReadyState value) ready,
    required TResult Function(_OtaProgressState value) progress,
    required TResult Function(_OtaSuccessState value) success,
    required TResult Function(_OtaFailureState value) failure,
    required TResult Function(_OtaExitState value) exit,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_OtaInitialState value)? initial,
    TResult Function(_OtaReadyState value)? ready,
    TResult Function(_OtaProgressState value)? progress,
    TResult Function(_OtaSuccessState value)? success,
    TResult Function(_OtaFailureState value)? failure,
    TResult Function(_OtaExitState value)? exit,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OtaInitialState value)? initial,
    TResult Function(_OtaReadyState value)? ready,
    TResult Function(_OtaProgressState value)? progress,
    TResult Function(_OtaSuccessState value)? success,
    TResult Function(_OtaFailureState value)? failure,
    TResult Function(_OtaExitState value)? exit,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _OtaFailureState implements OtaState {
  const factory _OtaFailureState({required OTAInfo info}) = _$_OtaFailureState;

  @override
  OTAInfo get info;
  @override
  @JsonKey(ignore: true)
  _$OtaFailureStateCopyWith<_OtaFailureState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$OtaExitStateCopyWith<$Res> implements $OtaStateCopyWith<$Res> {
  factory _$OtaExitStateCopyWith(
          _OtaExitState value, $Res Function(_OtaExitState) then) =
      __$OtaExitStateCopyWithImpl<$Res>;
  @override
  $Res call({OTAInfo info});
}

/// @nodoc
class __$OtaExitStateCopyWithImpl<$Res> extends _$OtaStateCopyWithImpl<$Res>
    implements _$OtaExitStateCopyWith<$Res> {
  __$OtaExitStateCopyWithImpl(
      _OtaExitState _value, $Res Function(_OtaExitState) _then)
      : super(_value, (v) => _then(v as _OtaExitState));

  @override
  _OtaExitState get _value => super._value as _OtaExitState;

  @override
  $Res call({
    Object? info = freezed,
  }) {
    return _then(_OtaExitState(
      info: info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as OTAInfo,
    ));
  }
}

/// @nodoc

class _$_OtaExitState implements _OtaExitState {
  const _$_OtaExitState({required this.info});

  @override
  final OTAInfo info;

  @override
  String toString() {
    return 'OtaState.exit(info: $info)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OtaExitState &&
            const DeepCollectionEquality().equals(other.info, info));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(info));

  @JsonKey(ignore: true)
  @override
  _$OtaExitStateCopyWith<_OtaExitState> get copyWith =>
      __$OtaExitStateCopyWithImpl<_OtaExitState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(OTAInfo info) initial,
    required TResult Function(OTAInfo info) ready,
    required TResult Function(OTAInfo info) progress,
    required TResult Function(OTAInfo info) success,
    required TResult Function(OTAInfo info) failure,
    required TResult Function(OTAInfo info) exit,
  }) {
    return exit(info);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(OTAInfo info)? initial,
    TResult Function(OTAInfo info)? ready,
    TResult Function(OTAInfo info)? progress,
    TResult Function(OTAInfo info)? success,
    TResult Function(OTAInfo info)? failure,
    TResult Function(OTAInfo info)? exit,
  }) {
    return exit?.call(info);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OTAInfo info)? initial,
    TResult Function(OTAInfo info)? ready,
    TResult Function(OTAInfo info)? progress,
    TResult Function(OTAInfo info)? success,
    TResult Function(OTAInfo info)? failure,
    TResult Function(OTAInfo info)? exit,
    required TResult orElse(),
  }) {
    if (exit != null) {
      return exit(info);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_OtaInitialState value) initial,
    required TResult Function(_OtaReadyState value) ready,
    required TResult Function(_OtaProgressState value) progress,
    required TResult Function(_OtaSuccessState value) success,
    required TResult Function(_OtaFailureState value) failure,
    required TResult Function(_OtaExitState value) exit,
  }) {
    return exit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_OtaInitialState value)? initial,
    TResult Function(_OtaReadyState value)? ready,
    TResult Function(_OtaProgressState value)? progress,
    TResult Function(_OtaSuccessState value)? success,
    TResult Function(_OtaFailureState value)? failure,
    TResult Function(_OtaExitState value)? exit,
  }) {
    return exit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_OtaInitialState value)? initial,
    TResult Function(_OtaReadyState value)? ready,
    TResult Function(_OtaProgressState value)? progress,
    TResult Function(_OtaSuccessState value)? success,
    TResult Function(_OtaFailureState value)? failure,
    TResult Function(_OtaExitState value)? exit,
    required TResult orElse(),
  }) {
    if (exit != null) {
      return exit(this);
    }
    return orElse();
  }
}

abstract class _OtaExitState implements OtaState {
  const factory _OtaExitState({required OTAInfo info}) = _$_OtaExitState;

  @override
  OTAInfo get info;
  @override
  @JsonKey(ignore: true)
  _$OtaExitStateCopyWith<_OtaExitState> get copyWith =>
      throw _privateConstructorUsedError;
}
