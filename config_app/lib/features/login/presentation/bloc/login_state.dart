part of 'login_bloc.dart';

@freezed
sealed class LoginState with _$LoginState {
  const factory LoginState({
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
    @Default(Username.pure(defaultValue: 'admin')) Username username,
    @Default(Password.pure(defaultValue: '123')) Password password,
    @Default(ConnectUri.pure()) ConnectUri connectUri,
    @Default(0) int connectUriRevision,
    @Default(false) bool isValid,
  }) = _LoginState;
}
