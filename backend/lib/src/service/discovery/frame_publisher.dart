import 'dart:async';
import 'dart:convert';

import 'package:dbus/dbus.dart';
import 'package:dslideshow_common/frame_discovery.dart';
import 'package:logging/logging.dart';

abstract interface class FramePublisher {
  Future<void> publish(int port);
  Future<void> unpublish();
  Future<void> close();
}

class NoopFramePublisher implements FramePublisher {
  const NoopFramePublisher();

  @override
  Future<void> publish(int port) async {}
  @override
  Future<void> unpublish() async {}
  @override
  Future<void> close() async {}
}

const avahiBusName = 'org.freedesktop.Avahi';
const avahiControlTimeout = Duration(seconds: 3);
const avahiResolveTimeout = Duration(seconds: 6);

enum _GroupState { pending, established, collision, failure }

_GroupState _decodeGroupState(int value) => switch (value) {
  2 => _GroupState.established,
  3 => _GroupState.collision,
  4 => _GroupState.failure,
  _ => _GroupState.pending,
};

Future<DBusMethodSuccessResponse> avahiCall(
  DBusRemoteObject object,
  String interface,
  String method,
  Iterable<DBusValue> values, {
  DBusSignature? replySignature,
  Future<void>? cancelled,
}) {
  final result = Completer<DBusMethodSuccessResponse>();
  // Avahi's service resolver has its own five-second deadline.
  final timeout = interface == '$avahiBusName.Server' && method == 'ResolveService'
      ? avahiResolveTimeout
      : avahiControlTimeout;
  final timer = Timer(timeout, () {
    if (!result.isCompleted) result.completeError(TimeoutException('Avahi $method timed out'));
  });
  object
      .callMethod(interface, method, values, replySignature: replySignature)
      .then(
        (response) {
          if (!result.isCompleted) result.complete(response);
        },
        onError: (Object error, StackTrace stack) {
          if (!result.isCompleted) result.completeError(error, stack);
        },
      );
  cancelled?.then((_) {
    if (!result.isCompleted) result.completeError(StateError('Discovery cancelled'));
  });
  return result.future.whenComplete(timer.cancel);
}

class AvahiFramePublisher implements FramePublisher {
  AvahiFramePublisher({DBusClient Function()? createBus}) : _createBus = createBus ?? DBusClient.system;

  static final _log = Logger('FramePublisher');
  final DBusClient Function() _createBus;
  DBusClient? _bus;
  DBusRemoteObject? _group;

  @override
  Future<void> publish(int port) async {
    if (_group != null) return;
    _log.info('Advertisement publish started port=$port');
    final bus = _createBus();
    _bus = bus;
    final server = DBusRemoteObject(bus, name: avahiBusName, path: DBusObjectPath('/'));
    try {
      final hostname = await avahiCall(
        server,
        '$avahiBusName.Server',
        'GetHostName',
        [],
        replySignature: DBusSignature('s'),
      );
      final buffer = StringBuffer();
      var bytes = 0;
      for (final rune in 'DSlideshow ${hostname.returnValues.single.asString()}'.runes) {
        final character = String.fromCharCode(rune);
        bytes += utf8.encode(character).length;
        if (bytes > 63) break;
        buffer.write(character);
      }
      var name = buffer.toString();
      final created = await avahiCall(
        server,
        '$avahiBusName.Server',
        'EntryGroupNew',
        [],
        replySignature: DBusSignature('o'),
      );
      final group = DBusRemoteObject(bus, name: avahiBusName, path: created.returnValues.single as DBusObjectPath);
      _group = group;
      for (var attempt = 0; attempt < 3; attempt++) {
        final established = Completer<void>();
        final subscription =
            DBusRemoteObjectSignalStream(
              object: group,
              interface: '$avahiBusName.EntryGroup',
              name: 'StateChanged',
              signature: DBusSignature('is'),
            ).listen(
              (signal) {
                final state = _decodeGroupState(signal.values.first.asInt32());
                if (established.isCompleted) return;
                if (state == _GroupState.established) established.complete();
                if (state == _GroupState.collision) established.completeError(const _NameCollision());
                if (state == _GroupState.failure) established.completeError(StateError('Avahi registration failed'));
              },
              onError: (Object error) {
                if (!established.isCompleted) established.completeError(error);
              },
            );
        // Attach the error listener before issuing calls that can emit signals.
        final ready = established.future.timeout(const Duration(seconds: 3));
        final observed = ready.then<Object?>((_) => null, onError: (Object error) => error);
        try {
          await avahiCall(group, '$avahiBusName.EntryGroup', 'AddService', [
            const DBusInt32(-1),
            const DBusInt32(0),
            const DBusUint32(0),
            DBusString(name),
            const DBusString(frameServiceType),
            const DBusString('local'),
            const DBusString(''),
            DBusUint16(port),
            DBusArray(DBusSignature('ay'), []),
          ], replySignature: DBusSignature(''));
          await avahiCall(group, '$avahiBusName.EntryGroup', 'Commit', [], replySignature: DBusSignature(''));
          final failure = await observed;
          if (failure != null) throw failure;
          _log.info('Advertisement published port=$port');
          return;
        } catch (error, stack) {
          if (error is! _NameCollision &&
              !(error is DBusMethodResponseException && error.errorName == '$avahiBusName.CollisionError')) {
            rethrow;
          }
          await avahiCall(group, '$avahiBusName.EntryGroup', 'Reset', [], replySignature: DBusSignature(''));
          final alternative = await avahiCall(server, '$avahiBusName.Server', 'GetAlternativeServiceName', [
            DBusString(name),
          ], replySignature: DBusSignature('s'));
          name = alternative.returnValues.single.asString();
          _log.fine('Advertisement name collision retry=${attempt + 1}', error, stack);
        } finally {
          // Complete the observer as well if AddService/Commit failed early.
          if (!established.isCompleted) established.complete();
          await subscription.cancel();
        }
      }
      throw StateError('Avahi service name unavailable');
    } catch (error, stack) {
      _log.warning('Advertisement publish failed type=${error.runtimeType}', error, stack);
      await unpublish();
      rethrow;
    }
  }

  @override
  Future<void> unpublish() async {
    final group = _group;
    final bus = _bus;
    _group = null;
    _bus = null;
    try {
      if (group != null) {
        _log.info('Advertisement removal started');
        await avahiCall(group, '$avahiBusName.EntryGroup', 'Free', [], replySignature: DBusSignature(''));
        _log.info('Advertisement removed');
      }
    } finally {
      await bus?.close();
    }
  }

  @override
  Future<void> close() => unpublish();
}

class _NameCollision implements Exception {
  const _NameCollision();
}
