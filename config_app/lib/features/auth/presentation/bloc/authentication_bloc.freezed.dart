// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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

/// Adds pattern-matching-related methods to [AuthenticationEvent].
extension AuthenticationEventPatterns on AuthenticationEvent {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthenticationStatusChanged value)? changeStatus,
    TResult Function(AuthenticationLogoutRequested value)? logout,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AuthenticationStatusChanged() when changeStatus != null:
        return changeStatus(_that);
      case AuthenticationLogoutRequested() when logout != null:
        return logout(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthenticationStatusChanged value) changeStatus,
    required TResult Function(AuthenticationLogoutRequested value) logout,
  }) {
    final _that = this;
    switch (_that) {
      case _AuthenticationStatusChanged():
        return changeStatus(_that);
      case AuthenticationLogoutRequested():
        return logout(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthenticationStatusChanged value)? changeStatus,
    TResult? Function(AuthenticationLogoutRequested value)? logout,
  }) {
    final _that = this;
    switch (_that) {
      case _AuthenticationStatusChanged() when changeStatus != null:
        return changeStatus(_that);
      case AuthenticationLogoutRequested() when logout != null:
        return logout(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthenticationStatus status)? changeStatus,
    TResult Function()? logout,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AuthenticationStatusChanged() when changeStatus != null:
        return changeStatus(_that.status);
      case AuthenticationLogoutRequested() when logout != null:
        return logout();
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthenticationStatus status) changeStatus,
    required TResult Function() logout,
  }) {
    final _that = this;
    switch (_that) {
      case _AuthenticationStatusChanged():
        return changeStatus(_that.status);
      case AuthenticationLogoutRequested():
        return logout();
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationStatus status)? changeStatus,
    TResult? Function()? logout,
  }) {
    final _that = this;
    switch (_that) {
      case _AuthenticationStatusChanged() when changeStatus != null:
        return changeStatus(_that.status);
      case AuthenticationLogoutRequested() when logout != null:
        return logout();
      case _:
        return null;
    }
  }
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

/// Adds pattern-matching-related methods to [AuthenticationState].
extension AuthenticationStatePatterns on AuthenticationState {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_unknown value)? unknown,
    TResult Function(AuthenticationAuthenticatedState value)? authenticated,
    TResult Function(_unauthenticated value)? unauthenticated,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _unknown() when unknown != null:
        return unknown(_that);
      case AuthenticationAuthenticatedState() when authenticated != null:
        return authenticated(_that);
      case _unauthenticated() when unauthenticated != null:
        return unauthenticated(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_unknown value) unknown,
    required TResult Function(AuthenticationAuthenticatedState value)
        authenticated,
    required TResult Function(_unauthenticated value) unauthenticated,
  }) {
    final _that = this;
    switch (_that) {
      case _unknown():
        return unknown(_that);
      case AuthenticationAuthenticatedState():
        return authenticated(_that);
      case _unauthenticated():
        return unauthenticated(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_unknown value)? unknown,
    TResult? Function(AuthenticationAuthenticatedState value)? authenticated,
    TResult? Function(_unauthenticated value)? unauthenticated,
  }) {
    final _that = this;
    switch (_that) {
      case _unknown() when unknown != null:
        return unknown(_that);
      case AuthenticationAuthenticatedState() when authenticated != null:
        return authenticated(_that);
      case _unauthenticated() when unauthenticated != null:
        return unauthenticated(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthenticationStatus status, User user)? unknown,
    TResult Function(User user, AuthenticationStatus state)? authenticated,
    TResult Function(AuthenticationStatus status, User user)? unauthenticated,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _unknown() when unknown != null:
        return unknown(_that.status, _that.user);
      case AuthenticationAuthenticatedState() when authenticated != null:
        return authenticated(_that.user, _that.state);
      case _unauthenticated() when unauthenticated != null:
        return unauthenticated(_that.status, _that.user);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthenticationStatus status, User user) unknown,
    required TResult Function(User user, AuthenticationStatus state)
        authenticated,
    required TResult Function(AuthenticationStatus status, User user)
        unauthenticated,
  }) {
    final _that = this;
    switch (_that) {
      case _unknown():
        return unknown(_that.status, _that.user);
      case AuthenticationAuthenticatedState():
        return authenticated(_that.user, _that.state);
      case _unauthenticated():
        return unauthenticated(_that.status, _that.user);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationStatus status, User user)? unknown,
    TResult? Function(User user, AuthenticationStatus state)? authenticated,
    TResult? Function(AuthenticationStatus status, User user)? unauthenticated,
  }) {
    final _that = this;
    switch (_that) {
      case _unknown() when unknown != null:
        return unknown(_that.status, _that.user);
      case AuthenticationAuthenticatedState() when authenticated != null:
        return authenticated(_that.user, _that.state);
      case _unauthenticated() when unauthenticated != null:
        return unauthenticated(_that.status, _that.user);
      case _:
        return null;
    }
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
