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
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
    // required RealtimeService realtimeService,
    required PermissionService permissionService,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        // _realtimeService = realtimeService,
        _permissionService = permissionService,
        super(
          const AuthenticationState.unknown(),
          //
        ) {
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(_AuthenticationStatusChanged(status)),
    );
    // on<AuthenticationRestoreAuthRequested>(_onAuthenticationRestoreRequested);
  }

  final PermissionService _permissionService;
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  // final RealtimeService _realtimeService;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  Future<void> _onAuthenticationStatusChanged(
    _AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser(true);
        //_permissionService.loadDataByScopeId(user.permissionIdsByScopeId);
        _permissionService.loadData([Permission.NONE.id]);
        //_realtimeService.connect(userId: user.user.id, socketToken: user.socketToken);
        return emit(
          user != User.empty
              ? AuthenticationState.authenticated(user)
              : const AuthenticationState.unauthenticated(),
        );
      case AuthenticationStatus.unknown:
        return emit(const AuthenticationState.unknown());
    }
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    _authenticationRepository.logOut();
    _userRepository.clear();
    _permissionService.clear();
  }

  Future<User> _tryGetUser([bool force = false]) async {
    final user = await _userRepository.getUser(/*force*/);
    return user!;
  }

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
