import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:dbus/dbus.dart';
import 'package:dslideshow_common/frame_discovery.dart';
import 'package:logging/logging.dart';

import 'frame_publisher.dart';

class AvahiFrameDiscoveryProvider implements FrameDiscoveryProvider {
  const AvahiFrameDiscoveryProvider();

  @override
  FrameDiscoverySession createSession() => AvahiFrameDiscoverySession(bus: DBusClient.system());
}

typedef _Service = ({int interface, int protocol, String name, String type, String domain});

class AvahiFrameDiscoverySession implements FrameDiscoverySession {
  AvahiFrameDiscoverySession({required DBusClient bus}) : _bus = bus;

  static final _log = Logger('AvahiDiscovery');
  final DBusClient _bus;
  final _updates = StreamController<FrameDiscoveryUpdate>();
  final _subscriptions = <StreamSubscription<DBusSignal>>[];
  final _services = <_Service>{};
  final _pending = Queue<_Service>();
  final _resolved = <_Service, DiscoveredFrame>{};
  DBusRemoteObject? _browser;
  int _resolving = 0;
  bool _closed = false;
  final _cancelled = Completer<void>();

  @override
  Stream<FrameDiscoveryUpdate> get updates => _updates.stream;

  DBusRemoteObject get _server => DBusRemoteObject(_bus, name: avahiBusName, path: DBusObjectPath('/'));

  Future<DBusMethodSuccessResponse> _call(
    DBusRemoteObject object,
    String interface,
    String method,
    Iterable<DBusValue> values, {
    DBusSignature? replySignature,
  }) => avahiCall(object, interface, method, values, replySignature: replySignature, cancelled: _cancelled.future);

  @override
  Future<void> start() async {
    final result = await _call(_server, '$avahiBusName.Server2', 'ServiceBrowserPrepare', [
      const DBusInt32(-1),
      const DBusInt32(0),
      const DBusString(frameServiceType),
      const DBusString('local'),
      const DBusUint32(0),
    ], replySignature: DBusSignature('o'));
    if (_closed) return;
    final browser = DBusRemoteObject(_bus, name: avahiBusName, path: result.returnValues.single as DBusObjectPath);
    _browser = browser;
    for (final name in ['ItemNew', 'ItemRemove', 'Failure']) {
      _subscriptions.add(
        DBusRemoteObjectSignalStream(object: browser, interface: '$avahiBusName.ServiceBrowser', name: name).listen(
          (signal) {
            if (_closed) return;
            if (name == 'Failure') {
              _updates.addError(StateError('Avahi discovery failed'));
              return;
            }
            final values = signal.values;
            final service = (
              interface: values[0].asInt32(),
              protocol: values[1].asInt32(),
              name: values[2].asString(),
              type: values[3].asString(),
              domain: values[4].asString(),
            );
            if (name == 'ItemRemove') {
              _services.remove(service);
              _pending.removeWhere((pending) => pending == service);
              _resolved.remove(service);
              _emitService(service);
            } else if (_services.length >= 256 && !_services.contains(service)) {
              _updates.add(const FrameDiscoveryUpdate.limited());
            } else if (_services.add(service)) {
              _pending.add(service);
              _resolvePending();
            }
          },
          onError: (Object error) {
            if (!_closed) _updates.addError(error);
          },
        ),
      );
    }
    await _call(browser, '$avahiBusName.ServiceBrowser', 'Start', [], replySignature: DBusSignature(''));
  }

  String _key(_Service service) => '${service.name}.${service.type}.${service.domain}';

  void _emitService(_Service service) {
    final key = _key(service);
    final matches = _resolved.entries.where((entry) => _key(entry.key) == key);
    if (matches.isEmpty) {
      _updates.add(FrameDiscoveryUpdate.lost(key));
    } else {
      _updates.add(FrameDiscoveryUpdate.resolved(matches.first.value));
    }
  }

  void _resolvePending() {
    while (!_closed && _resolving < 4 && _pending.isNotEmpty) {
      final service = _pending.removeFirst();
      if (!_services.contains(service)) continue;
      _resolving++;
      unawaited(
        _resolve(service).whenComplete(() {
          _resolving--;
          _resolvePending();
        }),
      );
    }
  }

  Future<void> _resolve(_Service service) async {
    try {
      final result = await _call(_server, '$avahiBusName.Server', 'ResolveService', [
        DBusInt32(service.interface),
        DBusInt32(service.protocol),
        DBusString(service.name),
        DBusString(service.type),
        DBusString(service.domain),
        const DBusInt32(0),
        const DBusUint32(0),
      ], replySignature: DBusSignature('iissssisqaayu'));
      if (_closed || !_services.contains(service)) return;
      final values = result.returnValues;
      final address = values[7].asString();
      final port = values[8].asUint16();
      if (InternetAddress.tryParse(address)?.type != InternetAddressType.IPv4 || port == 0) {
        _log.warning('action=resolve result=failed reason=invalid-endpoint');
        _updates.add(const FrameDiscoveryUpdate.resolveFailed());
        return;
      }
      _resolved[service] = DiscoveredFrame(
        serviceKey: _key(service),
        hostname: values[5].asString().isEmpty ? service.name : values[5].asString(),
        address: address,
        port: port,
      );
      _emitService(service);
      _log.fine('action=resolve result=completed');
    } catch (error) {
      if (!_closed) {
        final code = error is DBusMethodResponseException ? error.errorName : error.runtimeType;
        _log.warning('action=resolve result=failed type=${error.runtimeType} code=$code');
        _updates.add(const FrameDiscoveryUpdate.resolveFailed());
      }
    }
  }

  @override
  Future<void> close() async {
    _closed = true;
    _cancelled.complete();
    _pending.clear();
    try {
      for (final subscription in _subscriptions) {
        await subscription.cancel();
      }
      final browser = _browser;
      if (browser != null) {
        await avahiCall(browser, '$avahiBusName.ServiceBrowser', 'Free', [], replySignature: DBusSignature(''));
      }
    } finally {
      try {
        await _bus.close();
      } finally {
        await _updates.close();
      }
    }
  }
}
