import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import '../../data/repository/yandex_drive_repository.dart';

part 'yandex_drive_bloc.freezed.dart';

@freezed
abstract class YandexSettingsState with _$YandexSettingsState {
  const factory YandexSettingsState({
    required YandexDriveStorageConfig config,
    DriveState? remote,
    DriveAuthorization? authorization,
    @Default(false) bool authorizationOpen,
    @Default(false) bool busy,
    YandexPanelFailureKind? failure,
  }) = _YandexSettingsState;
}

/// Owns the draft and the panel's observation of backend-owned OAuth sessions.
class YandexSettingsCubit extends Cubit<YandexSettingsState> {
  YandexSettingsCubit({required this.repository, required YandexDriveStorageConfig config, required this.onChanged})
    : super(YandexSettingsState(config: config));

  static final _log = Logger('YandexSettingsCubit');
  static const _runtimePollInterval = Duration(seconds: 10);
  final YandexDriveRepository repository;
  final void Function(YandexDriveStorageConfig) onChanged;
  Timer? _authorizationTimer;
  Timer? _runtimeTimer;

  void setPeriod(int minutes) {
    if (minutes > 0) _draft(state.config.copyWith(syncPeriod: Duration(minutes: minutes)));
  }

  void setAccountEnabled(String accountId, bool enabled) =>
      _changeAccount(accountId, (account) => account.copyWith(enabled: enabled));

  void setAccountLabel(String accountId, String label) =>
      _changeAccount(accountId, (account) => account.copyWith(label: label));

  void setPaths(String accountId, String label, List<String> paths) {
    final accounts = state.config.accounts.toList();
    final index = accounts.indexWhere((account) => account.accountId == accountId);
    final account = index >= 0 ? accounts[index] : YandexDriveAccountConfig(accountId: accountId, label: label);
    final changed = account.copyWith(paths: paths.toSet().toList()..sort());
    if (index >= 0) {
      accounts[index] = changed;
    } else {
      accounts.add(changed);
    }
    _draft(state.config.copyWith(accounts: accounts));
    _log.fine('event=foldersEdited accounts=${accounts.length} folders=${paths.length}');
  }

  void _changeAccount(String accountId, YandexDriveAccountConfig Function(YandexDriveAccountConfig) change) {
    _draft(
      state.config.copyWith(
        accounts: [
          for (final account in state.config.accounts) account.accountId == accountId ? change(account) : account,
        ],
      ),
    );
  }

  void _draft(YandexDriveStorageConfig config) {
    if (isClosed) return;
    onChanged(config);
    emit(state.copyWith(config: config));
  }

  Future<void> load() => _perform(DriveAction.state);

  Future<void> startAuthorization() async {
    if (isClosed || state.busy) return;
    _authorizationTimer?.cancel();
    emit(state.copyWith(authorizationOpen: true, authorization: null));
    await _perform(DriveAction.startAuthorization);
    if (isClosed) return;
    if (!state.authorizationOpen) {
      final authorization = state.authorization;
      if (authorization?.status == DriveAuthorizationStatus.pending) {
        await _perform(DriveAction.cancelAuthorization, sessionId: authorization!.sessionId);
      }
      return;
    }
    _scheduleAuthorization();
  }

  Future<void> cancelAuthorization() async {
    _authorizationTimer?.cancel();
    if (isClosed) return;
    emit(state.copyWith(authorizationOpen: false));
    final authorization = state.authorization;
    if (authorization == null || authorization.status != DriveAuthorizationStatus.pending) return;
    await _perform(DriveAction.cancelAuthorization, sessionId: authorization.sessionId);
  }

  Future<void> disconnect(String accountId) => _perform(DriveAction.disconnectAccount, accountId: accountId);

  Future<void> syncNow() => _perform(DriveAction.syncNow);

  Future<void> setPaused(bool paused) => _perform(DriveAction.setPaused, paused: paused);

  void applicationConfigured(DriveResult result) {
    if (!isClosed) emit(state.copyWith(remote: result.state, failure: null));
  }

  Future<void> _perform(DriveAction action, {String? sessionId, String? accountId, bool? paused}) async {
    if (isClosed || state.busy) return;
    emit(state.copyWith(busy: true, failure: null));
    _log.info('event=started action=${action.name}');
    try {
      final result = await repository.request(action, sessionId: sessionId, accountId: accountId, paused: paused);
      if (isClosed) {
        if (action == DriveAction.startAuthorization &&
            result.authorization?.status == DriveAuthorizationStatus.pending) {
          _cancelSession(result.authorization!.sessionId);
        }
        return;
      }
      emit(
        state.copyWith(remote: result.state, authorization: result.authorization ?? state.authorization, busy: false),
      );
      _log.info('event=completed action=${action.name} accounts=${result.state.connections.length}');
      _scheduleRuntime();
    } catch (error) {
      if (isClosed) return;
      final failure = error is YandexPanelFailure ? error.kind : YandexPanelFailureKind.load;
      emit(state.copyWith(busy: false, failure: failure));
      _log.warning(
        'event=${failure == YandexPanelFailureKind.outcomeUnknown ? 'outcomeUnknown' : 'failed'} action=${action.name} type=${error.runtimeType}',
      );
    }
  }

  void _scheduleAuthorization() {
    _authorizationTimer?.cancel();
    final authorization = state.authorization;
    if (isClosed ||
        !state.authorizationOpen ||
        authorization == null ||
        authorization.status != DriveAuthorizationStatus.pending ||
        state.failure != null) {
      return;
    }
    _authorizationTimer = Timer(const Duration(seconds: 2), () => _readAuthorization(authorization.sessionId));
  }

  Future<void> refreshAuthorization() async {
    final session = state.authorization;
    if (session != null) await _readAuthorization(session.sessionId);
  }

  Future<void> _readAuthorization(String sessionId) async {
    if (isClosed || !state.authorizationOpen || state.authorization?.sessionId != sessionId) return;
    if (state.busy) {
      _scheduleAuthorization();
      return;
    }
    try {
      final result = await repository.request(DriveAction.authorization, sessionId: sessionId);
      if (isClosed || !state.authorizationOpen || state.authorization?.sessionId != sessionId) return;
      final previous = state.authorization?.status;
      emit(
        state.copyWith(remote: result.state, authorization: result.authorization ?? state.authorization, failure: null),
      );
      if (state.authorization?.status != previous) {
        _log.info('event=authorizationChanged status=${state.authorization?.status.name}');
      }
      _scheduleAuthorization();
    } catch (error) {
      if (isClosed || !state.authorizationOpen || state.authorization?.sessionId != sessionId) return;
      emit(state.copyWith(failure: error is YandexPanelFailure ? error.kind : YandexPanelFailureKind.load));
      _log.warning('event=authorizationReadFailed type=${error.runtimeType}');
    }
  }

  void _scheduleRuntime() {
    _runtimeTimer?.cancel();
    if (isClosed || state.remote?.runtime.running != true) return;
    _runtimeTimer = Timer(_runtimePollInterval, _readRuntime);
  }

  Future<void> _readRuntime() async {
    if (isClosed) return;
    if (state.busy) {
      _scheduleRuntime();
      return;
    }
    final observedRemote = state.remote;
    try {
      final result = await repository.request(DriveAction.state);
      if (isClosed || state.busy || state.failure != null || !identical(state.remote, observedRemote)) return;
      emit(state.copyWith(remote: result.state));
      _scheduleRuntime();
    } catch (error) {
      if (isClosed || state.busy || state.failure != null || !identical(state.remote, observedRemote)) return;
      emit(state.copyWith(failure: error is YandexPanelFailure ? error.kind : YandexPanelFailureKind.load));
      _log.warning('event=runtimeReadFailed type=${error.runtimeType}');
    }
  }

  @override
  Future<void> close() async {
    _authorizationTimer?.cancel();
    _runtimeTimer?.cancel();
    final authorization = state.authorization;
    if (authorization?.status == DriveAuthorizationStatus.pending) {
      _cancelSession(authorization!.sessionId);
    }
    await super.close();
  }

  void _cancelSession(String sessionId) {
    unawaited(
      repository
          .request(DriveAction.cancelAuthorization, sessionId: sessionId)
          .then<void>(
            (_) {},
            onError: (Object error) {
              _log.warning('event=authorizationCancelOutcomeUnknown type=${error.runtimeType}');
            },
          ),
    );
  }
}

@freezed
abstract class YandexFolderState with _$YandexFolderState {
  const factory YandexFolderState({
    @Default('disk:/') String path,
    DriveFolderPage? page,
    @Default(0) int offset,
    @Default(<String>{}) Set<String> selected,
    @Default(<int>[]) List<int> previousOffsets,
    @Default(false) bool busy,
    YandexPanelFailureKind? failure,
  }) = _YandexFolderState;
}

/// Retains one page of directories; it never expands the entire Disk eagerly.
class YandexFolderCubit extends Cubit<YandexFolderState> {
  YandexFolderCubit({required this.repository, required this.accountId, required List<String> selected})
    : super(YandexFolderState(selected: selected.toSet()));

  static final _log = Logger('YandexFolderCubit');
  final YandexDriveRepository repository;
  final String accountId;

  Future<void> open(String path) => _load(path, 0, const []);
  Future<void> retry() => _load(state.path, state.offset, state.previousOffsets);

  Future<void> nextPage() async {
    final page = state.page;
    if (page?.nextOffset == null) return;
    await _load(state.path, page!.nextOffset!, [...state.previousOffsets, page.offset]);
  }

  Future<void> previousPage() async {
    if (state.previousOffsets.isEmpty) return;
    final offsets = state.previousOffsets.toList();
    final offset = offsets.removeLast();
    await _load(state.path, offset, offsets);
  }

  Future<void> parent() async {
    if (state.path == 'disk:/') return;
    final slash = state.path.lastIndexOf('/');
    final path = state.path.substring(0, slash);
    await open(path == 'disk:' ? 'disk:/' : path);
  }

  void select(String path, bool selected) {
    final paths = state.selected.toSet();
    if (selected) {
      paths.removeWhere((item) => item.startsWith(path.endsWith('/') ? path : '$path/'));
      paths.add(path);
    } else {
      paths.remove(path);
    }
    emit(state.copyWith(selected: paths));
  }

  bool selectedByParent(String path) => state.selected.any(
    (selected) => path != selected && path.startsWith(selected.endsWith('/') ? selected : '$selected/'),
  );

  Future<void> _load(String path, int offset, List<int> previousOffsets) async {
    if (isClosed || state.busy) return;
    emit(
      state.copyWith(
        path: path,
        page: null,
        offset: offset,
        previousOffsets: previousOffsets,
        busy: true,
        failure: null,
      ),
    );
    try {
      final result = await repository.request(DriveAction.folders, accountId: accountId, path: path, offset: offset);
      if (isClosed) return;
      final page = result.folderPage;
      if (page == null) throw const YandexPanelFailure(YandexPanelFailureKind.load);
      emit(state.copyWith(page: page, previousOffsets: previousOffsets, busy: false));
      _log.fine('event=pageLoaded folders=${page.folders.length} hasNext=${page.nextOffset != null}');
    } catch (error) {
      if (isClosed) return;
      emit(
        state.copyWith(busy: false, failure: error is YandexPanelFailure ? error.kind : YandexPanelFailureKind.load),
      );
      _log.warning('event=pageFailed type=${error.runtimeType}');
    }
  }
}

@freezed
abstract class YandexApplicationState with _$YandexApplicationState {
  const factory YandexApplicationState({
    required String clientId,
    @Default(false) bool busy,
    YandexPanelFailureKind? failure,
  }) = _YandexApplicationState;
}

class YandexApplicationCubit extends Cubit<YandexApplicationState> {
  YandexApplicationCubit({required this.repository, required String clientId})
    : super(YandexApplicationState(clientId: clientId));
  final YandexDriveRepository repository;
  static final _log = Logger('YandexApplicationCubit');
  String _secret = '';

  void setClientId(String value) => emit(state.copyWith(clientId: value));
  void setSecret(String value) => _secret = value;

  Future<DriveResult?> save() async {
    if (isClosed || state.busy || state.clientId.trim().isEmpty) return null;
    emit(state.copyWith(busy: true, failure: null));
    _log.info('event=started action=configureApplication');
    try {
      final result = await repository.request(
        DriveAction.configureApplication,
        clientId: state.clientId.trim(),
        clientSecret: _secret,
      );
      _secret = '';
      if (!isClosed) emit(state.copyWith(busy: false));
      _log.info('event=completed action=configureApplication');
      return result;
    } catch (error) {
      _log.warning('event=failed action=configureApplication type=${error.runtimeType}');
      if (!isClosed) {
        emit(
          state.copyWith(busy: false, failure: error is YandexPanelFailure ? error.kind : YandexPanelFailureKind.load),
        );
      }
      return null;
    }
  }

  @override
  Future<void> close() {
    _secret = '';
    return super.close();
  }
}
