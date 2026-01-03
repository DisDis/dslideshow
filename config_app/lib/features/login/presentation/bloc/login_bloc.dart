import 'package:bloc/bloc.dart';
import 'package:config_app/features/auth/domain/repository/authentication_repository.dart';
import 'package:config_app/features/login/presentation/bloc/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final _log = Logger('LoginBloc');
  static final defaultConnectUri = 'ws://${Uri.base.host}:${Uri.base.port}/ws';

  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super( kIsWeb? LoginState(connectUri:  ConnectUri.pure(defaultValue: defaultConnectUri)): const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginConnectUriChanged>(_onConnectUriChanged);
    on<LoginConnectUriAutoChanged>(_onConnectUriAutoChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(state.copyWith(
      username: username,
      isValid: Formz.validate([state.password, username, state.connectUri]),
    ));
  }

  void _onConnectUriChanged(
    LoginConnectUriChanged event,
    Emitter<LoginState> emit,
  ) {
    final connectUri = ConnectUri.dirty(event.connectUri);
    emit(state.copyWith(
      connectUri: connectUri,
      isValid: Formz.validate([state.password, state.username, connectUri]),
    ));
  }

  void _onConnectUriAutoChanged(
    LoginConnectUriAutoChanged event,
    Emitter<LoginState> emit,
  ) {
    if (Uri.base.host.isEmpty) {
      return;
    }
    final connectUri = ConnectUri.dirty(defaultConnectUri);
    emit(state.copyWith(
      connectUri: connectUri,
      isValid: Formz.validate([state.password, state.username, connectUri]),
    ));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      isValid: Formz.validate([password, state.username, state.connectUri]),
    ));
  }

  void _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _authenticationRepository.logIn(
          connectUrl: Uri.parse(state.connectUri.value),
          username: state.username.value,
          password: state.password.value,
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (e, st) {
        _log.severe("Error", e, st);
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
