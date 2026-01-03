// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginEvent implements DiagnosticableTreeMixin {
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties..add(DiagnosticsProperty('type', 'LoginEvent'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LoginEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LoginEvent()';
  }
}

/// @nodoc
class $LoginEventCopyWith<$Res> {
  $LoginEventCopyWith(LoginEvent _, $Res Function(LoginEvent) __);
}

/// Adds pattern-matching-related methods to [LoginEvent].
extension LoginEventPatterns on LoginEvent {
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
    TResult Function(LoginUsernameChanged value)? changedUsename,
    TResult Function(LoginPasswordChanged value)? changedPassword,
    TResult Function(LoginConnectUriChanged value)? changedConnectUri,
    TResult Function(LoginSubmitted value)? submit,
    TResult Function(LoginConnectUriAutoChanged value)? autoChangedConnectUri,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case LoginUsernameChanged() when changedUsename != null:
        return changedUsename(_that);
      case LoginPasswordChanged() when changedPassword != null:
        return changedPassword(_that);
      case LoginConnectUriChanged() when changedConnectUri != null:
        return changedConnectUri(_that);
      case LoginSubmitted() when submit != null:
        return submit(_that);
      case LoginConnectUriAutoChanged() when autoChangedConnectUri != null:
        return autoChangedConnectUri(_that);
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
    required TResult Function(LoginUsernameChanged value) changedUsename,
    required TResult Function(LoginPasswordChanged value) changedPassword,
    required TResult Function(LoginConnectUriChanged value) changedConnectUri,
    required TResult Function(LoginSubmitted value) submit,
    required TResult Function(LoginConnectUriAutoChanged value)
        autoChangedConnectUri,
  }) {
    final _that = this;
    switch (_that) {
      case LoginUsernameChanged():
        return changedUsename(_that);
      case LoginPasswordChanged():
        return changedPassword(_that);
      case LoginConnectUriChanged():
        return changedConnectUri(_that);
      case LoginSubmitted():
        return submit(_that);
      case LoginConnectUriAutoChanged():
        return autoChangedConnectUri(_that);
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
    TResult? Function(LoginUsernameChanged value)? changedUsename,
    TResult? Function(LoginPasswordChanged value)? changedPassword,
    TResult? Function(LoginConnectUriChanged value)? changedConnectUri,
    TResult? Function(LoginSubmitted value)? submit,
    TResult? Function(LoginConnectUriAutoChanged value)? autoChangedConnectUri,
  }) {
    final _that = this;
    switch (_that) {
      case LoginUsernameChanged() when changedUsename != null:
        return changedUsename(_that);
      case LoginPasswordChanged() when changedPassword != null:
        return changedPassword(_that);
      case LoginConnectUriChanged() when changedConnectUri != null:
        return changedConnectUri(_that);
      case LoginSubmitted() when submit != null:
        return submit(_that);
      case LoginConnectUriAutoChanged() when autoChangedConnectUri != null:
        return autoChangedConnectUri(_that);
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
    TResult Function(String username)? changedUsename,
    TResult Function(String password)? changedPassword,
    TResult Function(String connectUri)? changedConnectUri,
    TResult Function()? submit,
    TResult Function()? autoChangedConnectUri,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case LoginUsernameChanged() when changedUsename != null:
        return changedUsename(_that.username);
      case LoginPasswordChanged() when changedPassword != null:
        return changedPassword(_that.password);
      case LoginConnectUriChanged() when changedConnectUri != null:
        return changedConnectUri(_that.connectUri);
      case LoginSubmitted() when submit != null:
        return submit();
      case LoginConnectUriAutoChanged() when autoChangedConnectUri != null:
        return autoChangedConnectUri();
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
    required TResult Function(String username) changedUsename,
    required TResult Function(String password) changedPassword,
    required TResult Function(String connectUri) changedConnectUri,
    required TResult Function() submit,
    required TResult Function() autoChangedConnectUri,
  }) {
    final _that = this;
    switch (_that) {
      case LoginUsernameChanged():
        return changedUsename(_that.username);
      case LoginPasswordChanged():
        return changedPassword(_that.password);
      case LoginConnectUriChanged():
        return changedConnectUri(_that.connectUri);
      case LoginSubmitted():
        return submit();
      case LoginConnectUriAutoChanged():
        return autoChangedConnectUri();
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
    TResult? Function(String username)? changedUsename,
    TResult? Function(String password)? changedPassword,
    TResult? Function(String connectUri)? changedConnectUri,
    TResult? Function()? submit,
    TResult? Function()? autoChangedConnectUri,
  }) {
    final _that = this;
    switch (_that) {
      case LoginUsernameChanged() when changedUsename != null:
        return changedUsename(_that.username);
      case LoginPasswordChanged() when changedPassword != null:
        return changedPassword(_that.password);
      case LoginConnectUriChanged() when changedConnectUri != null:
        return changedConnectUri(_that.connectUri);
      case LoginSubmitted() when submit != null:
        return submit();
      case LoginConnectUriAutoChanged() when autoChangedConnectUri != null:
        return autoChangedConnectUri();
      case _:
        return null;
    }
  }
}

/// @nodoc

class LoginUsernameChanged with DiagnosticableTreeMixin implements LoginEvent {
  const LoginUsernameChanged(this.username);

  final String username;

  /// Create a copy of LoginEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LoginUsernameChangedCopyWith<LoginUsernameChanged> get copyWith =>
      _$LoginUsernameChangedCopyWithImpl<LoginUsernameChanged>(
          this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'LoginEvent.changedUsename'))
      ..add(DiagnosticsProperty('username', username));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LoginUsernameChanged &&
            (identical(other.username, username) ||
                other.username == username));
  }

  @override
  int get hashCode => Object.hash(runtimeType, username);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LoginEvent.changedUsename(username: $username)';
  }
}

/// @nodoc
abstract mixin class $LoginUsernameChangedCopyWith<$Res>
    implements $LoginEventCopyWith<$Res> {
  factory $LoginUsernameChangedCopyWith(LoginUsernameChanged value,
          $Res Function(LoginUsernameChanged) _then) =
      _$LoginUsernameChangedCopyWithImpl;
  @useResult
  $Res call({String username});
}

/// @nodoc
class _$LoginUsernameChangedCopyWithImpl<$Res>
    implements $LoginUsernameChangedCopyWith<$Res> {
  _$LoginUsernameChangedCopyWithImpl(this._self, this._then);

  final LoginUsernameChanged _self;
  final $Res Function(LoginUsernameChanged) _then;

  /// Create a copy of LoginEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? username = null,
  }) {
    return _then(LoginUsernameChanged(
      null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class LoginPasswordChanged with DiagnosticableTreeMixin implements LoginEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  /// Create a copy of LoginEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LoginPasswordChangedCopyWith<LoginPasswordChanged> get copyWith =>
      _$LoginPasswordChangedCopyWithImpl<LoginPasswordChanged>(
          this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'LoginEvent.changedPassword'))
      ..add(DiagnosticsProperty('password', password));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LoginPasswordChanged &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, password);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LoginEvent.changedPassword(password: $password)';
  }
}

/// @nodoc
abstract mixin class $LoginPasswordChangedCopyWith<$Res>
    implements $LoginEventCopyWith<$Res> {
  factory $LoginPasswordChangedCopyWith(LoginPasswordChanged value,
          $Res Function(LoginPasswordChanged) _then) =
      _$LoginPasswordChangedCopyWithImpl;
  @useResult
  $Res call({String password});
}

/// @nodoc
class _$LoginPasswordChangedCopyWithImpl<$Res>
    implements $LoginPasswordChangedCopyWith<$Res> {
  _$LoginPasswordChangedCopyWithImpl(this._self, this._then);

  final LoginPasswordChanged _self;
  final $Res Function(LoginPasswordChanged) _then;

  /// Create a copy of LoginEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? password = null,
  }) {
    return _then(LoginPasswordChanged(
      null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class LoginConnectUriChanged
    with DiagnosticableTreeMixin
    implements LoginEvent {
  const LoginConnectUriChanged(this.connectUri);

  final String connectUri;

  /// Create a copy of LoginEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LoginConnectUriChangedCopyWith<LoginConnectUriChanged> get copyWith =>
      _$LoginConnectUriChangedCopyWithImpl<LoginConnectUriChanged>(
          this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'LoginEvent.changedConnectUri'))
      ..add(DiagnosticsProperty('connectUri', connectUri));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LoginConnectUriChanged &&
            (identical(other.connectUri, connectUri) ||
                other.connectUri == connectUri));
  }

  @override
  int get hashCode => Object.hash(runtimeType, connectUri);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LoginEvent.changedConnectUri(connectUri: $connectUri)';
  }
}

/// @nodoc
abstract mixin class $LoginConnectUriChangedCopyWith<$Res>
    implements $LoginEventCopyWith<$Res> {
  factory $LoginConnectUriChangedCopyWith(LoginConnectUriChanged value,
          $Res Function(LoginConnectUriChanged) _then) =
      _$LoginConnectUriChangedCopyWithImpl;
  @useResult
  $Res call({String connectUri});
}

/// @nodoc
class _$LoginConnectUriChangedCopyWithImpl<$Res>
    implements $LoginConnectUriChangedCopyWith<$Res> {
  _$LoginConnectUriChangedCopyWithImpl(this._self, this._then);

  final LoginConnectUriChanged _self;
  final $Res Function(LoginConnectUriChanged) _then;

  /// Create a copy of LoginEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? connectUri = null,
  }) {
    return _then(LoginConnectUriChanged(
      null == connectUri
          ? _self.connectUri
          : connectUri // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class LoginSubmitted with DiagnosticableTreeMixin implements LoginEvent {
  const LoginSubmitted();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties..add(DiagnosticsProperty('type', 'LoginEvent.submit'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LoginSubmitted);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LoginEvent.submit()';
  }
}

/// @nodoc

class LoginConnectUriAutoChanged
    with DiagnosticableTreeMixin
    implements LoginEvent {
  const LoginConnectUriAutoChanged();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'LoginEvent.autoChangedConnectUri'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LoginConnectUriAutoChanged);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LoginEvent.autoChangedConnectUri()';
  }
}

/// @nodoc
mixin _$LoginState implements DiagnosticableTreeMixin {
  FormzSubmissionStatus get status;
  Username get username;
  Password get password;
  ConnectUri get connectUri;
  bool get isValid;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LoginStateCopyWith<LoginState> get copyWith =>
      _$LoginStateCopyWithImpl<LoginState>(this as LoginState, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'LoginState'))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('username', username))
      ..add(DiagnosticsProperty('password', password))
      ..add(DiagnosticsProperty('connectUri', connectUri))
      ..add(DiagnosticsProperty('isValid', isValid));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LoginState &&
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

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LoginState(status: $status, username: $username, password: $password, connectUri: $connectUri, isValid: $isValid)';
  }
}

/// @nodoc
abstract mixin class $LoginStateCopyWith<$Res> {
  factory $LoginStateCopyWith(
          LoginState value, $Res Function(LoginState) _then) =
      _$LoginStateCopyWithImpl;
  @useResult
  $Res call(
      {FormzSubmissionStatus status,
      Username username,
      Password password,
      ConnectUri connectUri,
      bool isValid});
}

/// @nodoc
class _$LoginStateCopyWithImpl<$Res> implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._self, this._then);

  final LoginState _self;
  final $Res Function(LoginState) _then;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? username = null,
    Object? password = null,
    Object? connectUri = null,
    Object? isValid = null,
  }) {
    return _then(_self.copyWith(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as FormzSubmissionStatus,
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as Username,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as Password,
      connectUri: null == connectUri
          ? _self.connectUri
          : connectUri // ignore: cast_nullable_to_non_nullable
              as ConnectUri,
      isValid: null == isValid
          ? _self.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [LoginState].
extension LoginStatePatterns on LoginState {
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
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_LoginState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LoginState() when $default != null:
        return $default(_that);
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
  TResult map<TResult extends Object?>(
    TResult Function(_LoginState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoginState():
        return $default(_that);
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
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_LoginState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoginState() when $default != null:
        return $default(_that);
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
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(FormzSubmissionStatus status, Username username,
            Password password, ConnectUri connectUri, bool isValid)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LoginState() when $default != null:
        return $default(_that.status, _that.username, _that.password,
            _that.connectUri, _that.isValid);
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
  TResult when<TResult extends Object?>(
    TResult Function(FormzSubmissionStatus status, Username username,
            Password password, ConnectUri connectUri, bool isValid)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoginState():
        return $default(_that.status, _that.username, _that.password,
            _that.connectUri, _that.isValid);
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
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(FormzSubmissionStatus status, Username username,
            Password password, ConnectUri connectUri, bool isValid)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoginState() when $default != null:
        return $default(_that.status, _that.username, _that.password,
            _that.connectUri, _that.isValid);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _LoginState with DiagnosticableTreeMixin implements LoginState {
  const _LoginState(
      {this.status = FormzSubmissionStatus.initial,
      this.username = const Username.pure(defaultValue: 'admin'),
      this.password = const Password.pure(defaultValue: '123'),
      this.connectUri =
          const ConnectUri.pure(defaultValue: 'ws://192.168.50.xx:8080/ws'),
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

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LoginStateCopyWith<_LoginState> get copyWith =>
      __$LoginStateCopyWithImpl<_LoginState>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'LoginState'))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('username', username))
      ..add(DiagnosticsProperty('password', password))
      ..add(DiagnosticsProperty('connectUri', connectUri))
      ..add(DiagnosticsProperty('isValid', isValid));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoginState &&
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

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LoginState(status: $status, username: $username, password: $password, connectUri: $connectUri, isValid: $isValid)';
  }
}

/// @nodoc
abstract mixin class _$LoginStateCopyWith<$Res>
    implements $LoginStateCopyWith<$Res> {
  factory _$LoginStateCopyWith(
          _LoginState value, $Res Function(_LoginState) _then) =
      __$LoginStateCopyWithImpl;
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
class __$LoginStateCopyWithImpl<$Res> implements _$LoginStateCopyWith<$Res> {
  __$LoginStateCopyWithImpl(this._self, this._then);

  final _LoginState _self;
  final $Res Function(_LoginState) _then;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? status = null,
    Object? username = null,
    Object? password = null,
    Object? connectUri = null,
    Object? isValid = null,
  }) {
    return _then(_LoginState(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as FormzSubmissionStatus,
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as Username,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as Password,
      connectUri: null == connectUri
          ? _self.connectUri
          : connectUri // ignore: cast_nullable_to_non_nullable
              as ConnectUri,
      isValid: null == isValid
          ? _self.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
