// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authentication_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthenticationEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AuthenticationEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthenticationEvent()';
  }
}

/// @nodoc
class $AuthenticationEventCopyWith<$Res> {
  $AuthenticationEventCopyWith(
      AuthenticationEvent _, $Res Function(AuthenticationEvent) __);
}

/// @nodoc

class _AuthenticationStatusChanged implements AuthenticationEvent {
  const _AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;

  /// Create a copy of AuthenticationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AuthenticationStatusChangedCopyWith<_AuthenticationStatusChanged>
      get copyWith => __$AuthenticationStatusChangedCopyWithImpl<
          _AuthenticationStatusChanged>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuthenticationStatusChanged &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  @override
  String toString() {
    return 'AuthenticationEvent.changeStatus(status: $status)';
  }
}

/// @nodoc
abstract mixin class _$AuthenticationStatusChangedCopyWith<$Res>
    implements $AuthenticationEventCopyWith<$Res> {
  factory _$AuthenticationStatusChangedCopyWith(
          _AuthenticationStatusChanged value,
          $Res Function(_AuthenticationStatusChanged) _then) =
      __$AuthenticationStatusChangedCopyWithImpl;
  @useResult
  $Res call({AuthenticationStatus status});
}

/// @nodoc
class __$AuthenticationStatusChangedCopyWithImpl<$Res>
    implements _$AuthenticationStatusChangedCopyWith<$Res> {
  __$AuthenticationStatusChangedCopyWithImpl(this._self, this._then);

  final _AuthenticationStatusChanged _self;
  final $Res Function(_AuthenticationStatusChanged) _then;

  /// Create a copy of AuthenticationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? status = null,
  }) {
    return _then(_AuthenticationStatusChanged(
      null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as AuthenticationStatus,
    ));
  }
}

/// @nodoc

class AuthenticationLogoutRequested implements AuthenticationEvent {
  const AuthenticationLogoutRequested();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthenticationLogoutRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthenticationEvent.logout()';
  }
}

/// @nodoc
mixin _$AuthenticationState {
  User get user;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthenticationState &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  @override
  String toString() {
    return 'AuthenticationState(user: $user)';
  }
}

/// @nodoc

class _unknown implements AuthenticationState {
  const _unknown(
      [this.status = AuthenticationStatus.unknown, this.user = User.empty]);

  @JsonKey()
  final AuthenticationStatus status;
  @override
  @JsonKey()
  final User user;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _unknown &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, user);

  @override
  String toString() {
    return 'AuthenticationState.unknown(status: $status, user: $user)';
  }
}

/// @nodoc

class AuthenticationAuthenticatedState implements AuthenticationState {
  const AuthenticationAuthenticatedState(this.user,
      [this.state = AuthenticationStatus.authenticated]);

  @override
  final User user;
  @JsonKey()
  final AuthenticationStatus state;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthenticationAuthenticatedState &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user, state);

  @override
  String toString() {
    return 'AuthenticationState.authenticated(user: $user, state: $state)';
  }
}

/// @nodoc

class _unauthenticated implements AuthenticationState {
  const _unauthenticated(
      [this.status = AuthenticationStatus.unauthenticated,
      this.user = User.empty]);

  @JsonKey()
  final AuthenticationStatus status;
  @override
  @JsonKey()
  final User user;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _unauthenticated &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, user);

  @override
  String toString() {
    return 'AuthenticationState.unauthenticated(status: $status, user: $user)';
  }
}

// dart format on
