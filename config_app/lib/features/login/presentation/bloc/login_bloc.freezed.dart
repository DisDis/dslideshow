// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LoginEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'LoginEvent()';
  }
}

/// @nodoc
class $LoginEventCopyWith<$Res> {
  $LoginEventCopyWith(LoginEvent _, $Res Function(LoginEvent) __);
}

/// @nodoc

class LoginUsernameChanged implements LoginEvent {
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
  String toString() {
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

class LoginPasswordChanged implements LoginEvent {
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
  String toString() {
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

class LoginConnectUriChanged implements LoginEvent {
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
  String toString() {
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

class LoginSubmitted implements LoginEvent {
  const LoginSubmitted();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LoginSubmitted);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'LoginEvent.submit()';
  }
}

/// @nodoc

class LoginConnectUriAutoChanged implements LoginEvent {
  const LoginConnectUriAutoChanged();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LoginConnectUriAutoChanged);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'LoginEvent.autoChangedConnectUri()';
  }
}

/// @nodoc
mixin _$LoginState {
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
  String toString() {
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

/// @nodoc

class _LoginState implements LoginState {
  const _LoginState(
      {this.status = FormzSubmissionStatus.initial,
      this.username = const Username.pure(defaultValue: 'admin'),
      this.password = const Password.pure(defaultValue: '123'),
      this.connectUri =
          const ConnectUri.pure(defaultValue: 'ws://192.168.50.143:8080/ws'),
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
  String toString() {
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
