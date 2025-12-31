part of 'login_bloc.dart';

@freezed
sealed class LoginState with _$LoginState {
  const factory LoginState({
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
    @Default(Username.pure(defaultValue: 'admin')) Username username,
    @Default(Password.pure(defaultValue: '123')) Password password,
    @Default(ConnectUri.pure(defaultValue: 'ws://192.168.50.177:8081/ws')) ConnectUri connectUri,
    @Default(false) bool isValid,
  }) = _LoginState;
}
