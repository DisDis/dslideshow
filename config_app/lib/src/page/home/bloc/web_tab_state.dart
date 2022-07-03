import 'package:config_app/src/page/login/models/models.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

abstract class WebTabState extends Equatable {
  WebTabState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnWebTabState extends WebTabState {
  UnWebTabState();

  @override
  String toString() => 'UnWebTabState';
}

class ErrorWebTabState extends WebTabState {
  ErrorWebTabState(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorWebTabState';

  @override
  List<Object> get props => [errorMessage];
}

/// Initialized
class InWebTabState extends WebTabState {
  final AppConfig config;
  InWebTabState(this.config);

  @override
  String toString() => 'InWebTabState';
  @override
  List<Object> get props => [config];
}

/*
class WebTabState extends Equatable {
  const WebTabState({
    this.status = FormzStatus.valid,
    this.username = const Username.pure(defaultValue: 'admin'),
    this.password = const Password.pure(defaultValue: '123'),
    this.connectUri = const ConnectUri.pure(),
  });

  final FormzStatus status;
  final Username username;
  final Password password;
  final ConnectUri connectUri;

  WebTabState copyWith({
    FormzStatus? status,
    Username? username,
    Password? password,
    ConnectUri? connectUri,
  }) {
    return WebTabState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      connectUri: connectUri ?? this.connectUri,
    );
  }

  @override
  List<Object> get props => [status, username, password, connectUri];
}*/
