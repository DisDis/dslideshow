import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:config_app/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:config_app/features/device/data/device_repository.dart';
import 'package:dslideshow_common/version.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:pub_semver/pub_semver.dart';

part 'backend_version_bloc.freezed.dart';

enum BackendVersionStatus { idle, loading, ready, failure }

enum BackendCompatibility { unknown, matching, mismatched }

@freezed
abstract class BackendVersionState with _$BackendVersionState {
  const factory BackendVersionState({
    @Default(BackendVersionStatus.idle) BackendVersionStatus status,
    String? version,
    @Default(BackendCompatibility.unknown) BackendCompatibility compatibility,
  }) = _BackendVersionState;
}

class BackendVersionBloc extends Cubit<BackendVersionState> {
  BackendVersionBloc({
    required AuthenticationBloc authentication,
    required this.repository,
    this.expectedVersion = ApplicationInfo.backendVersion,
  }) : _expectedMajor = Version.parse(expectedVersion).major,
       super(const BackendVersionState()) {
    _subscription = authentication.stream.listen(_authenticationChanged);
    _authenticationChanged(authentication.state);
  }

  static final _log = Logger('BackendVersion');
  final DeviceRepository repository;
  final String expectedVersion;
  final int _expectedMajor;
  late final StreamSubscription<AuthenticationState> _subscription;
  Object? _session;

  void _authenticationChanged(AuthenticationState authentication) {
    final authenticated = authentication is AuthenticationAuthenticatedState;
    if (!authenticated && _session == null) return;
    if (state.status == BackendVersionStatus.loading) _log.info('action=load result=cancelled');
    if (!authenticated) {
      _session = null;
      emit(const BackendVersionState());
    } else {
      // The same auth value may reappear after logout; each login owns a new request.
      final session = Object();
      _session = session;
      emit(const BackendVersionState(status: BackendVersionStatus.loading));
      unawaited(_load(session));
    }
  }

  Future<void> _load(Object session) async {
    _log.info('action=load result=started expectedMajor=$_expectedMajor');
    try {
      final frame = await repository.getState();
      if (isClosed || !identical(session, _session)) return;
      int? major;
      try {
        major = Version.parse(frame.backendVersion).major;
      } on FormatException {
        // Missing or malformed versions cannot establish compatibility.
      }
      final compatibility = major == null
          ? BackendCompatibility.unknown
          : major == _expectedMajor
          ? BackendCompatibility.matching
          : BackendCompatibility.mismatched;
      _log.log(
        compatibility == BackendCompatibility.matching ? Level.INFO : Level.WARNING,
        'action=load result=completed compatibility=${compatibility.name} '
        'expectedMajor=$_expectedMajor reportedMajor=${major ?? 'unknown'}',
      );
      emit(
        BackendVersionState(
          status: BackendVersionStatus.ready,
          version: frame.backendVersion,
          compatibility: compatibility,
        ),
      );
    } catch (error) {
      if (isClosed || !identical(session, _session)) return;
      _log.warning('action=load result=failed type=${error.runtimeType}');
      emit(const BackendVersionState(status: BackendVersionStatus.failure));
    }
  }

  @override
  Future<void> close() async {
    if (state.status == BackendVersionStatus.loading) _log.info('action=load result=cancelled');
    _session = null;
    await _subscription.cancel();
    return super.close();
  }
}
