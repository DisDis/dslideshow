import 'dart:async';

import 'package:config_app/features/login/data/frame_discovery_provider_android.dart';
import 'package:dslideshow_common/frame_discovery.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = EventChannel('test/discovery');
  const codec = StandardMethodCodec();
  final messenger = TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  late Completer<void> listening;
  late int cancelled;

  Future<void> send(ByteData data) async {
    final done = Completer<void>();
    messenger.handlePlatformMessage(channel.name, data, (_) => done.complete());
    await done.future;
  }

  setUp(() {
    listening = Completer<void>();
    cancelled = 0;
    messenger.setMockMethodCallHandler(MethodChannel(channel.name), (call) async {
      if (call.method == 'listen') listening.complete();
      if (call.method == 'cancel') cancelled++;
      return null;
    });
  });
  tearDown(() => messenger.setMockMethodCallHandler(MethodChannel(channel.name), null));

  test('waits for native start, forwards discoveries/loss/partial results and releases NSD', () async {
    final session = const AndroidFrameDiscoveryProvider(channel: channel).createSession();
    final updates = <FrameDiscoveryUpdate>[];
    final subscription = session.updates.listen(updates.add);
    final start = session.start();
    await listening.future;
    await send(codec.encodeSuccessEnvelope({'type': 'started'}));
    await start;
    await send(
      codec.encodeSuccessEnvelope({
        'type': 'resolved',
        'serviceKey': 'frame',
        'hostname': 'photoframe',
        'address': '192.0.2.8',
        'port': 9091,
      }),
    );
    await send(codec.encodeSuccessEnvelope({'type': 'lost', 'serviceKey': 'frame'}));
    await send(codec.encodeSuccessEnvelope({'type': 'limited'}));
    await send(codec.encodeSuccessEnvelope({'type': 'resolveFailed'}));
    await session.close();
    await subscription.cancel();
    expect((updates.first as FrameResolved).frame.connectUri.toString(), 'ws://192.0.2.8:9091/ws');
    expect(updates[1], const FrameDiscoveryUpdate.lost('frame'));
    expect(updates[2], const FrameDiscoveryUpdate.limited());
    expect(updates[3], const FrameDiscoveryUpdate.resolveFailed());
    expect(cancelled, 1);
  });

  test('start failure reports a safe diagnostic and still releases the native session', () async {
    final logs = <LogRecord>[];
    final logger = Logger.root.onRecord.listen(logs.add);
    addTearDown(logger.cancel);
    final session = const AndroidFrameDiscoveryProvider(channel: channel).createSession();
    final subscription = session.updates.listen((_) {});
    final failed = expectLater(session.start(), throwsA(isA<PlatformException>()));
    await listening.future;
    await send(codec.encodeErrorEnvelope(code: 'discovery_denied', message: 'secret URI must not be logged'));
    await failed;
    await session.close();
    await subscription.cancel();
    expect(cancelled, 1);
    final messages = logs.where((record) => record.loggerName == 'AndroidDiscovery').map((record) => record.message);
    expect(messages, contains('Discovery failed code=discovery_denied'));
    expect(messages.join(), isNot(contains('secret')));
  });
}
