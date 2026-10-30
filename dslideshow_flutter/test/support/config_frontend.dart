import 'dart:async';

import 'package:dslideshow_backend/command.dart';

import 'slideshow_frontend.dart';
import 'ota_frontend.dart';

class ConfigTestFrontend extends TestFrontend {
  bool holdStart = true;
  bool holdStop = false;
  final starts = <Completer<String>>[];
  final stops = <Completer<void>>[];
  final stopRequested = Completer<void>();
  final systems = <Completer<SystemInfo>>[];
  final networkEvents = StreamController<SystemInfo>.broadcast();
  @override
  Stream<SystemInfo> get onSystemInfoUpdate => networkEvents.stream;
  @override
  Future<String> startWebServer() {
    final gate = Completer<String>();
    starts.add(gate);
    if (!holdStart) gate.complete('83472');
    return gate.future;
  }

  @override
  Future<void> stopWebServer() {
    final gate = Completer<void>();
    stops.add(gate);
    if (!stopRequested.isCompleted) stopRequested.complete();
    if (!holdStop) gate.complete();
    return gate.future;
  }

  @override
  Future<SystemInfo> getSystemInfo() {
    final gate = Completer<SystemInfo>();
    systems.add(gate);
    return gate.future;
  }

  void finishPending() {
    for (final gate in starts) {
      if (!gate.isCompleted) gate.complete('83472');
    }
    for (final gate in systems) {
      if (!gate.isCompleted) gate.complete(otaSystemInfo());
    }
    for (final gate in stops) {
      if (!gate.isCompleted) gate.complete();
    }
  }

  @override
  Future<void> close() async {
    finishPending();
    await networkEvents.close();
    await super.close();
  }
}
