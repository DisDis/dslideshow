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
mixin _$LoginState {
  FormzSubmissionStatus get status => throw _privateConstructorUsedError;
  Username get username => throw _privateConstructorUsedError;
  Password get password => throw _privateConstructorUsedError;
  ConnectUri get connectUri => throw _privateConstructorUsedError;
  bool get isValid => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginStateCopyWith<LoginState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginStateCopyWith<$Res> {
  factory $LoginStateCopyWith(LoginState value, $Res Function(LoginState) then) = _$LoginStateCopyWithImpl<$Res, LoginState>;
  @useResult
  $Res call({FormzSubmissionStatus status, Username username, Password password, ConnectUri connectUri, bool isValid});
}

/// @nodoc
class _$LoginStateCopyWithImpl<$Res, $Val extends LoginState> implements $LoginStateCopyWith<$Res> {
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
abstract class _$$LoginStateImplCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory _$$LoginStateImplCopyWith(_$LoginStateImpl value, $Res Function(_$LoginStateImpl) then) = __$$LoginStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({FormzSubmissionStatus status, Username username, Password password, ConnectUri connectUri, bool isValid});
}

/// @nodoc
class __$$LoginStateImplCopyWithImpl<$Res> extends _$LoginStateCopyWithImpl<$Res, _$LoginStateImpl> implements _$$LoginStateImplCopyWith<$Res> {
  __$$LoginStateImplCopyWithImpl(_$LoginStateImpl _value, $Res Function(_$LoginStateImpl) _then) : super(_value, _then);

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
      this.connectUri = const ConnectUri.pure(defaultValue: 'ws://192.168.50.175:8080/ws'),
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
            (identical(other.username, username) || other.username == username) &&
            (identical(other.password, password) || other.password == password) &&
            (identical(other.connectUri, connectUri) || other.connectUri == connectUri) &&
            (identical(other.isValid, isValid) || other.isValid == isValid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, username, password, connectUri, isValid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginStateImplCopyWith<_$LoginStateImpl> get copyWith => __$$LoginStateImplCopyWithImpl<_$LoginStateImpl>(this, _$identity);
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
  _$$LoginStateImplCopyWith<_$LoginStateImpl> get copyWith => throw _privateConstructorUsedError;
}
