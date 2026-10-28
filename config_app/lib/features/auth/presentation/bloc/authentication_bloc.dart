import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:config_app/features/auth/domain/repository/authentication_repository.dart';
import 'package:config_app/features/permission/domain/entities/permission.dart';
import 'package:config_app/features/permission/domain/services/permission_service.dart';
import 'package:config_app/features/user/domain/entities/user.dart';
import 'package:config_app/features/user/domain/repository/user_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';
part 'authentication_bloc.freezed.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required this._authenticationRepository,
    required this._userRepository,
    // required RealtimeService realtimeService,
    required this._permissionService,
  }) : super(
         const AuthenticationState.unknown(),
         //
       ) {
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) {
        if (_closing || isClosed) return;
        // Invalidate an in-flight user lookup as soon as the newer transport
        // status arrives, before its BLoC event is processed.
        final event = _AuthenticationStatusChanged(status);
        _statusGenerations[event] = ++_generation;
        add(event);
      },
    );
    // on<AuthenticationRestoreAuthRequested>(_onAuthenticationRestoreRequested);
  }

  final PermissionService _permissionService;
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  // final RealtimeService _realtimeService;
  late StreamSubscription<AuthenticationStatus>
  _authenticationStatusSubscription;
  int _generation = 0;
  bool _closing = false;
  final _statusGenerations = Map<_AuthenticationStatusChanged, int>.identity();

  @override
  Future<void> close() async {
    _closing = true;
    ++_generation;
    _statusGenerations.clear();
    await _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    await super.close();
  }

  Future<void> _onAuthenticationStatusChanged(
    _AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    final generation = _statusGenerations.remove(event) ?? ++_generation;
    if (!_isCurrent(generation, emit)) return;
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        _permissionService.clear();
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        try {
          final user = await _userRepository.getUser();
          if (!_isCurrent(generation, emit)) return;
          if (user == null || user == User.empty) {
            _permissionService.clear();
            return emit(const AuthenticationState.unauthenticated());
          }
          _permissionService.loadData([Permission.NONE.id]);
          return emit(AuthenticationState.authenticated(user));
        } catch (_) {
          if (!_isCurrent(generation, emit)) return;
          _permissionService.clear();
          return emit(const AuthenticationState.unauthenticated());
        }
      case AuthenticationStatus.unknown:
        _permissionService.clear();
        return emit(const AuthenticationState.unknown());
    }
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    if (_closing || emit.isDone) return;
    ++_generation;
    _userRepository.clear();
    _permissionService.clear();
    emit(const AuthenticationState.unauthenticated());
    _authenticationRepository.logOut();
  }

  bool _isCurrent(int generation, Emitter<AuthenticationState> emit) =>
      !_closing && !emit.isDone && generation == _generation;

  // FutureOr<void> _onAuthenticationRestoreRequested(AuthenticationRestoreAuthRequested event, Emitter<AuthenticationState> emit) async {
  //   try {
  //     final user = await _userRepository.getUser(true);
  //     _realtimeService.connect(userId: user.user.id, socketToken: user.socketToken);
  //     emit(AuthenticationState.authenticated(user.user, user.socketToken));
  //   } catch (_) {
  //     return emit(const AuthenticationState.unauthenticated());
  //   }
  // }
}
