part of 'authentication_bloc.dart';

@freezed
sealed class AuthenticationEvent with _$AuthenticationEvent {
  const factory AuthenticationEvent.changeStatus(AuthenticationStatus status) =
      _AuthenticationStatusChanged;
  const factory AuthenticationEvent.logout() = AuthenticationLogoutRequested;
  // const factory AuthenticationEvent.restoreAuth() = AuthenticationRestoreAuthRequested;
}
