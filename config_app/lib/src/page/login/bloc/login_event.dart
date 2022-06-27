part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginUsernameChanged extends LoginEvent {
  const LoginUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class LoginConnectUriChanged extends LoginEvent {
  const LoginConnectUriChanged(this.connectUri);

  final String connectUri;

  @override
  List<Object> get props => [connectUri];
}

class LoginConnectUriAutoChanged extends LoginEvent {
  const LoginConnectUriAutoChanged();

  @override
  List<Object> get props => [];
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}
