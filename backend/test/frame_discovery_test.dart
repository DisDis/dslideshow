import 'dart:async';
import 'dart:convert';

import 'package:dbus/dbus.dart';
import 'package:dslideshow_backend/discovery.dart';
import 'package:dslideshow_common/frame_discovery.dart';
import 'package:logging/logging.dart';
import 'package:fake_async/fake_async.dart';
import 'package:test/test.dart';

import 'helpers/capture_logs.dart';
import 'support/fake_avahi.dart';

void main() {
  late FakeAvahi avahi;
  setUp(() async {
    avahi = FakeAvahi();
    await avahi.open();
  });
  tearDown(() => avahi.close());

  test('service resolution accepts a cold reply after three seconds while control calls remain bounded', () async {
    final client = DBusClient(avahi.address);
    addTearDown(client.close);
    fakeAsync((clock) {
      final resolver = _DeferredRemoteObject(client);
      DBusMethodSuccessResponse? reply;
      Object? failure;
      avahiCall(resolver, 'org.freedesktop.Avahi.Server', 'ResolveService', []).then<void>(
        (value) {
          reply = value;
        },
        onError: (Object error) {
          failure = error;
        },
      );
      clock.elapse(const Duration(seconds: 4));
      expect(reply, isNull);
      expect(failure, isNull, reason: 'A cold Avahi resolver must get its full five-second lookup window');
      resolver.reply.complete(DBusMethodSuccessResponse([]));
      clock.flushMicrotasks();
      expect(reply, isNotNull);
      expect(failure, isNull);
      expect(clock.pendingTimers, isEmpty);
    });
    for (final (method, timeout) in [('GetHostName', avahiControlTimeout), ('ResolveService', avahiResolveTimeout)]) {
      fakeAsync((clock) {
        final remote = _DeferredRemoteObject(client);
        Object? failure;
        avahiCall(remote, 'org.freedesktop.Avahi.Server', method, []).then<void>(
          (_) {},
          onError: (Object error) {
            failure = error;
          },
        );
        clock.elapse(timeout);
        expect(failure, isA<TimeoutException>(), reason: method);
        remote.reply.complete(DBusMethodSuccessResponse([]));
        clock.flushMicrotasks();
        expect(clock.pendingTimers, isEmpty);
      });
    }
  });

  test(
    'publisher sends the SRV port with no secrets and releases its D-Bus connection',
    () => captureLogs((logs) async {
      final buses = <TrackingBus>[];
      final publisher = AvahiFramePublisher(
        createBus: () {
          final bus = TrackingBus(avahi.address);
          buses.add(bus);
          return bus;
        },
      );
      await publisher.publish(9091);
      await publisher.publish(9091);
      expect(avahi.additions, hasLength(1));
      final record = avahi.additions.single;
      expect(record[4], const DBusString('_dslideshow._tcp'));
      expect(record[7], const DBusUint16(9091));
      expect(record[8].asArray(), isEmpty);
      await publisher.unpublish();
      expect(avahi.freedGroups, 1);
      expect(buses.single.closes, 1);
      await publisher.publish(8088);
      expect(avahi.additions.last[7], const DBusUint16(8088));
      await publisher.close();
      expect(buses.every((bus) => bus.closes == 1), isTrue);
      expect(logs.map((r) => r.message).join('\n'), contains('Advertisement removed'));
    }),
  );

  test('name collision gets a different instance name without changing the port', () async {
    avahi.collisions = 1;
    final publisher = AvahiFramePublisher(createBus: () => DBusClient(avahi.address));
    addTearDown(publisher.close);
    await publisher.publish(9099);
    expect(avahi.additions.map((v) => v[3].asString()).toSet(), hasLength(2));
    expect(avahi.additions.every((v) => v[7].asUint16() == 9099), isTrue);
  });

  test('long service instance names respect the DNS-SD UTF-8 byte limit', () async {
    avahi.hostname = List.filled(40, '界').join();
    final publisher = AvahiFramePublisher(createBus: () => DBusClient(avahi.address));
    addTearDown(publisher.close);
    await publisher.publish(9091);
    final name = avahi.additions.single[3].asString();
    expect(name, startsWith('DSlideshow '));
    expect(utf8.encode(name).length, lessThanOrEqualTo(63));
    expect(name, isNot(contains('\uFFFD')));
  });

  test('closing during browser initialization settles start and closes the owned connection', () async {
    avahi.prepareGate = Completer<void>();
    final bus = TrackingBus(avahi.address);
    final session = AvahiFrameDiscoverySession(bus: bus);
    final subscription = session.updates.listen((_) {});
    final started = expectLater(session.start(), throwsStateError);
    await avahi.prepareStarted.future;
    await subscription.cancel();
    await session.close();
    await started;
    expect(bus.closes, 1);
    avahi.prepareGate!.complete();
  });

  test('invalid port and IPv6-only answers never become a default IPv4 endpoint', () async {
    for (final invalid in [(0, '192.0.2.9'), (9091, 'fe80::1')]) {
      avahi.responsePort = invalid.$1;
      avahi.responseAddress = invalid.$2;
      final session = AvahiFrameDiscoverySession(bus: DBusClient(avahi.address));
      final next = _endpoints(session).first;
      await session.start();
      await avahi.announce('Frame A');
      expect(await next, const FrameDiscoveryUpdate.resolveFailed());
      await session.close();
    }
  });

  test('discovery resolves IPv4 and custom port, merges interfaces and removes only the last address', () async {
    final bus = TrackingBus(avahi.address);
    final session = AvahiFrameDiscoverySession(bus: bus);
    final updates = StreamIterator(_endpoints(session));
    await session.start();
    await avahi.announce('Frame A');
    expect(await updates.moveNext(), isTrue);
    final first = (updates.current as FrameResolved).frame;
    expect(first.hostname, 'test-frame.local');
    expect(first.connectUri.toString(), 'ws://192.0.2.9:9091/ws');
    await avahi.announce('Frame A', interface: 2);
    await updates.moveNext();
    expect((updates.current as FrameResolved).frame.serviceKey, first.serviceKey);
    await avahi.announce('Frame A', remove: true);
    await updates.moveNext();
    expect(updates.current, isA<FrameResolved>());
    await avahi.announce('Frame A', remove: true, interface: 2);
    await updates.moveNext();
    expect(updates.current, FrameDiscoveryUpdate.lost(first.serviceKey));
    await updates.cancel();
    await session.close();
    expect(avahi.freedBrowsers, 1);
    expect(bus.closes, 1);
  });

  test(
    'non-timeout resolve failure is reported once with its original error and stack',
    () => captureLogs((logs) async {
      avahi.failResolve = true;
      final session = AvahiFrameDiscoverySession(bus: DBusClient(avahi.address));
      final next = _endpoints(session).first;
      await session.start();
      await avahi.announce('Frame A');
      expect(await next, const FrameDiscoveryUpdate.resolveFailed());
      expect(avahi.resolutions, ['Frame A']);
      await session.close();
      final failures = logs.where((record) => record.loggerName == 'AvahiDiscovery' && record.level == Level.WARNING);
      expect(failures, hasLength(1));
      expect(failures.single.message, contains('code=org.freedesktop.DBus.Error.Failed'));
      expect(failures.single.message, isNot(contains('elapsedMs=')));
      expect(failures.single.error.toString(), contains('private-resolve-payload'));
      expect(failures.single.stackTrace.toString(), contains('DBusClient._callMethod'));
    }),
  );

  test('discovery does not require an unused TXT record to resolve the endpoint', () async {
    avahi.hasTxtRecord = false;
    final session = AvahiFrameDiscoverySession(bus: DBusClient(avahi.address));
    final updates = StreamIterator(_endpoints(session));
    addTearDown(() async {
      await updates.cancel();
      await session.close();
    });
    await session.start();
    await avahi.announce('Frame A');
    await updates.moveNext();
    expect((updates.current as FrameResolved).frame.connectUri.toString(), 'ws://192.0.2.9:9091/ws');
    expect(avahi.resolutions, ['Frame A']);
  });

  test(
    'Avahi timeout retries once and publishes only the recovered endpoint',
    () => captureLogs((logs) async {
      avahi.resolveTimeouts = 1;
      final session = AvahiFrameDiscoverySession(bus: DBusClient(avahi.address));
      final updates = StreamIterator(session.updates);
      addTearDown(() async {
        await updates.cancel();
        await session.close();
      });
      await session.start();
      await avahi.announce('Frame A');
      await updates.moveNext();
      expect(updates.current, const FrameDiscoveryUpdate.pending(1));
      await updates.moveNext();
      expect((updates.current as FrameResolved).frame.connectUri.toString(), 'ws://192.0.2.9:9091/ws');
      await updates.moveNext();
      expect(updates.current, const FrameDiscoveryUpdate.pending(0));
      expect(avahi.resolutions, ['Frame A', 'Frame A']);
      final retry = logs.singleWhere((record) => record.message.contains('result=retrying'));
      expect(retry.message, contains('service=Frame A._dslideshow._tcp.local'));
      expect(retry.message, contains('interface=1 protocol=0'));
      expect(retry.error, isA<DBusMethodResponseException>());
      expect(retry.error.toString(), contains('org.freedesktop.Avahi.TimeoutError: Timeout reached'));
      expect(retry.stackTrace.toString(), contains('DBusClient._callMethod'));
      expect(logs.any((record) => record.message.contains('result=recovered')), isTrue);
      expect(logs.any((record) => record.message.contains('result=failed')), isFalse);
    }),
  );

  test(
    'persistent Avahi timeout reports one failed endpoint after at most two calls',
    () => captureLogs((logs) async {
      avahi.resolveTimeouts = 2;
      final session = AvahiFrameDiscoverySession(bus: DBusClient(avahi.address));
      final updates = StreamIterator(_endpoints(session));
      addTearDown(() async {
        await updates.cancel();
        await session.close();
      });
      await session.start();
      await avahi.announce('Frame A');
      await updates.moveNext();
      expect(updates.current, const FrameDiscoveryUpdate.resolveFailed());
      expect(avahi.resolutions, ['Frame A', 'Frame A']);
      final failures = logs.where((record) => record.level == Level.WARNING).toList();
      expect(failures, hasLength(2));
      expect(failures.first.message, contains('result=retrying'));
      expect(failures.last.message, contains('result=failed'));
      for (final failure in failures) {
        expect(failure.error.toString(), contains('Timeout reached'));
        expect(failure.stackTrace.toString(), contains('DBusClient._callMethod'));
      }
    }),
  );

  test('removing a service during resolve prevents a timeout retry and stale failure', () async {
    avahi.resolveTimeouts = 1;
    avahi.resolveGate = Completer<void>();
    final started = Completer<void>();
    avahi.onResolveStarted = () {
      if (!started.isCompleted) started.complete();
    };
    final session = AvahiFrameDiscoverySession(bus: DBusClient(avahi.address));
    final updates = StreamIterator(_endpoints(session));
    addTearDown(() async {
      await updates.cancel();
      await session.close();
    });
    await session.start();
    await avahi.announce('Frame A');
    await started.future;
    await avahi.announce('Frame A', remove: true);
    await updates.moveNext();
    expect(updates.current, const FrameDiscoveryUpdate.lost('Frame A._dslideshow._tcp.local'));
    avahi.resolveGate!.complete();
    await avahi.announce('Frame B');
    await updates.moveNext();
    expect((updates.current as FrameResolved).frame.serviceKey, 'Frame B._dslideshow._tcp.local');
    expect(avahi.resolutions, ['Frame A', 'Frame B']);
  });

  test(
    'closing during the timeout retry cancels it without another failure or connection leak',
    () => captureLogs((logs) async {
      avahi.resolveTimeouts = 1;
      final retryStarted = Completer<void>();
      final retryGate = Completer<void>();
      avahi.onResolveStarted = () {
        if (avahi.resolutions.length == 2) {
          avahi.resolveGate = retryGate;
          retryStarted.complete();
        }
      };
      final bus = TrackingBus(avahi.address);
      final session = AvahiFrameDiscoverySession(bus: bus);
      final updates = <FrameDiscoveryUpdate>[];
      final subscription = _endpoints(session).listen(updates.add);
      await session.start();
      await avahi.announce('Frame A');
      await retryStarted.future;
      await subscription.cancel();
      await session.close();
      retryGate.complete();
      expect(avahi.resolutions, ['Frame A', 'Frame A']);
      expect(updates, isEmpty);
      expect(bus.closes, 1);
      expect(avahi.freedBrowsers, 1);
      expect(logs.where((record) => record.level == Level.WARNING), hasLength(1));
      expect(logs.any((record) => record.message.contains('result=cancelled')), isTrue);
      expect(logs.any((record) => record.message.contains('result=failed')), isFalse);
    }),
  );

  test('pending resolves are bounded and closing cancels the owned transport', () async {
    avahi.resolveGate = Completer<void>();
    final resolvesStarted = Completer<void>();
    avahi.onResolveStarted = () {
      if (avahi.activeResolves == 4 && !resolvesStarted.isCompleted) resolvesStarted.complete();
    };
    final bus = TrackingBus(avahi.address);
    final session = AvahiFrameDiscoverySession(bus: bus);
    final subscription = session.updates.listen((_) {});
    await session.start();
    for (var i = 0; i < 10; i++) {
      await avahi.announce('Frame $i');
    }
    // Signals and method calls use separate connections. A control reply alone
    // does not prove that the fake has received the four resolver calls.
    await resolvesStarted.future.timeout(const Duration(seconds: 3));
    final barrier = DBusRemoteObject(bus, name: 'org.freedesktop.Avahi', path: DBusObjectPath('/'));
    await barrier.callMethod('org.freedesktop.Avahi.Server', 'GetHostName', []);
    expect(avahi.maxActiveResolves, 4);
    await subscription.cancel();
    await session.close();
    expect(bus.closes, 1);
    avahi.resolveGate!.complete();
  });
}

Stream<FrameDiscoveryUpdate> _endpoints(FrameDiscoverySession session) =>
    session.updates.where((update) => update is! FrameDiscoveryPending);

class _DeferredRemoteObject extends DBusRemoteObject {
  _DeferredRemoteObject(DBusClient client) : super(client, name: 'org.freedesktop.Avahi', path: DBusObjectPath('/'));
  final reply = Completer<DBusMethodSuccessResponse>();

  @override
  Future<DBusMethodSuccessResponse> callMethod(
    String? interface,
    String name,
    Iterable<DBusValue> values, {
    DBusSignature? replySignature,
    bool noReplyExpected = false,
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) => reply.future;
}
