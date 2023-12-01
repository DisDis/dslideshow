part of 'login_bloc.dart';

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.changedUsename(String username) = LoginUsernameChanged;
  const factory LoginEvent.changedPassword(String password) = LoginPasswordChanged;
  const factory LoginEvent.changedConnectUri(String connectUri) = LoginConnectUriChanged;
  const factory LoginEvent.submit() = LoginSubmitted;
  const factory LoginEvent.autoChangedConnectUri() = LoginConnectUriAutoChanged;
}
