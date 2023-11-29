part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
    @Default(Username.pure(defaultValue: 'admin')) Username username,
    @Default(Password.pure(defaultValue: '123')) Password password,
    @Default(ConnectUri.pure(defaultValue: 'ws://192.168.50.175/ws')) ConnectUri connectUri,
    @Default(false) bool isValid,
  }) = _LoginState;
}
