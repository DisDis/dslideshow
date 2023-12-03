// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'web_tab_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WebTabState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() uninitialized,
    required TResult Function(String errorMessage) error,
    required TResult Function(AppConfig config) initialized,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? uninitialized,
    TResult? Function(String errorMessage)? error,
    TResult? Function(AppConfig config)? initialized,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? uninitialized,
    TResult Function(String errorMessage)? error,
    TResult Function(AppConfig config)? initialized,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UnWebTabState value) uninitialized,
    required TResult Function(ErrorWebTabState value) error,
    required TResult Function(InWebTabState value) initialized,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UnWebTabState value)? uninitialized,
    TResult? Function(ErrorWebTabState value)? error,
    TResult? Function(InWebTabState value)? initialized,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UnWebTabState value)? uninitialized,
    TResult Function(ErrorWebTabState value)? error,
    TResult Function(InWebTabState value)? initialized,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebTabStateCopyWith<$Res> {
  factory $WebTabStateCopyWith(
          WebTabState value, $Res Function(WebTabState) then) =
      _$WebTabStateCopyWithImpl<$Res, WebTabState>;
}

/// @nodoc
class _$WebTabStateCopyWithImpl<$Res, $Val extends WebTabState>
    implements $WebTabStateCopyWith<$Res> {
  _$WebTabStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$UnWebTabStateImplCopyWith<$Res> {
  factory _$$UnWebTabStateImplCopyWith(
          _$UnWebTabStateImpl value, $Res Function(_$UnWebTabStateImpl) then) =
      __$$UnWebTabStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UnWebTabStateImplCopyWithImpl<$Res>
    extends _$WebTabStateCopyWithImpl<$Res, _$UnWebTabStateImpl>
    implements _$$UnWebTabStateImplCopyWith<$Res> {
  __$$UnWebTabStateImplCopyWithImpl(
      _$UnWebTabStateImpl _value, $Res Function(_$UnWebTabStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$UnWebTabStateImpl implements UnWebTabState {
  const _$UnWebTabStateImpl();

  @override
  String toString() {
    return 'WebTabState.uninitialized()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UnWebTabStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() uninitialized,
    required TResult Function(String errorMessage) error,
    required TResult Function(AppConfig config) initialized,
  }) {
    return uninitialized();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? uninitialized,
    TResult? Function(String errorMessage)? error,
    TResult? Function(AppConfig config)? initialized,
  }) {
    return uninitialized?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? uninitialized,
    TResult Function(String errorMessage)? error,
    TResult Function(AppConfig config)? initialized,
    required TResult orElse(),
  }) {
    if (uninitialized != null) {
      return uninitialized();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UnWebTabState value) uninitialized,
    required TResult Function(ErrorWebTabState value) error,
    required TResult Function(InWebTabState value) initialized,
  }) {
    return uninitialized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UnWebTabState value)? uninitialized,
    TResult? Function(ErrorWebTabState value)? error,
    TResult? Function(InWebTabState value)? initialized,
  }) {
    return uninitialized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UnWebTabState value)? uninitialized,
    TResult Function(ErrorWebTabState value)? error,
    TResult Function(InWebTabState value)? initialized,
    required TResult orElse(),
  }) {
    if (uninitialized != null) {
      return uninitialized(this);
    }
    return orElse();
  }
}

abstract class UnWebTabState implements WebTabState {
  const factory UnWebTabState() = _$UnWebTabStateImpl;
}

/// @nodoc
abstract class _$$ErrorWebTabStateImplCopyWith<$Res> {
  factory _$$ErrorWebTabStateImplCopyWith(_$ErrorWebTabStateImpl value,
          $Res Function(_$ErrorWebTabStateImpl) then) =
      __$$ErrorWebTabStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String errorMessage});
}

/// @nodoc
class __$$ErrorWebTabStateImplCopyWithImpl<$Res>
    extends _$WebTabStateCopyWithImpl<$Res, _$ErrorWebTabStateImpl>
    implements _$$ErrorWebTabStateImplCopyWith<$Res> {
  __$$ErrorWebTabStateImplCopyWithImpl(_$ErrorWebTabStateImpl _value,
      $Res Function(_$ErrorWebTabStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMessage = null,
  }) {
    return _then(_$ErrorWebTabStateImpl(
      null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorWebTabStateImpl implements ErrorWebTabState {
  const _$ErrorWebTabStateImpl(this.errorMessage);

  @override
  final String errorMessage;

  @override
  String toString() {
    return 'WebTabState.error(errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorWebTabStateImpl &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorWebTabStateImplCopyWith<_$ErrorWebTabStateImpl> get copyWith =>
      __$$ErrorWebTabStateImplCopyWithImpl<_$ErrorWebTabStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() uninitialized,
    required TResult Function(String errorMessage) error,
    required TResult Function(AppConfig config) initialized,
  }) {
    return error(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? uninitialized,
    TResult? Function(String errorMessage)? error,
    TResult? Function(AppConfig config)? initialized,
  }) {
    return error?.call(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? uninitialized,
    TResult Function(String errorMessage)? error,
    TResult Function(AppConfig config)? initialized,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UnWebTabState value) uninitialized,
    required TResult Function(ErrorWebTabState value) error,
    required TResult Function(InWebTabState value) initialized,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UnWebTabState value)? uninitialized,
    TResult? Function(ErrorWebTabState value)? error,
    TResult? Function(InWebTabState value)? initialized,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UnWebTabState value)? uninitialized,
    TResult Function(ErrorWebTabState value)? error,
    TResult Function(InWebTabState value)? initialized,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ErrorWebTabState implements WebTabState {
  const factory ErrorWebTabState(final String errorMessage) =
      _$ErrorWebTabStateImpl;

  String get errorMessage;
  @JsonKey(ignore: true)
  _$$ErrorWebTabStateImplCopyWith<_$ErrorWebTabStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InWebTabStateImplCopyWith<$Res> {
  factory _$$InWebTabStateImplCopyWith(
          _$InWebTabStateImpl value, $Res Function(_$InWebTabStateImpl) then) =
      __$$InWebTabStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppConfig config});
}

/// @nodoc
class __$$InWebTabStateImplCopyWithImpl<$Res>
    extends _$WebTabStateCopyWithImpl<$Res, _$InWebTabStateImpl>
    implements _$$InWebTabStateImplCopyWith<$Res> {
  __$$InWebTabStateImplCopyWithImpl(
      _$InWebTabStateImpl _value, $Res Function(_$InWebTabStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? config = null,
  }) {
    return _then(_$InWebTabStateImpl(
      null == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as AppConfig,
    ));
  }
}

/// @nodoc

class _$InWebTabStateImpl implements InWebTabState {
  const _$InWebTabStateImpl(this.config);

  @override
  final AppConfig config;

  @override
  String toString() {
    return 'WebTabState.initialized(config: $config)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InWebTabStateImpl &&
            (identical(other.config, config) || other.config == config));
  }

  @override
  int get hashCode => Object.hash(runtimeType, config);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InWebTabStateImplCopyWith<_$InWebTabStateImpl> get copyWith =>
      __$$InWebTabStateImplCopyWithImpl<_$InWebTabStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() uninitialized,
    required TResult Function(String errorMessage) error,
    required TResult Function(AppConfig config) initialized,
  }) {
    return initialized(config);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? uninitialized,
    TResult? Function(String errorMessage)? error,
    TResult? Function(AppConfig config)? initialized,
  }) {
    return initialized?.call(config);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? uninitialized,
    TResult Function(String errorMessage)? error,
    TResult Function(AppConfig config)? initialized,
    required TResult orElse(),
  }) {
    if (initialized != null) {
      return initialized(config);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UnWebTabState value) uninitialized,
    required TResult Function(ErrorWebTabState value) error,
    required TResult Function(InWebTabState value) initialized,
  }) {
    return initialized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UnWebTabState value)? uninitialized,
    TResult? Function(ErrorWebTabState value)? error,
    TResult? Function(InWebTabState value)? initialized,
  }) {
    return initialized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UnWebTabState value)? uninitialized,
    TResult Function(ErrorWebTabState value)? error,
    TResult Function(InWebTabState value)? initialized,
    required TResult orElse(),
  }) {
    if (initialized != null) {
      return initialized(this);
    }
    return orElse();
  }
}

abstract class InWebTabState implements WebTabState {
  const factory InWebTabState(final AppConfig config) = _$InWebTabStateImpl;

  AppConfig get config;
  @JsonKey(ignore: true)
  _$$InWebTabStateImplCopyWith<_$InWebTabStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
