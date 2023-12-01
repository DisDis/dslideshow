// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LoginEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String username) changedUsename,
    required TResult Function(String password) changedPassword,
    required TResult Function(String connectUri) changedConnectUri,
    required TResult Function() submit,
    required TResult Function() autoChangedConnectUri,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String username)? changedUsename,
    TResult? Function(String password)? changedPassword,
    TResult? Function(String connectUri)? changedConnectUri,
    TResult? Function()? submit,
    TResult? Function()? autoChangedConnectUri,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String username)? changedUsename,
    TResult Function(String password)? changedPassword,
    TResult Function(String connectUri)? changedConnectUri,
    TResult Function()? submit,
    TResult Function()? autoChangedConnectUri,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginUsernameChanged value) changedUsename,
    required TResult Function(LoginPasswordChanged value) changedPassword,
    required TResult Function(LoginConnectUriChanged value) changedConnectUri,
    required TResult Function(LoginSubmitted value) submit,
    required TResult Function(LoginConnectUriAutoChanged value)
        autoChangedConnectUri,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginUsernameChanged value)? changedUsename,
    TResult? Function(LoginPasswordChanged value)? changedPassword,
    TResult? Function(LoginConnectUriChanged value)? changedConnectUri,
    TResult? Function(LoginSubmitted value)? submit,
    TResult? Function(LoginConnectUriAutoChanged value)? autoChangedConnectUri,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginUsernameChanged value)? changedUsename,
    TResult Function(LoginPasswordChanged value)? changedPassword,
    TResult Function(LoginConnectUriChanged value)? changedConnectUri,
    TResult Function(LoginSubmitted value)? submit,
    TResult Function(LoginConnectUriAutoChanged value)? autoChangedConnectUri,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginEventCopyWith<$Res> {
  factory $LoginEventCopyWith(
          LoginEvent value, $Res Function(LoginEvent) then) =
      _$LoginEventCopyWithImpl<$Res, LoginEvent>;
}

/// @nodoc
class _$LoginEventCopyWithImpl<$Res, $Val extends LoginEvent>
    implements $LoginEventCopyWith<$Res> {
  _$LoginEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$LoginUsernameChangedImplCopyWith<$Res> {
  factory _$$LoginUsernameChangedImplCopyWith(_$LoginUsernameChangedImpl value,
          $Res Function(_$LoginUsernameChangedImpl) then) =
      __$$LoginUsernameChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String username});
}

/// @nodoc
class __$$LoginUsernameChangedImplCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$LoginUsernameChangedImpl>
    implements _$$LoginUsernameChangedImplCopyWith<$Res> {
  __$$LoginUsernameChangedImplCopyWithImpl(_$LoginUsernameChangedImpl _value,
      $Res Function(_$LoginUsernameChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
  }) {
    return _then(_$LoginUsernameChangedImpl(
      null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoginUsernameChangedImpl implements LoginUsernameChanged {
  const _$LoginUsernameChangedImpl(this.username);

  @override
  final String username;

  @override
  String toString() {
    return 'LoginEvent.changedUsename(username: $username)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginUsernameChangedImpl &&
            (identical(other.username, username) ||
                other.username == username));
  }

  @override
  int get hashCode => Object.hash(runtimeType, username);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginUsernameChangedImplCopyWith<_$LoginUsernameChangedImpl>
      get copyWith =>
          __$$LoginUsernameChangedImplCopyWithImpl<_$LoginUsernameChangedImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String username) changedUsename,
    required TResult Function(String password) changedPassword,
    required TResult Function(String connectUri) changedConnectUri,
    required TResult Function() submit,
    required TResult Function() autoChangedConnectUri,
  }) {
    return changedUsename(username);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String username)? changedUsename,
    TResult? Function(String password)? changedPassword,
    TResult? Function(String connectUri)? changedConnectUri,
    TResult? Function()? submit,
    TResult? Function()? autoChangedConnectUri,
  }) {
    return changedUsename?.call(username);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String username)? changedUsename,
    TResult Function(String password)? changedPassword,
    TResult Function(String connectUri)? changedConnectUri,
    TResult Function()? submit,
    TResult Function()? autoChangedConnectUri,
    required TResult orElse(),
  }) {
    if (changedUsename != null) {
      return changedUsename(username);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginUsernameChanged value) changedUsename,
    required TResult Function(LoginPasswordChanged value) changedPassword,
    required TResult Function(LoginConnectUriChanged value) changedConnectUri,
    required TResult Function(LoginSubmitted value) submit,
    required TResult Function(LoginConnectUriAutoChanged value)
        autoChangedConnectUri,
  }) {
    return changedUsename(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginUsernameChanged value)? changedUsename,
    TResult? Function(LoginPasswordChanged value)? changedPassword,
    TResult? Function(LoginConnectUriChanged value)? changedConnectUri,
    TResult? Function(LoginSubmitted value)? submit,
    TResult? Function(LoginConnectUriAutoChanged value)? autoChangedConnectUri,
  }) {
    return changedUsename?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginUsernameChanged value)? changedUsename,
    TResult Function(LoginPasswordChanged value)? changedPassword,
    TResult Function(LoginConnectUriChanged value)? changedConnectUri,
    TResult Function(LoginSubmitted value)? submit,
    TResult Function(LoginConnectUriAutoChanged value)? autoChangedConnectUri,
    required TResult orElse(),
  }) {
    if (changedUsename != null) {
      return changedUsename(this);
    }
    return orElse();
  }
}

abstract class LoginUsernameChanged implements LoginEvent {
  const factory LoginUsernameChanged(final String username) =
      _$LoginUsernameChangedImpl;

  String get username;
  @JsonKey(ignore: true)
  _$$LoginUsernameChangedImplCopyWith<_$LoginUsernameChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoginPasswordChangedImplCopyWith<$Res> {
  factory _$$LoginPasswordChangedImplCopyWith(_$LoginPasswordChangedImpl value,
          $Res Function(_$LoginPasswordChangedImpl) then) =
      __$$LoginPasswordChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String password});
}

/// @nodoc
class __$$LoginPasswordChangedImplCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$LoginPasswordChangedImpl>
    implements _$$LoginPasswordChangedImplCopyWith<$Res> {
  __$$LoginPasswordChangedImplCopyWithImpl(_$LoginPasswordChangedImpl _value,
      $Res Function(_$LoginPasswordChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? password = null,
  }) {
    return _then(_$LoginPasswordChangedImpl(
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoginPasswordChangedImpl implements LoginPasswordChanged {
  const _$LoginPasswordChangedImpl(this.password);

  @override
  final String password;

  @override
  String toString() {
    return 'LoginEvent.changedPassword(password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginPasswordChangedImpl &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginPasswordChangedImplCopyWith<_$LoginPasswordChangedImpl>
      get copyWith =>
          __$$LoginPasswordChangedImplCopyWithImpl<_$LoginPasswordChangedImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String username) changedUsename,
    required TResult Function(String password) changedPassword,
    required TResult Function(String connectUri) changedConnectUri,
    required TResult Function() submit,
    required TResult Function() autoChangedConnectUri,
  }) {
    return changedPassword(password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String username)? changedUsename,
    TResult? Function(String password)? changedPassword,
    TResult? Function(String connectUri)? changedConnectUri,
    TResult? Function()? submit,
    TResult? Function()? autoChangedConnectUri,
  }) {
    return changedPassword?.call(password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String username)? changedUsename,
    TResult Function(String password)? changedPassword,
    TResult Function(String connectUri)? changedConnectUri,
    TResult Function()? submit,
    TResult Function()? autoChangedConnectUri,
    required TResult orElse(),
  }) {
    if (changedPassword != null) {
      return changedPassword(password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginUsernameChanged value) changedUsename,
    required TResult Function(LoginPasswordChanged value) changedPassword,
    required TResult Function(LoginConnectUriChanged value) changedConnectUri,
    required TResult Function(LoginSubmitted value) submit,
    required TResult Function(LoginConnectUriAutoChanged value)
        autoChangedConnectUri,
  }) {
    return changedPassword(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginUsernameChanged value)? changedUsename,
    TResult? Function(LoginPasswordChanged value)? changedPassword,
    TResult? Function(LoginConnectUriChanged value)? changedConnectUri,
    TResult? Function(LoginSubmitted value)? submit,
    TResult? Function(LoginConnectUriAutoChanged value)? autoChangedConnectUri,
  }) {
    return changedPassword?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginUsernameChanged value)? changedUsename,
    TResult Function(LoginPasswordChanged value)? changedPassword,
    TResult Function(LoginConnectUriChanged value)? changedConnectUri,
    TResult Function(LoginSubmitted value)? submit,
    TResult Function(LoginConnectUriAutoChanged value)? autoChangedConnectUri,
    required TResult orElse(),
  }) {
    if (changedPassword != null) {
      return changedPassword(this);
    }
    return orElse();
  }
}

abstract class LoginPasswordChanged implements LoginEvent {
  const factory LoginPasswordChanged(final String password) =
      _$LoginPasswordChangedImpl;

  String get password;
  @JsonKey(ignore: true)
  _$$LoginPasswordChangedImplCopyWith<_$LoginPasswordChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoginConnectUriChangedImplCopyWith<$Res> {
  factory _$$LoginConnectUriChangedImplCopyWith(
          _$LoginConnectUriChangedImpl value,
          $Res Function(_$LoginConnectUriChangedImpl) then) =
      __$$LoginConnectUriChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String connectUri});
}

/// @nodoc
class __$$LoginConnectUriChangedImplCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$LoginConnectUriChangedImpl>
    implements _$$LoginConnectUriChangedImplCopyWith<$Res> {
  __$$LoginConnectUriChangedImplCopyWithImpl(
      _$LoginConnectUriChangedImpl _value,
      $Res Function(_$LoginConnectUriChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? connectUri = null,
  }) {
    return _then(_$LoginConnectUriChangedImpl(
      null == connectUri
          ? _value.connectUri
          : connectUri // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoginConnectUriChangedImpl implements LoginConnectUriChanged {
  const _$LoginConnectUriChangedImpl(this.connectUri);

  @override
  final String connectUri;

  @override
  String toString() {
    return 'LoginEvent.changedConnectUri(connectUri: $connectUri)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginConnectUriChangedImpl &&
            (identical(other.connectUri, connectUri) ||
                other.connectUri == connectUri));
  }

  @override
  int get hashCode => Object.hash(runtimeType, connectUri);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginConnectUriChangedImplCopyWith<_$LoginConnectUriChangedImpl>
      get copyWith => __$$LoginConnectUriChangedImplCopyWithImpl<
          _$LoginConnectUriChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String username) changedUsename,
    required TResult Function(String password) changedPassword,
    required TResult Function(String connectUri) changedConnectUri,
    required TResult Function() submit,
    required TResult Function() autoChangedConnectUri,
  }) {
    return changedConnectUri(connectUri);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String username)? changedUsename,
    TResult? Function(String password)? changedPassword,
    TResult? Function(String connectUri)? changedConnectUri,
    TResult? Function()? submit,
    TResult? Function()? autoChangedConnectUri,
  }) {
    return changedConnectUri?.call(connectUri);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String username)? changedUsename,
    TResult Function(String password)? changedPassword,
    TResult Function(String connectUri)? changedConnectUri,
    TResult Function()? submit,
    TResult Function()? autoChangedConnectUri,
    required TResult orElse(),
  }) {
    if (changedConnectUri != null) {
      return changedConnectUri(connectUri);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginUsernameChanged value) changedUsename,
    required TResult Function(LoginPasswordChanged value) changedPassword,
    required TResult Function(LoginConnectUriChanged value) changedConnectUri,
    required TResult Function(LoginSubmitted value) submit,
    required TResult Function(LoginConnectUriAutoChanged value)
        autoChangedConnectUri,
  }) {
    return changedConnectUri(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginUsernameChanged value)? changedUsename,
    TResult? Function(LoginPasswordChanged value)? changedPassword,
    TResult? Function(LoginConnectUriChanged value)? changedConnectUri,
    TResult? Function(LoginSubmitted value)? submit,
    TResult? Function(LoginConnectUriAutoChanged value)? autoChangedConnectUri,
  }) {
    return changedConnectUri?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginUsernameChanged value)? changedUsename,
    TResult Function(LoginPasswordChanged value)? changedPassword,
    TResult Function(LoginConnectUriChanged value)? changedConnectUri,
    TResult Function(LoginSubmitted value)? submit,
    TResult Function(LoginConnectUriAutoChanged value)? autoChangedConnectUri,
    required TResult orElse(),
  }) {
    if (changedConnectUri != null) {
      return changedConnectUri(this);
    }
    return orElse();
  }
}

abstract class LoginConnectUriChanged implements LoginEvent {
  const factory LoginConnectUriChanged(final String connectUri) =
      _$LoginConnectUriChangedImpl;

  String get connectUri;
  @JsonKey(ignore: true)
  _$$LoginConnectUriChangedImplCopyWith<_$LoginConnectUriChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoginSubmittedImplCopyWith<$Res> {
  factory _$$LoginSubmittedImplCopyWith(_$LoginSubmittedImpl value,
          $Res Function(_$LoginSubmittedImpl) then) =
      __$$LoginSubmittedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoginSubmittedImplCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$LoginSubmittedImpl>
    implements _$$LoginSubmittedImplCopyWith<$Res> {
  __$$LoginSubmittedImplCopyWithImpl(
      _$LoginSubmittedImpl _value, $Res Function(_$LoginSubmittedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoginSubmittedImpl implements LoginSubmitted {
  const _$LoginSubmittedImpl();

  @override
  String toString() {
    return 'LoginEvent.submit()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoginSubmittedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String username) changedUsename,
    required TResult Function(String password) changedPassword,
    required TResult Function(String connectUri) changedConnectUri,
    required TResult Function() submit,
    required TResult Function() autoChangedConnectUri,
  }) {
    return submit();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String username)? changedUsename,
    TResult? Function(String password)? changedPassword,
    TResult? Function(String connectUri)? changedConnectUri,
    TResult? Function()? submit,
    TResult? Function()? autoChangedConnectUri,
  }) {
    return submit?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String username)? changedUsename,
    TResult Function(String password)? changedPassword,
    TResult Function(String connectUri)? changedConnectUri,
    TResult Function()? submit,
    TResult Function()? autoChangedConnectUri,
    required TResult orElse(),
  }) {
    if (submit != null) {
      return submit();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginUsernameChanged value) changedUsename,
    required TResult Function(LoginPasswordChanged value) changedPassword,
    required TResult Function(LoginConnectUriChanged value) changedConnectUri,
    required TResult Function(LoginSubmitted value) submit,
    required TResult Function(LoginConnectUriAutoChanged value)
        autoChangedConnectUri,
  }) {
    return submit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginUsernameChanged value)? changedUsename,
    TResult? Function(LoginPasswordChanged value)? changedPassword,
    TResult? Function(LoginConnectUriChanged value)? changedConnectUri,
    TResult? Function(LoginSubmitted value)? submit,
    TResult? Function(LoginConnectUriAutoChanged value)? autoChangedConnectUri,
  }) {
    return submit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginUsernameChanged value)? changedUsename,
    TResult Function(LoginPasswordChanged value)? changedPassword,
    TResult Function(LoginConnectUriChanged value)? changedConnectUri,
    TResult Function(LoginSubmitted value)? submit,
    TResult Function(LoginConnectUriAutoChanged value)? autoChangedConnectUri,
    required TResult orElse(),
  }) {
    if (submit != null) {
      return submit(this);
    }
    return orElse();
  }
}

abstract class LoginSubmitted implements LoginEvent {
  const factory LoginSubmitted() = _$LoginSubmittedImpl;
}

/// @nodoc
abstract class _$$LoginConnectUriAutoChangedImplCopyWith<$Res> {
  factory _$$LoginConnectUriAutoChangedImplCopyWith(
          _$LoginConnectUriAutoChangedImpl value,
          $Res Function(_$LoginConnectUriAutoChangedImpl) then) =
      __$$LoginConnectUriAutoChangedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoginConnectUriAutoChangedImplCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$LoginConnectUriAutoChangedImpl>
    implements _$$LoginConnectUriAutoChangedImplCopyWith<$Res> {
  __$$LoginConnectUriAutoChangedImplCopyWithImpl(
      _$LoginConnectUriAutoChangedImpl _value,
      $Res Function(_$LoginConnectUriAutoChangedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoginConnectUriAutoChangedImpl implements LoginConnectUriAutoChanged {
  const _$LoginConnectUriAutoChangedImpl();

  @override
  String toString() {
    return 'LoginEvent.autoChangedConnectUri()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginConnectUriAutoChangedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String username) changedUsename,
    required TResult Function(String password) changedPassword,
    required TResult Function(String connectUri) changedConnectUri,
    required TResult Function() submit,
    required TResult Function() autoChangedConnectUri,
  }) {
    return autoChangedConnectUri();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String username)? changedUsename,
    TResult? Function(String password)? changedPassword,
    TResult? Function(String connectUri)? changedConnectUri,
    TResult? Function()? submit,
    TResult? Function()? autoChangedConnectUri,
  }) {
    return autoChangedConnectUri?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String username)? changedUsename,
    TResult Function(String password)? changedPassword,
    TResult Function(String connectUri)? changedConnectUri,
    TResult Function()? submit,
    TResult Function()? autoChangedConnectUri,
    required TResult orElse(),
  }) {
    if (autoChangedConnectUri != null) {
      return autoChangedConnectUri();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginUsernameChanged value) changedUsename,
    required TResult Function(LoginPasswordChanged value) changedPassword,
    required TResult Function(LoginConnectUriChanged value) changedConnectUri,
    required TResult Function(LoginSubmitted value) submit,
    required TResult Function(LoginConnectUriAutoChanged value)
        autoChangedConnectUri,
  }) {
    return autoChangedConnectUri(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginUsernameChanged value)? changedUsename,
    TResult? Function(LoginPasswordChanged value)? changedPassword,
    TResult? Function(LoginConnectUriChanged value)? changedConnectUri,
    TResult? Function(LoginSubmitted value)? submit,
    TResult? Function(LoginConnectUriAutoChanged value)? autoChangedConnectUri,
  }) {
    return autoChangedConnectUri?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginUsernameChanged value)? changedUsename,
    TResult Function(LoginPasswordChanged value)? changedPassword,
    TResult Function(LoginConnectUriChanged value)? changedConnectUri,
    TResult Function(LoginSubmitted value)? submit,
    TResult Function(LoginConnectUriAutoChanged value)? autoChangedConnectUri,
    required TResult orElse(),
  }) {
    if (autoChangedConnectUri != null) {
      return autoChangedConnectUri(this);
    }
    return orElse();
  }
}

abstract class LoginConnectUriAutoChanged implements LoginEvent {
  const factory LoginConnectUriAutoChanged() = _$LoginConnectUriAutoChangedImpl;
}

/// @nodoc
mixin _$LoginState {
  FormzSubmissionStatus get status => throw _privateConstructorUsedError;
  Username get username => throw _privateConstructorUsedError;
  Password get password => throw _privateConstructorUsedError;
  ConnectUri get connectUri => throw _privateConstructorUsedError;
  bool get isValid => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginStateCopyWith<LoginState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginStateCopyWith<$Res> {
  factory $LoginStateCopyWith(
          LoginState value, $Res Function(LoginState) then) =
      _$LoginStateCopyWithImpl<$Res, LoginState>;
  @useResult
  $Res call(
      {FormzSubmissionStatus status,
      Username username,
      Password password,
      ConnectUri connectUri,
      bool isValid});
}

/// @nodoc
class _$LoginStateCopyWithImpl<$Res, $Val extends LoginState>
    implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? username = null,
    Object? password = null,
    Object? connectUri = null,
    Object? isValid = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FormzSubmissionStatus,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as Username,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as Password,
      connectUri: null == connectUri
          ? _value.connectUri
          : connectUri // ignore: cast_nullable_to_non_nullable
              as ConnectUri,
      isValid: null == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginStateImplCopyWith<$Res>
    implements $LoginStateCopyWith<$Res> {
  factory _$$LoginStateImplCopyWith(
          _$LoginStateImpl value, $Res Function(_$LoginStateImpl) then) =
      __$$LoginStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {FormzSubmissionStatus status,
      Username username,
      Password password,
      ConnectUri connectUri,
      bool isValid});
}

/// @nodoc
class __$$LoginStateImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$LoginStateImpl>
    implements _$$LoginStateImplCopyWith<$Res> {
  __$$LoginStateImplCopyWithImpl(
      _$LoginStateImpl _value, $Res Function(_$LoginStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? username = null,
    Object? password = null,
    Object? connectUri = null,
    Object? isValid = null,
  }) {
    return _then(_$LoginStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FormzSubmissionStatus,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as Username,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as Password,
      connectUri: null == connectUri
          ? _value.connectUri
          : connectUri // ignore: cast_nullable_to_non_nullable
              as ConnectUri,
      isValid: null == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$LoginStateImpl implements _LoginState {
  const _$LoginStateImpl(
      {this.status = FormzSubmissionStatus.initial,
      this.username = const Username.pure(defaultValue: 'admin'),
      this.password = const Password.pure(defaultValue: '123'),
      this.connectUri =
          const ConnectUri.pure(defaultValue: 'ws://192.168.50.175:8080/ws'),
      this.isValid = false});

  @override
  @JsonKey()
  final FormzSubmissionStatus status;
  @override
  @JsonKey()
  final Username username;
  @override
  @JsonKey()
  final Password password;
  @override
  @JsonKey()
  final ConnectUri connectUri;
  @override
  @JsonKey()
  final bool isValid;

  @override
  String toString() {
    return 'LoginState(status: $status, username: $username, password: $password, connectUri: $connectUri, isValid: $isValid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.connectUri, connectUri) ||
                other.connectUri == connectUri) &&
            (identical(other.isValid, isValid) || other.isValid == isValid));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, status, username, password, connectUri, isValid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginStateImplCopyWith<_$LoginStateImpl> get copyWith =>
      __$$LoginStateImplCopyWithImpl<_$LoginStateImpl>(this, _$identity);
}

abstract class _LoginState implements LoginState {
  const factory _LoginState(
      {final FormzSubmissionStatus status,
      final Username username,
      final Password password,
      final ConnectUri connectUri,
      final bool isValid}) = _$LoginStateImpl;

  @override
  FormzSubmissionStatus get status;
  @override
  Username get username;
  @override
  Password get password;
  @override
  ConnectUri get connectUri;
  @override
  bool get isValid;
  @override
  @JsonKey(ignore: true)
  _$$LoginStateImplCopyWith<_$LoginStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
