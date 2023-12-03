// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ota_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
    TResult? Function(OTAInfo info)? initial,
    TResult? Function(OTAInfo info)? ready,
    TResult? Function(OTAInfo info)? progress,
    TResult? Function(OTAInfo info)? success,
    TResult? Function(OTAInfo info)? failure,
    TResult? Function(OTAInfo info)? exit,
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
    TResult? Function(_OtaInitialState value)? initial,
    TResult? Function(_OtaReadyState value)? ready,
    TResult? Function(_OtaProgressState value)? progress,
    TResult? Function(_OtaSuccessState value)? success,
    TResult? Function(_OtaFailureState value)? failure,
    TResult? Function(_OtaExitState value)? exit,
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
      _$OtaStateCopyWithImpl<$Res, OtaState>;
  @useResult
  $Res call({OTAInfo info});

  $OTAInfoCopyWith<$Res> get info;
}

/// @nodoc
class _$OtaStateCopyWithImpl<$Res, $Val extends OtaState>
    implements $OtaStateCopyWith<$Res> {
  _$OtaStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
  }) {
    return _then(_value.copyWith(
      info: null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as OTAInfo,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OTAInfoCopyWith<$Res> get info {
    return $OTAInfoCopyWith<$Res>(_value.info, (value) {
      return _then(_value.copyWith(info: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OtaInitialStateImplCopyWith<$Res>
    implements $OtaStateCopyWith<$Res> {
  factory _$$OtaInitialStateImplCopyWith(_$OtaInitialStateImpl value,
          $Res Function(_$OtaInitialStateImpl) then) =
      __$$OtaInitialStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({OTAInfo info});

  @override
  $OTAInfoCopyWith<$Res> get info;
}

/// @nodoc
class __$$OtaInitialStateImplCopyWithImpl<$Res>
    extends _$OtaStateCopyWithImpl<$Res, _$OtaInitialStateImpl>
    implements _$$OtaInitialStateImplCopyWith<$Res> {
  __$$OtaInitialStateImplCopyWithImpl(
      _$OtaInitialStateImpl _value, $Res Function(_$OtaInitialStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
  }) {
    return _then(_$OtaInitialStateImpl(
      info: null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as OTAInfo,
    ));
  }
}

/// @nodoc

class _$OtaInitialStateImpl implements _OtaInitialState {
  const _$OtaInitialStateImpl({required this.info});

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
            other is _$OtaInitialStateImpl &&
            (identical(other.info, info) || other.info == info));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OtaInitialStateImplCopyWith<_$OtaInitialStateImpl> get copyWith =>
      __$$OtaInitialStateImplCopyWithImpl<_$OtaInitialStateImpl>(
          this, _$identity);

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
    TResult? Function(OTAInfo info)? initial,
    TResult? Function(OTAInfo info)? ready,
    TResult? Function(OTAInfo info)? progress,
    TResult? Function(OTAInfo info)? success,
    TResult? Function(OTAInfo info)? failure,
    TResult? Function(OTAInfo info)? exit,
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
    TResult? Function(_OtaInitialState value)? initial,
    TResult? Function(_OtaReadyState value)? ready,
    TResult? Function(_OtaProgressState value)? progress,
    TResult? Function(_OtaSuccessState value)? success,
    TResult? Function(_OtaFailureState value)? failure,
    TResult? Function(_OtaExitState value)? exit,
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
  const factory _OtaInitialState({required final OTAInfo info}) =
      _$OtaInitialStateImpl;

  @override
  OTAInfo get info;
  @override
  @JsonKey(ignore: true)
  _$$OtaInitialStateImplCopyWith<_$OtaInitialStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OtaReadyStateImplCopyWith<$Res>
    implements $OtaStateCopyWith<$Res> {
  factory _$$OtaReadyStateImplCopyWith(
          _$OtaReadyStateImpl value, $Res Function(_$OtaReadyStateImpl) then) =
      __$$OtaReadyStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({OTAInfo info});

  @override
  $OTAInfoCopyWith<$Res> get info;
}

/// @nodoc
class __$$OtaReadyStateImplCopyWithImpl<$Res>
    extends _$OtaStateCopyWithImpl<$Res, _$OtaReadyStateImpl>
    implements _$$OtaReadyStateImplCopyWith<$Res> {
  __$$OtaReadyStateImplCopyWithImpl(
      _$OtaReadyStateImpl _value, $Res Function(_$OtaReadyStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
  }) {
    return _then(_$OtaReadyStateImpl(
      info: null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as OTAInfo,
    ));
  }
}

/// @nodoc

class _$OtaReadyStateImpl implements _OtaReadyState {
  const _$OtaReadyStateImpl({required this.info});

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
            other is _$OtaReadyStateImpl &&
            (identical(other.info, info) || other.info == info));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OtaReadyStateImplCopyWith<_$OtaReadyStateImpl> get copyWith =>
      __$$OtaReadyStateImplCopyWithImpl<_$OtaReadyStateImpl>(this, _$identity);

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
    TResult? Function(OTAInfo info)? initial,
    TResult? Function(OTAInfo info)? ready,
    TResult? Function(OTAInfo info)? progress,
    TResult? Function(OTAInfo info)? success,
    TResult? Function(OTAInfo info)? failure,
    TResult? Function(OTAInfo info)? exit,
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
    TResult? Function(_OtaInitialState value)? initial,
    TResult? Function(_OtaReadyState value)? ready,
    TResult? Function(_OtaProgressState value)? progress,
    TResult? Function(_OtaSuccessState value)? success,
    TResult? Function(_OtaFailureState value)? failure,
    TResult? Function(_OtaExitState value)? exit,
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
  const factory _OtaReadyState({required final OTAInfo info}) =
      _$OtaReadyStateImpl;

  @override
  OTAInfo get info;
  @override
  @JsonKey(ignore: true)
  _$$OtaReadyStateImplCopyWith<_$OtaReadyStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OtaProgressStateImplCopyWith<$Res>
    implements $OtaStateCopyWith<$Res> {
  factory _$$OtaProgressStateImplCopyWith(_$OtaProgressStateImpl value,
          $Res Function(_$OtaProgressStateImpl) then) =
      __$$OtaProgressStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({OTAInfo info});

  @override
  $OTAInfoCopyWith<$Res> get info;
}

/// @nodoc
class __$$OtaProgressStateImplCopyWithImpl<$Res>
    extends _$OtaStateCopyWithImpl<$Res, _$OtaProgressStateImpl>
    implements _$$OtaProgressStateImplCopyWith<$Res> {
  __$$OtaProgressStateImplCopyWithImpl(_$OtaProgressStateImpl _value,
      $Res Function(_$OtaProgressStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
  }) {
    return _then(_$OtaProgressStateImpl(
      info: null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as OTAInfo,
    ));
  }
}

/// @nodoc

class _$OtaProgressStateImpl implements _OtaProgressState {
  const _$OtaProgressStateImpl({required this.info});

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
            other is _$OtaProgressStateImpl &&
            (identical(other.info, info) || other.info == info));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OtaProgressStateImplCopyWith<_$OtaProgressStateImpl> get copyWith =>
      __$$OtaProgressStateImplCopyWithImpl<_$OtaProgressStateImpl>(
          this, _$identity);

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
    TResult? Function(OTAInfo info)? initial,
    TResult? Function(OTAInfo info)? ready,
    TResult? Function(OTAInfo info)? progress,
    TResult? Function(OTAInfo info)? success,
    TResult? Function(OTAInfo info)? failure,
    TResult? Function(OTAInfo info)? exit,
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
    TResult? Function(_OtaInitialState value)? initial,
    TResult? Function(_OtaReadyState value)? ready,
    TResult? Function(_OtaProgressState value)? progress,
    TResult? Function(_OtaSuccessState value)? success,
    TResult? Function(_OtaFailureState value)? failure,
    TResult? Function(_OtaExitState value)? exit,
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
  const factory _OtaProgressState({required final OTAInfo info}) =
      _$OtaProgressStateImpl;

  @override
  OTAInfo get info;
  @override
  @JsonKey(ignore: true)
  _$$OtaProgressStateImplCopyWith<_$OtaProgressStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OtaSuccessStateImplCopyWith<$Res>
    implements $OtaStateCopyWith<$Res> {
  factory _$$OtaSuccessStateImplCopyWith(_$OtaSuccessStateImpl value,
          $Res Function(_$OtaSuccessStateImpl) then) =
      __$$OtaSuccessStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({OTAInfo info});

  @override
  $OTAInfoCopyWith<$Res> get info;
}

/// @nodoc
class __$$OtaSuccessStateImplCopyWithImpl<$Res>
    extends _$OtaStateCopyWithImpl<$Res, _$OtaSuccessStateImpl>
    implements _$$OtaSuccessStateImplCopyWith<$Res> {
  __$$OtaSuccessStateImplCopyWithImpl(
      _$OtaSuccessStateImpl _value, $Res Function(_$OtaSuccessStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
  }) {
    return _then(_$OtaSuccessStateImpl(
      info: null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as OTAInfo,
    ));
  }
}

/// @nodoc

class _$OtaSuccessStateImpl implements _OtaSuccessState {
  const _$OtaSuccessStateImpl({required this.info});

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
            other is _$OtaSuccessStateImpl &&
            (identical(other.info, info) || other.info == info));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OtaSuccessStateImplCopyWith<_$OtaSuccessStateImpl> get copyWith =>
      __$$OtaSuccessStateImplCopyWithImpl<_$OtaSuccessStateImpl>(
          this, _$identity);

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
    TResult? Function(OTAInfo info)? initial,
    TResult? Function(OTAInfo info)? ready,
    TResult? Function(OTAInfo info)? progress,
    TResult? Function(OTAInfo info)? success,
    TResult? Function(OTAInfo info)? failure,
    TResult? Function(OTAInfo info)? exit,
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
    TResult? Function(_OtaInitialState value)? initial,
    TResult? Function(_OtaReadyState value)? ready,
    TResult? Function(_OtaProgressState value)? progress,
    TResult? Function(_OtaSuccessState value)? success,
    TResult? Function(_OtaFailureState value)? failure,
    TResult? Function(_OtaExitState value)? exit,
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
  const factory _OtaSuccessState({required final OTAInfo info}) =
      _$OtaSuccessStateImpl;

  @override
  OTAInfo get info;
  @override
  @JsonKey(ignore: true)
  _$$OtaSuccessStateImplCopyWith<_$OtaSuccessStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OtaFailureStateImplCopyWith<$Res>
    implements $OtaStateCopyWith<$Res> {
  factory _$$OtaFailureStateImplCopyWith(_$OtaFailureStateImpl value,
          $Res Function(_$OtaFailureStateImpl) then) =
      __$$OtaFailureStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({OTAInfo info});

  @override
  $OTAInfoCopyWith<$Res> get info;
}

/// @nodoc
class __$$OtaFailureStateImplCopyWithImpl<$Res>
    extends _$OtaStateCopyWithImpl<$Res, _$OtaFailureStateImpl>
    implements _$$OtaFailureStateImplCopyWith<$Res> {
  __$$OtaFailureStateImplCopyWithImpl(
      _$OtaFailureStateImpl _value, $Res Function(_$OtaFailureStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
  }) {
    return _then(_$OtaFailureStateImpl(
      info: null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as OTAInfo,
    ));
  }
}

/// @nodoc

class _$OtaFailureStateImpl implements _OtaFailureState {
  const _$OtaFailureStateImpl({required this.info});

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
            other is _$OtaFailureStateImpl &&
            (identical(other.info, info) || other.info == info));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OtaFailureStateImplCopyWith<_$OtaFailureStateImpl> get copyWith =>
      __$$OtaFailureStateImplCopyWithImpl<_$OtaFailureStateImpl>(
          this, _$identity);

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
    TResult? Function(OTAInfo info)? initial,
    TResult? Function(OTAInfo info)? ready,
    TResult? Function(OTAInfo info)? progress,
    TResult? Function(OTAInfo info)? success,
    TResult? Function(OTAInfo info)? failure,
    TResult? Function(OTAInfo info)? exit,
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
    TResult? Function(_OtaInitialState value)? initial,
    TResult? Function(_OtaReadyState value)? ready,
    TResult? Function(_OtaProgressState value)? progress,
    TResult? Function(_OtaSuccessState value)? success,
    TResult? Function(_OtaFailureState value)? failure,
    TResult? Function(_OtaExitState value)? exit,
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
  const factory _OtaFailureState({required final OTAInfo info}) =
      _$OtaFailureStateImpl;

  @override
  OTAInfo get info;
  @override
  @JsonKey(ignore: true)
  _$$OtaFailureStateImplCopyWith<_$OtaFailureStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OtaExitStateImplCopyWith<$Res>
    implements $OtaStateCopyWith<$Res> {
  factory _$$OtaExitStateImplCopyWith(
          _$OtaExitStateImpl value, $Res Function(_$OtaExitStateImpl) then) =
      __$$OtaExitStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({OTAInfo info});

  @override
  $OTAInfoCopyWith<$Res> get info;
}

/// @nodoc
class __$$OtaExitStateImplCopyWithImpl<$Res>
    extends _$OtaStateCopyWithImpl<$Res, _$OtaExitStateImpl>
    implements _$$OtaExitStateImplCopyWith<$Res> {
  __$$OtaExitStateImplCopyWithImpl(
      _$OtaExitStateImpl _value, $Res Function(_$OtaExitStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
  }) {
    return _then(_$OtaExitStateImpl(
      info: null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as OTAInfo,
    ));
  }
}

/// @nodoc

class _$OtaExitStateImpl implements _OtaExitState {
  const _$OtaExitStateImpl({required this.info});

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
            other is _$OtaExitStateImpl &&
            (identical(other.info, info) || other.info == info));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OtaExitStateImplCopyWith<_$OtaExitStateImpl> get copyWith =>
      __$$OtaExitStateImplCopyWithImpl<_$OtaExitStateImpl>(this, _$identity);

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
    TResult? Function(OTAInfo info)? initial,
    TResult? Function(OTAInfo info)? ready,
    TResult? Function(OTAInfo info)? progress,
    TResult? Function(OTAInfo info)? success,
    TResult? Function(OTAInfo info)? failure,
    TResult? Function(OTAInfo info)? exit,
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
    TResult? Function(_OtaInitialState value)? initial,
    TResult? Function(_OtaReadyState value)? ready,
    TResult? Function(_OtaProgressState value)? progress,
    TResult? Function(_OtaSuccessState value)? success,
    TResult? Function(_OtaFailureState value)? failure,
    TResult? Function(_OtaExitState value)? exit,
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
  const factory _OtaExitState({required final OTAInfo info}) =
      _$OtaExitStateImpl;

  @override
  OTAInfo get info;
  @override
  @JsonKey(ignore: true)
  _$$OtaExitStateImplCopyWith<_$OtaExitStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
