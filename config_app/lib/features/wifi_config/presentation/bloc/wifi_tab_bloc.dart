import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_event.dart';
import 'package:config_app/features/wifi_config/presentation/bloc/wifi_tab_state.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:logging/logging.dart';

enum _WifiAction { load, add, remove, rescan }

class _WifiWaitCancelled implements Exception {
  const _WifiWaitCancelled();
}

class WifiTabBloc extends Bloc<WifiTabEvent, WifiTabState> {
  static final _log = Logger('WifiTabBloc');
  final RealtimeService client;
  final Duration requestTimeout;
  final _waiters = <void Function()>{};
  bool _pending = false;
  bool _closing = false;
  int _generation = 0;
  int? _acknowledgedGeneration;

  WifiTabBloc({
    required WifiTabState initialState,
    required this.client,
    this.requestTimeout = const Duration(seconds: 65),
  }) : super(initialState) {
    if (requestTimeout <= Duration.zero) {
      throw ArgumentError.value(requestTimeout, 'requestTimeout', 'Must be positive');
    }
    on<LoadWifiTabEvent>((event, emit) => _perform(_WifiAction.load, emit, _updateData));
    on<AddWifiTabEvent>(
      (event, emit) => _perform(_WifiAction.add, emit, (generation, emit) async {
        await _send<EmptyResult>(
          WiFiAddCommand(id: RpcCommand.generateId(), name: event.name, SSID: event.SSID, psk: event.psk),
        );
        _acknowledged(generation, _WifiAction.add);
        if (_isCurrent(generation, emit)) await _updateData(generation, emit);
      }),
    );
    on<RemoveWifiTabEvent>(
      (event, emit) => _perform(_WifiAction.remove, emit, (generation, emit) async {
        await _send<EmptyResult>(WiFiRemoveCommand(id: RpcCommand.generateId(), connectionId: event.connectionId));
        _acknowledged(generation, _WifiAction.remove);
        if (_isCurrent(generation, emit)) await _updateData(generation, emit);
      }),
    );
    // The existing enable action only refreshes the data; no enable RPC exists.
    on<EnableWifiTabEvent>((event, emit) => _perform(_WifiAction.load, emit, _updateData));
    on<RescanWifiTabEvent>(
      (event, emit) => _perform(_WifiAction.rescan, emit, (generation, emit) async {
        await _send<EmptyResult>(WiFiRescanCommand(id: RpcCommand.generateId()));
        _acknowledged(generation, _WifiAction.rescan);
        if (_isCurrent(generation, emit)) await _updateData(generation, emit);
      }),
    );
  }

  Future<void> _perform(
    _WifiAction action,
    Emitter<WifiTabState> emit,
    Future<void> Function(int, Emitter<WifiTabState>) operation,
  ) async {
    if (_closing || _pending) return;
    _pending = true;
    final generation = ++_generation;
    _log.info('event=started action=${action.name}');
    emit(const UnWifiTabState());
    try {
      await operation(generation, emit);
      if (_isCurrent(generation, emit)) {
        _log.info('event=completed action=${action.name}');
      }
    } catch (error) {
      if (error is _WifiWaitCancelled || !_isCurrent(generation, emit)) {
        _log.info('event=cancelled action=${action.name}');
        return;
      }
      final kind = _acknowledgedGeneration == generation
          ? WifiFailureKind.refresh
          : error is RpcErrorResultException
          ? WifiFailureKind.rejected
          : WifiFailureKind.unknown;
      final event = switch (kind) {
        WifiFailureKind.rejected => 'failed',
        WifiFailureKind.unknown => 'outcomeUnknown',
        WifiFailureKind.refresh => 'refreshFailed',
      };
      _log.warning(
        'event=$event '
        'action=${kind == WifiFailureKind.refresh ? _WifiAction.load.name : action.name} '
        '${kind == WifiFailureKind.refresh ? 'sourceAction=${action.name} ' : ''}'
        'type=${error.runtimeType}',
      );
      // Only a confirmed backend rejection has a diagnostic message. Unknown
      // transport outcomes and refresh failures use localized view hints.
      emit(ErrorWifiTabState(kind == WifiFailureKind.rejected ? error.toString() : '', kind: kind));
    } finally {
      _pending = false;
    }
  }

  void _acknowledged(int generation, _WifiAction action) {
    if (_closing || generation != _generation) return;
    _acknowledgedGeneration = generation;
    _log.info('event=acknowledged action=${action.name}');
  }

  Future<T> _send<T extends RpcResult>(RpcCommand command) async {
    if (_closing) throw const _WifiWaitCancelled();
    final envelope = WSSendRpcCommand.byCommand(command);
    final response = await _wait(client.send(envelope, timeout: requestTimeout));
    if (response is! WSRpcResult) {
      throw StateError('Unexpected Wi-Fi RPC envelope');
    }
    final result = serializers.deserialize(response.resultData);
    if (result is RpcErrorResult) throw RpcErrorResultException(result);
    if (result is! T) throw StateError('Unexpected Wi-Fi RPC result');
    return result;
  }

  Future<void> _updateData(int generation, Emitter<WifiTabState> emit) async {
    // Observe both operations immediately, including the second error if the
    // first has already failed. No successful refresh precedes mutation ack.
    final results = await Future.wait<RpcResult>([
      _send<WiFiListResult>(WiFiListCommand(id: RpcCommand.generateId())),
      _send<WiFiGetConnectionsResult>(WiFiGetConnectionsCommand(id: RpcCommand.generateId())),
    ]);
    if (!_isCurrent(generation, emit)) return;
    emit(
      InWifiTabState(
        availableNetworks: (results[0] as WiFiListResult).networks,
        connections: (results[1] as WiFiGetConnectionsResult).networks,
      ),
    );
  }

  bool _isCurrent(int generation, Emitter<WifiTabState> emit) => !_closing && !emit.isDone && generation == _generation;

  Future<T> _wait<T>(Future<T> operation) {
    final result = Completer<T>();
    void cancelled() {
      if (!result.isCompleted) result.completeError(const _WifiWaitCancelled());
    }

    if (_closing) {
      cancelled();
    } else {
      _waiters.add(cancelled);
    }
    unawaited(
      operation.then<void>(
        (value) {
          _waiters.remove(cancelled);
          if (!result.isCompleted) result.complete(value);
        },
        onError: (Object error, StackTrace stack) {
          _waiters.remove(cancelled);
          if (!result.isCompleted) result.completeError(error, stack);
        },
      ),
    );
    return result.future;
  }

  @override
  Future<void> close() async {
    _closing = true;
    _generation++;
    for (final cancel in _waiters) {
      cancel();
    }
    _waiters.clear();
    await super.close();
  }
}
