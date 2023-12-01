part of 'authentication_bloc.dart';

@Freezed(copyWith: false, fromJson: false, toJson: false)
sealed class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.unknown([
    @Default(AuthenticationStatus.unknown) AuthenticationStatus status,
    @Default(User.empty) User user,
    // @Default(CurrentUser.tokenEmpty) String socketToken,
  ]) = _unknown;

  const factory AuthenticationState.authenticated(User user,
      /* String socketToken,*/ [@Default(AuthenticationStatus.authenticated) AuthenticationStatus state]) = AuthenticationAuthenticatedState;

  const factory AuthenticationState.unauthenticated([
    @Default(AuthenticationStatus.unauthenticated) AuthenticationStatus status,
    @Default(User.empty) User user,
    // @Default(CurrentUser.tokenEmpty) String socketToken,
  ]) = _unauthenticated;
}
