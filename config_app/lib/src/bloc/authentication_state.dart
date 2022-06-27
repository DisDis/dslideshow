import 'package:config_app/src/bloc/authentication_repository.dart';
import 'package:config_app/src/state/user_state.dart';
import 'package:equatable/equatable.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user = User.empty,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(User user) : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated() : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final User user;

  @override
  List<Object> get props => [status, user];
}
