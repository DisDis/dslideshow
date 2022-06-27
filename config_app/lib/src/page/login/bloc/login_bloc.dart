import 'package:bloc/bloc.dart';
import 'package:config_app/src/bloc/authentication_repository.dart';
import 'package:config_app/src/page/login/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  static final defaultConnectUri = 'ws://${Uri.base.host}:8080/ws';

  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
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
      status: Formz.validate([state.password, username, state.connectUri]),
    ));
  }

  void _onConnectUriChanged(
    LoginConnectUriChanged event,
    Emitter<LoginState> emit,
  ) {
    final connectUri = ConnectUri.dirty(event.connectUri);
    emit(state.copyWith(
      connectUri: connectUri,
      status: Formz.validate([state.password, state.username, connectUri]),
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
      status: Formz.validate([state.password, state.username, connectUri]),
    ));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.username, state.connectUri]),
    ));
  }

  void _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await _authenticationRepository.logIn(
          connectUrl: Uri.parse(state.connectUri.value),
          username: state.username.value,
          password: state.password.value,
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
