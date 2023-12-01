import 'dart:async';

abstract class AuthenticationRepository {
  Stream<AuthenticationStatus> get status;

  Future<void> logIn({
    required Uri connectUrl,
    required String username,
    required String password,
  });
  void logOut();

  void dispose();
}

enum AuthenticationStatus { unknown, authenticated, unauthenticated }
