part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = FormzStatus.valid,
    this.username = const Username.pure(defaultValue: 'admin'),
    this.password = const Password.pure(defaultValue: '123'),
    this.connectUri = const ConnectUri.pure(),
  });

  final FormzStatus status;
  final Username username;
  final Password password;
  final ConnectUri connectUri;

  LoginState copyWith({
    FormzStatus? status,
    Username? username,
    Password? password,
    ConnectUri? connectUri,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      connectUri: connectUri ?? this.connectUri,
    );
  }

  @override
  List<Object> get props => [status, username, password, connectUri];
}
