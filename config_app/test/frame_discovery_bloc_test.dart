import 'dart:async';

import 'package:config_app/features/login/presentation/bloc/frame_discovery_bloc.dart';
import 'package:dslideshow_common/frame_discovery.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';

import 'support/frame_discovery.dart';

void main() {
  testWidgets('search deduplicates services, preserves identical hostnames and completes with virtual time', (
    tester,
  ) async {
    final provider = ControlledFrameProvider();
    final bloc = FrameDiscoveryBloc(provider: provider);
    bloc.add(const FrameDiscoveryEvent.search());
    bloc.add(const FrameDiscoveryEvent.search());
    await tester.pump();
    expect(provider.sessions, hasLength(1));
    final session = provider.sessions.single;
    session.controller.add(const FrameDiscoveryUpdate.resolved(firstFrame));
    session.controller.add(const FrameDiscoveryUpdate.resolved(firstFrame));
    session.controller.add(const FrameDiscoveryUpdate.resolved(secondFrame));
    await tester.pump();
    expect(bloc.state.frames, [firstFrame, secondFrame]);
    session.controller.add(FrameDiscoveryUpdate.lost(firstFrame.serviceKey));
    session.controller.add(const FrameDiscoveryUpdate.limited());
    session.controller.add(const FrameDiscoveryUpdate.resolveFailed());
    await tester.pump();
    expect(bloc.state.frames, [secondFrame]);
    expect(bloc.state.limited, isTrue);
    expect(bloc.state.unresolved, 1);
    await tester.pump(FrameDiscoveryBloc.defaultSearchDuration);
    expect(bloc.state.status, FrameDiscoveryStatus.completed);
    expect(session.closes, 1);
    bloc.add(const FrameDiscoveryEvent.search());
    await tester.pump();
    expect(provider.sessions, hasLength(2));
    expect(bloc.state.frames, [secondFrame]);
    await tester.runAsync(bloc.close);
  });

  testWidgets('failed retry retains known frames while a clean scan replaces obsolete results', (tester) async {
    final provider = ControlledFrameProvider();
    final bloc = FrameDiscoveryBloc(provider: provider);
    bloc.add(const FrameDiscoveryEvent.search());
    await tester.pump();
    provider.sessions.single.controller.add(const FrameDiscoveryUpdate.resolved(firstFrame));
    await tester.pump();
    await tester.pump(FrameDiscoveryBloc.defaultSearchDuration);
    bloc.add(const FrameDiscoveryEvent.search());
    await tester.pump();
    expect(bloc.state.frames, [firstFrame]);
    provider.sessions.last.controller.add(const FrameDiscoveryUpdate.resolveFailed());
    await tester.pump();
    await tester.pump(FrameDiscoveryBloc.defaultSearchDuration);
    expect(bloc.state.frames, [firstFrame]);
    expect(bloc.state.unresolved, 1);
    bloc.add(const FrameDiscoveryEvent.search());
    await tester.pump();
    provider.sessions.last.controller.addError(StateError('transport failure'));
    await tester.pump();
    expect(bloc.state.status, FrameDiscoveryStatus.failure);
    expect(bloc.state.frames, [firstFrame]);
    bloc.add(const FrameDiscoveryEvent.search());
    await tester.pump();
    provider.sessions.last.controller.add(const FrameDiscoveryUpdate.resolved(secondFrame));
    await tester.pump();
    expect(bloc.state.frames, [firstFrame, secondFrame]);
    await tester.pump(FrameDiscoveryBloc.defaultSearchDuration);
    expect(bloc.state.frames, [secondFrame]);
    bloc.add(const FrameDiscoveryEvent.search());
    await tester.pump();
    await tester.pump(FrameDiscoveryBloc.defaultSearchDuration);
    expect(bloc.state.frames, isEmpty);
    await tester.runAsync(bloc.close);
  });

  testWidgets('startup failure and transport failure are distinct, retry releases resources and logs are safe', (
    tester,
  ) async {
    final provider = ControlledFrameProvider()
      ..next = () => ControlledFrameSession()..startError = StateError('private-startup-url');
    final records = <LogRecord>[];
    final previous = Logger.root.level;
    Logger.root.level = Level.ALL;
    final subscription = Logger.root.onRecord.listen(records.add);
    final bloc = FrameDiscoveryBloc(provider: provider);
    bloc.add(const FrameDiscoveryEvent.search());
    await tester.pump();
    expect(bloc.state.status, FrameDiscoveryStatus.unavailable, reason: records.map((r) => r.message).join('\n'));
    expect(provider.sessions.single.closes, 1);
    provider.next = null;
    bloc.add(const FrameDiscoveryEvent.search());
    await tester.pump();
    provider.sessions.last.controller.addError(StateError('private-transport-url'));
    await tester.pump();
    expect(bloc.state.status, FrameDiscoveryStatus.failure);
    expect(provider.sessions.last.closes, 1);
    final messages = records.map((record) => record.message).join('\n');
    expect(messages, contains('Search started retained=0'));
    expect(messages, contains('Search unavailable type=StateError'));
    expect(messages, contains('Search failed found=0 confirmed=0'));
    expect(messages, isNot(contains('scan=')));
    expect(messages, isNot(contains('private-')));
    expect(records.every((record) => record.error == null), isTrue);
    await tester.runAsync(bloc.close);
    await tester.runAsync(subscription.cancel);
    Logger.root.level = previous;
  });

  testWidgets('background cancels a pending start and late readiness does not restart the timer', (tester) async {
    final gate = Completer<void>();
    final provider = ControlledFrameProvider()..next = () => ControlledFrameSession()..startGate = gate;
    final bloc = FrameDiscoveryBloc(provider: provider);
    bloc.add(const FrameDiscoveryEvent.search());
    await tester.pump();
    bloc.didChangeAppLifecycleState(AppLifecycleState.paused);
    await tester.pump();
    expect(provider.sessions.single.closes, 1);
    expect(bloc.state.status, FrameDiscoveryStatus.completed);
    gate.complete();
    await tester.pump();
    await tester.pump(FrameDiscoveryBloc.defaultSearchDuration + const Duration(seconds: 1));
    expect(bloc.state.frames, isEmpty);
    await tester.runAsync(bloc.close);
    expect(provider.sessions.single.closes, 1);
  });

  testWidgets('closing during initialization waits for the handler without a late emit', (tester) async {
    final gate = Completer<void>();
    final provider = ControlledFrameProvider()..next = () => ControlledFrameSession()..startGate = gate;
    final bloc = FrameDiscoveryBloc(provider: provider);
    bloc.add(const FrameDiscoveryEvent.search());
    await tester.pump();
    final closed = tester.runAsync(bloc.close);
    gate.completeError(StateError('late-private-startup'));
    await closed;
    expect(provider.sessions.single.closes, 1);
  });
}
