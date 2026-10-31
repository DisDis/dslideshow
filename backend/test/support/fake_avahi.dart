import 'dart:async';
import 'dart:io';

import 'package:dbus/dbus.dart';

class FakeAvahi extends DBusObject {
  FakeAvahi() : super(DBusObjectPath('/'));

  final server = DBusServer();
  late final Directory directory;
  late final DBusAddress address;
  late final DBusClient owner;
  late final _Object group;
  late final _Object browser;
  final additions = <List<DBusValue>>[];
  final resolutions = <String>[];
  int freedGroups = 0;
  int freedBrowsers = 0;
  int collisions = 0;
  bool failResolve = false;
  Completer<void>? resolveGate;
  int activeResolves = 0;
  int maxActiveResolves = 0;
  void Function()? onResolveStarted;
  String hostname = 'test-frame';
  int responsePort = 9091;
  String responseAddress = '192.0.2.9';
  final prepareStarted = Completer<void>();
  Completer<void>? prepareGate;

  Future<void> open() async {
    directory = await Directory.systemTemp.createTemp('avahi-wire-');
    address = await server.listenAddress(DBusAddress.unix(dir: directory));
    owner = DBusClient(address);
    await owner.requestName('org.freedesktop.Avahi');
    await owner.registerObject(this);
    group = _Object('/entry', (call) async {
      switch (call.name) {
        case 'AddService':
          additions.add(call.values);
        case 'Commit':
          await group.emitSignal('org.freedesktop.Avahi.EntryGroup', 'StateChanged', [
            DBusInt32(collisions-- > 0 ? 3 : 2),
            const DBusString(''),
          ]);
        case 'Free':
          freedGroups++;
      }
      return DBusMethodSuccessResponse([]);
    });
    browser = _Object('/browser', (call) async {
      if (call.name == 'Free') freedBrowsers++;
      return DBusMethodSuccessResponse([]);
    });
    await owner.registerObject(group);
    await owner.registerObject(browser);
  }

  @override
  Future<DBusMethodResponse> handleMethodCall(DBusMethodCall call) async {
    switch (call.name) {
      case 'GetHostName':
        return DBusMethodSuccessResponse([DBusString(hostname)]);
      case 'GetAlternativeServiceName':
        return DBusMethodSuccessResponse([const DBusString('DSlideshow test-frame #2')]);
      case 'EntryGroupNew':
        return DBusMethodSuccessResponse([DBusObjectPath('/entry')]);
      case 'ServiceBrowserPrepare':
        if (!prepareStarted.isCompleted) prepareStarted.complete();
        await prepareGate?.future;
        return DBusMethodSuccessResponse([DBusObjectPath('/browser')]);
      case 'ResolveService':
        resolutions.add(call.values[2].asString());
        activeResolves++;
        if (activeResolves > maxActiveResolves) maxActiveResolves = activeResolves;
        onResolveStarted?.call();
        await resolveGate?.future;
        activeResolves--;
        if (failResolve) return DBusMethodErrorResponse.failed('private-resolve-payload');
        return DBusMethodSuccessResponse([
          call.values[0],
          const DBusInt32(0),
          call.values[2],
          const DBusString('_dslideshow._tcp'),
          const DBusString('local'),
          const DBusString('test-frame.local'),
          const DBusInt32(0),
          DBusString(responseAddress),
          DBusUint16(responsePort),
          DBusArray(DBusSignature('ay'), []),
          const DBusUint32(0),
        ]);
    }
    return DBusMethodErrorResponse.unknownMethod();
  }

  Future<void> announce(String name, {bool remove = false, int interface = 1}) =>
      browser.emitSignal('org.freedesktop.Avahi.ServiceBrowser', remove ? 'ItemRemove' : 'ItemNew', [
        DBusInt32(interface),
        const DBusInt32(0),
        DBusString(name),
        const DBusString('_dslideshow._tcp'),
        const DBusString('local'),
        const DBusUint32(0),
      ]);

  Future<void> close() async {
    await owner.close();
    await server.close();
    await directory.delete(recursive: true);
  }
}

class _Object extends DBusObject {
  _Object(String path, this.handle) : super(DBusObjectPath(path));
  final Future<DBusMethodResponse> Function(DBusMethodCall) handle;
  @override
  Future<DBusMethodResponse> handleMethodCall(DBusMethodCall call) => handle(call);
}

class TrackingBus extends DBusClient {
  TrackingBus(super.address);
  int closes = 0;
  @override
  Future<void> close() async {
    closes++;
    await super.close();
  }
}
