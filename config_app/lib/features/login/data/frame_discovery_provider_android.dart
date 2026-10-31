import 'dart:async';

import 'package:dslideshow_common/frame_discovery.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';

enum _DiscoveryMessage { started, resolved, lost, limited, resolveFailed }

class AndroidFrameDiscoveryProvider implements FrameDiscoveryProvider {
  const AndroidFrameDiscoveryProvider({this.channel = const EventChannel('dslideshow/frame_discovery')});

  final EventChannel channel;

  @override
  FrameDiscoverySession createSession() => AndroidFrameDiscoverySession(channel: channel);
}

class AndroidFrameDiscoverySession implements FrameDiscoverySession {
  AndroidFrameDiscoverySession({required this.channel});

  static final _log = Logger('AndroidDiscovery');
  final EventChannel channel;
  final _updates = StreamController<FrameDiscoveryUpdate>();
  final _started = Completer<void>();
  StreamSubscription<Object?>? _subscription;

  @override
  Stream<FrameDiscoveryUpdate> get updates => _updates.stream;

  @override
  Future<void> start() async {
    _log.info('Discovery starting');
    _subscription = channel.receiveBroadcastStream().listen(
      _onMessage,
      onError: (Object error, StackTrace stack) {
        final code = error is PlatformException ? error.code : error.runtimeType;
        _log.warning('Discovery failed code=$code', error, stack);
        if (!_started.isCompleted) {
          _started.completeError(error);
        } else {
          _updates.addError(error);
        }
      },
    );
    await _started.future;
  }

  void _onMessage(Object? message) {
    try {
      if (message is! Map || message['type'] is! String) throw const FormatException('Invalid discovery message');
      final type = _DiscoveryMessage.values.byName(message['type'] as String);
      switch (type) {
        case _DiscoveryMessage.started:
          _log.info('Discovery started');
          _started.complete();
        case _DiscoveryMessage.resolved:
          final frame = DiscoveredFrame(
            serviceKey: message['serviceKey'] as String,
            hostname: message['hostname'] as String,
            address: message['address'] as String,
            port: message['port'] as int,
          );
          _updates.add(FrameDiscoveryUpdate.resolved(frame));
        case _DiscoveryMessage.lost:
          _updates.add(FrameDiscoveryUpdate.lost(message['serviceKey'] as String));
        case _DiscoveryMessage.limited:
          _updates.add(const FrameDiscoveryUpdate.limited());
        case _DiscoveryMessage.resolveFailed:
          _updates.add(const FrameDiscoveryUpdate.resolveFailed());
      }
    } catch (error) {
      _updates.addError(const FormatException('Invalid Android discovery response'));
    }
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    if (!_started.isCompleted) _started.complete();
    await _updates.close();
    _log.info('Discovery stopped');
  }
}
