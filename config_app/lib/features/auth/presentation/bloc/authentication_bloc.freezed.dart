// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authentication_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthenticationEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthenticationStatus status) changeStatus,
    required TResult Function() logout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationStatus status)? changeStatus,
    TResult? Function()? logout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthenticationStatus status)? changeStatus,
    TResult Function()? logout,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthenticationStatusChanged value) changeStatus,
    required TResult Function(AuthenticationLogoutRequested value) logout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthenticationStatusChanged value)? changeStatus,
    TResult? Function(AuthenticationLogoutRequested value)? logout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthenticationStatusChanged value)? changeStatus,
    TResult Function(AuthenticationLogoutRequested value)? logout,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticationEventCopyWith<$Res> {
  factory $AuthenticationEventCopyWith(
          AuthenticationEvent value, $Res Function(AuthenticationEvent) then) =
      _$AuthenticationEventCopyWithImpl<$Res, AuthenticationEvent>;
}

/// @nodoc
class _$AuthenticationEventCopyWithImpl<$Res, $Val extends AuthenticationEvent>
    implements $AuthenticationEventCopyWith<$Res> {
  _$AuthenticationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AuthenticationStatusChangedImplCopyWith<$Res> {
  factory _$$AuthenticationStatusChangedImplCopyWith(
          _$AuthenticationStatusChangedImpl value,
          $Res Function(_$AuthenticationStatusChangedImpl) then) =
      __$$AuthenticationStatusChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AuthenticationStatus status});
}

/// @nodoc
class __$$AuthenticationStatusChangedImplCopyWithImpl<$Res>
    extends _$AuthenticationEventCopyWithImpl<$Res,
        _$AuthenticationStatusChangedImpl>
    implements _$$AuthenticationStatusChangedImplCopyWith<$Res> {
  __$$AuthenticationStatusChangedImplCopyWithImpl(
      _$AuthenticationStatusChangedImpl _value,
      $Res Function(_$AuthenticationStatusChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_$AuthenticationStatusChangedImpl(
      null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AuthenticationStatus,
    ));
  }
}

/// @nodoc

class _$AuthenticationStatusChangedImpl
    implements _AuthenticationStatusChanged {
  const _$AuthenticationStatusChangedImpl(this.status);

  @override
  final AuthenticationStatus status;

  @override
  String toString() {
    return 'AuthenticationEvent.changeStatus(status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationStatusChangedImpl &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticationStatusChangedImplCopyWith<_$AuthenticationStatusChangedImpl>
      get copyWith => __$$AuthenticationStatusChangedImplCopyWithImpl<
          _$AuthenticationStatusChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthenticationStatus status) changeStatus,
    required TResult Function() logout,
  }) {
    return changeStatus(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationStatus status)? changeStatus,
    TResult? Function()? logout,
  }) {
    return changeStatus?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthenticationStatus status)? changeStatus,
    TResult Function()? logout,
    required TResult orElse(),
  }) {
    if (changeStatus != null) {
      return changeStatus(status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthenticationStatusChanged value) changeStatus,
    required TResult Function(AuthenticationLogoutRequested value) logout,
  }) {
    return changeStatus(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthenticationStatusChanged value)? changeStatus,
    TResult? Function(AuthenticationLogoutRequested value)? logout,
  }) {
    return changeStatus?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthenticationStatusChanged value)? changeStatus,
    TResult Function(AuthenticationLogoutRequested value)? logout,
    required TResult orElse(),
  }) {
    if (changeStatus != null) {
      return changeStatus(this);
    }
    return orElse();
  }
}

abstract class _AuthenticationStatusChanged implements AuthenticationEvent {
  const factory _AuthenticationStatusChanged(
      final AuthenticationStatus status) = _$AuthenticationStatusChangedImpl;

  AuthenticationStatus get status;
  @JsonKey(ignore: true)
  _$$AuthenticationStatusChangedImplCopyWith<_$AuthenticationStatusChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthenticationLogoutRequestedImplCopyWith<$Res> {
  factory _$$AuthenticationLogoutRequestedImplCopyWith(
          _$AuthenticationLogoutRequestedImpl value,
          $Res Function(_$AuthenticationLogoutRequestedImpl) then) =
      __$$AuthenticationLogoutRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticationLogoutRequestedImplCopyWithImpl<$Res>
    extends _$AuthenticationEventCopyWithImpl<$Res,
        _$AuthenticationLogoutRequestedImpl>
    implements _$$AuthenticationLogoutRequestedImplCopyWith<$Res> {
  __$$AuthenticationLogoutRequestedImplCopyWithImpl(
      _$AuthenticationLogoutRequestedImpl _value,
      $Res Function(_$AuthenticationLogoutRequestedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthenticationLogoutRequestedImpl
    implements AuthenticationLogoutRequested {
  const _$AuthenticationLogoutRequestedImpl();

  @override
  String toString() {
    return 'AuthenticationEvent.logout()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationLogoutRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthenticationStatus status) changeStatus,
    required TResult Function() logout,
  }) {
    return logout();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationStatus status)? changeStatus,
    TResult? Function()? logout,
  }) {
    return logout?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthenticationStatus status)? changeStatus,
    TResult Function()? logout,
    required TResult orElse(),
  }) {
    if (logout != null) {
      return logout();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthenticationStatusChanged value) changeStatus,
    required TResult Function(AuthenticationLogoutRequested value) logout,
  }) {
    return logout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthenticationStatusChanged value)? changeStatus,
    TResult? Function(AuthenticationLogoutRequested value)? logout,
  }) {
    return logout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthenticationStatusChanged value)? changeStatus,
    TResult Function(AuthenticationLogoutRequested value)? logout,
    required TResult orElse(),
  }) {
    if (logout != null) {
      return logout(this);
    }
    return orElse();
  }
}

abstract class AuthenticationLogoutRequested implements AuthenticationEvent {
  const factory AuthenticationLogoutRequested() =
      _$AuthenticationLogoutRequestedImpl;
}

/// @nodoc
mixin _$AuthenticationState {
  User get user => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthenticationStatus status, User user) unknown,
    required TResult Function(User user, AuthenticationStatus state)
        authenticated,
    required TResult Function(AuthenticationStatus status, User user)
        unauthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationStatus status, User user)? unknown,
    TResult? Function(User user, AuthenticationStatus state)? authenticated,
    TResult? Function(AuthenticationStatus status, User user)? unauthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthenticationStatus status, User user)? unknown,
    TResult Function(User user, AuthenticationStatus state)? authenticated,
    TResult Function(AuthenticationStatus status, User user)? unauthenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_unknown value) unknown,
    required TResult Function(AuthenticationAuthenticatedState value)
        authenticated,
    required TResult Function(_unauthenticated value) unauthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_unknown value)? unknown,
    TResult? Function(AuthenticationAuthenticatedState value)? authenticated,
    TResult? Function(_unauthenticated value)? unauthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_unknown value)? unknown,
    TResult Function(AuthenticationAuthenticatedState value)? authenticated,
    TResult Function(_unauthenticated value)? unauthenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc

class _$unknownImpl implements _unknown {
  const _$unknownImpl(
      [this.status = AuthenticationStatus.unknown, this.user = User.empty]);

  @override
  @JsonKey()
  final AuthenticationStatus status;
  @override
  @JsonKey()
  final User user;

  @override
  String toString() {
    return 'AuthenticationState.unknown(status: $status, user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$unknownImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, user);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthenticationStatus status, User user) unknown,
    required TResult Function(User user, AuthenticationStatus state)
        authenticated,
    required TResult Function(AuthenticationStatus status, User user)
        unauthenticated,
  }) {
    return unknown(status, user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationStatus status, User user)? unknown,
    TResult? Function(User user, AuthenticationStatus state)? authenticated,
    TResult? Function(AuthenticationStatus status, User user)? unauthenticated,
  }) {
    return unknown?.call(status, user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthenticationStatus status, User user)? unknown,
    TResult Function(User user, AuthenticationStatus state)? authenticated,
    TResult Function(AuthenticationStatus status, User user)? unauthenticated,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(status, user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_unknown value) unknown,
    required TResult Function(AuthenticationAuthenticatedState value)
        authenticated,
    required TResult Function(_unauthenticated value) unauthenticated,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_unknown value)? unknown,
    TResult? Function(AuthenticationAuthenticatedState value)? authenticated,
    TResult? Function(_unauthenticated value)? unauthenticated,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_unknown value)? unknown,
    TResult Function(AuthenticationAuthenticatedState value)? authenticated,
    TResult Function(_unauthenticated value)? unauthenticated,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class _unknown implements AuthenticationState {
  const factory _unknown([final AuthenticationStatus status, final User user]) =
      _$unknownImpl;

  AuthenticationStatus get status;
  @override
  User get user;
}

/// @nodoc

class _$AuthenticationAuthenticatedStateImpl
    implements AuthenticationAuthenticatedState {
  const _$AuthenticationAuthenticatedStateImpl(this.user,
      [this.state = AuthenticationStatus.authenticated]);

  @override
  final User user;
  @override
  @JsonKey()
  final AuthenticationStatus state;

  @override
  String toString() {
    return 'AuthenticationState.authenticated(user: $user, state: $state)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationAuthenticatedStateImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user, state);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthenticationStatus status, User user) unknown,
    required TResult Function(User user, AuthenticationStatus state)
        authenticated,
    required TResult Function(AuthenticationStatus status, User user)
        unauthenticated,
  }) {
    return authenticated(user, state);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationStatus status, User user)? unknown,
    TResult? Function(User user, AuthenticationStatus state)? authenticated,
    TResult? Function(AuthenticationStatus status, User user)? unauthenticated,
  }) {
    return authenticated?.call(user, state);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthenticationStatus status, User user)? unknown,
    TResult Function(User user, AuthenticationStatus state)? authenticated,
    TResult Function(AuthenticationStatus status, User user)? unauthenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(user, state);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_unknown value) unknown,
    required TResult Function(AuthenticationAuthenticatedState value)
        authenticated,
    required TResult Function(_unauthenticated value) unauthenticated,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_unknown value)? unknown,
    TResult? Function(AuthenticationAuthenticatedState value)? authenticated,
    TResult? Function(_unauthenticated value)? unauthenticated,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_unknown value)? unknown,
    TResult Function(AuthenticationAuthenticatedState value)? authenticated,
    TResult Function(_unauthenticated value)? unauthenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class AuthenticationAuthenticatedState implements AuthenticationState {
  const factory AuthenticationAuthenticatedState(final User user,
          [final AuthenticationStatus state]) =
      _$AuthenticationAuthenticatedStateImpl;

  @override
  User get user;
  AuthenticationStatus get state;
}

/// @nodoc

class _$unauthenticatedImpl implements _unauthenticated {
  const _$unauthenticatedImpl(
      [this.status = AuthenticationStatus.unauthenticated,
      this.user = User.empty]);

  @override
  @JsonKey()
  final AuthenticationStatus status;
  @override
  @JsonKey()
  final User user;

  @override
  String toString() {
    return 'AuthenticationState.unauthenticated(status: $status, user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$unauthenticatedImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, user);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthenticationStatus status, User user) unknown,
    required TResult Function(User user, AuthenticationStatus state)
        authenticated,
    required TResult Function(AuthenticationStatus status, User user)
        unauthenticated,
  }) {
    return unauthenticated(status, user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationStatus status, User user)? unknown,
    TResult? Function(User user, AuthenticationStatus state)? authenticated,
    TResult? Function(AuthenticationStatus status, User user)? unauthenticated,
  }) {
    return unauthenticated?.call(status, user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthenticationStatus status, User user)? unknown,
    TResult Function(User user, AuthenticationStatus state)? authenticated,
    TResult Function(AuthenticationStatus status, User user)? unauthenticated,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(status, user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_unknown value) unknown,
    required TResult Function(AuthenticationAuthenticatedState value)
        authenticated,
    required TResult Function(_unauthenticated value) unauthenticated,
  }) {
    return unauthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_unknown value)? unknown,
    TResult? Function(AuthenticationAuthenticatedState value)? authenticated,
    TResult? Function(_unauthenticated value)? unauthenticated,
  }) {
    return unauthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_unknown value)? unknown,
    TResult Function(AuthenticationAuthenticatedState value)? authenticated,
    TResult Function(_unauthenticated value)? unauthenticated,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(this);
    }
    return orElse();
  }
}

abstract class _unauthenticated implements AuthenticationState {
  const factory _unauthenticated(
      [final AuthenticationStatus status,
      final User user]) = _$unauthenticatedImpl;

  AuthenticationStatus get status;
  @override
  User get user;
}
