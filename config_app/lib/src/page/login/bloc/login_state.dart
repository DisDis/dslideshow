part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
    @Default(const Username.pure(defaultValue: 'admin')) Username username,
    @Default(const Password.pure(defaultValue: '123')) Password password,
    @Default(const ConnectUri.pure()) ConnectUri connectUri,
    @Default(false) bool isValid,
  }) = _LoginState;
}
