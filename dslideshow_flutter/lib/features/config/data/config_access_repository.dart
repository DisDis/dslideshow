import 'dart:async';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';

/// Serializes access leases across successive openings of the config page.
class ConfigAccessRepository {
  ConfigAccessRepository({
    required this.frontend,
    required this.port,
    required this.alwaysEnabled,
  });

  final FrontendService frontend;
  final int port;
  final bool alwaysEnabled;
  Future<void> _tail = Future<void>.value();
  ConfigAccessSession? _owner;

  ConfigAccessSession createSession() {
    final session = ConfigAccessSession._(this);
    _owner = session;
    return session;
  }

  Future<T> _enqueue<T>(Future<T> Function() action) {
    final result = _tail.then((_) => action());
    _tail = result.then<void>((_) {}, onError: (Object _) {});
    return result;
  }

  Uri? addressFor(SystemInfo info) {
    for (final interface
        in info.networkInfo.interfaces ?? <NetworkInterfaceInfo>[]) {
      if (interface.status == NetworkInterfaceStatus.running &&
          interface.ip4.isNotEmpty &&
          !interface.ip4.startsWith('127.')) {
        return Uri(scheme: 'http', host: interface.ip4, port: port);
      }
    }
    return null;
  }
}

class ConfigAccessSession {
  ConfigAccessSession._(this._repository);
  final ConfigAccessRepository _repository;
  Future<String>? _start;
  Future<void>? _release;
  bool _released = false;

  Future<String> start() {
    if (_released) return Future.error(StateError('Config access released'));
    return _start ??= _repository._enqueue(() async {
      if (_released) throw StateError('Config access released');
      try {
        final code = await _repository.frontend.startWebServer();
        if (code.trim().isEmpty) throw StateError('Missing access code');
        return code;
      } catch (_) {
        _start = null;
        rethrow;
      }
    });
  }

  Future<void> release() {
    _released = true;
    return _release ??= _repository._enqueue(() async {
      try {
        // A newer page owns the server already; old cleanup cannot disable it.
        if (_repository._owner != this) return;
        await _repository.frontend.stopWebServer();
        if (_repository._owner == this) _repository._owner = null;
      } catch (_) {
        _release = null;
        rethrow;
      }
    });
  }
}
