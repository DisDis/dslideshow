import 'dart:async';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_flutter/features/ota/presentation/bloc/ota_bloc.dart';
import 'package:dslideshow_flutter/features/ota/presentation/bloc/ota_event.dart';
import 'package:dslideshow_flutter/features/ota/presentation/bloc/ota_state.dart';
import 'package:dslideshow_flutter/features/ota/presentation/bloc/terminal_backend.dart';
import 'package:dslideshow_flutter/src/route_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xterm/xterm.dart';

import 'support/ota_frontend.dart';

// Observe completion without replacing any initialization behavior or waiting
// an arbitrary number of event-loop turns for an async handler to finish.
class _ObservedOtaBloc extends OtaBloc {
  _ObservedOtaBloc({
    required super.frontendService,
    required super.backend,
    required super.routeBloc,
  });

  final initializationDone = Completer<void>();

  @override
  void onDone(OtaEvent event, [Object? error, StackTrace? stackTrace]) {
    super.onDone(event, error, stackTrace);
    if (event is OtaInitializationEvent && !initializationDone.isCompleted) {
      initializationDone.complete();
    }
  }
}

const _readyInfo = OTAInfo(
  status: OTAStatus.ready,
  uploadingPercent: 0,
  code: '83 472x',
);

void main() {
  late OtaTestFrontend frontend;
  late RouteBloc routes;
  late Terminal terminal;
  late _ObservedOtaBloc bloc;

  setUp(() {
    frontend = OtaTestFrontend();
    routes = RouteBloc();
    terminal = Terminal(maxLines: 3000);
    bloc = _ObservedOtaBloc(
      frontendService: frontend,
      backend: TerminalBackend(terminal),
      routeBloc: routes,
    );
  });

  tearDown(() async {
    frontend.infoCancellation?.complete();
    if (!frontend.infoResult.isCompleted) {
      frontend.infoResult.complete(_readyInfo);
    }
    if (!frontend.systemResult.isCompleted) {
      frontend.systemResult.complete(otaSystemInfo());
    }
    await bloc.close();
    await routes.close();
    await frontend.close();
  });

  Future<void> initialize() async {
    bloc.add(const OtaEvent.initialization());
    await Future.wait([
      frontend.infoRequested.future,
      frontend.systemRequested.future,
    ]).timeout(const Duration(seconds: 2));
  }

  Future<OtaState> nextState(bool Function(OtaState) matches) =>
      bloc.stream.firstWhere(matches).timeout(const Duration(seconds: 2));

  Future<void> initialized() =>
      bloc.initializationDone.future.timeout(const Duration(seconds: 2));

  test(
    'shows code while the network address is loading, then a usable URL',
    () async {
      await initialize();
      expect(bloc.state, isA<OtaInitialState>());

      final preparing = nextState((state) => state is OtaReadyState);
      frontend.infoResult.complete(_readyInfo);
      expect(
        await preparing,
        const OtaState.ready(
          info: _readyInfo,
          otaStartUrl: null,
          isPreparingAddress: true,
        ),
      );

      frontend.systemResult.complete(otaSystemInfo());
      await initialized();
      expect(
        bloc.state,
        const OtaState.ready(
          info: _readyInfo,
          otaStartUrl: 'http://192.168.50.143:8282/ota_start',
        ),
      );
    },
  );

  for (final status in OTAStatus.values) {
    test('initial snapshot preserves the $status stage', () async {
      await initialize();
      final info = _readyInfo.copyWith(status: status, uploadingPercent: 67);
      frontend.infoResult.complete(info);
      frontend.systemResult.complete(otaSystemInfo());
      await initialized();

      final expected = switch (status) {
        OTAStatus.disabled || OTAStatus.ready => isA<OtaReadyState>(),
        OTAStatus.uploading || OTAStatus.instaling => isA<OtaProgressState>(),
        OTAStatus.finished || OTAStatus.preReboot => isA<OtaSuccessState>(),
        OTAStatus.issue => isA<OtaFailureState>(),
      };
      expect(bloc.state, expected);
      expect(bloc.state.info, info);
    });
  }

  test(
    'network failure preserves code and never advertises loopback',
    () async {
      await initialize();
      frontend.infoResult.complete(_readyInfo);
      frontend.systemResult.completeError(StateError('Network unavailable'));
      await initialized();

      expect(
        bloc.state,
        const OtaState.ready(info: _readyInfo, otaStartUrl: null),
      );
    },
  );

  test(
    'loopback-only and empty interfaces do not produce a QR address',
    () async {
      await initialize();
      frontend.infoResult.complete(_readyInfo);
      frontend.systemResult.complete(
        otaSystemInfo(
          interfaces: const [
            NetworkInterfaceInfo(
              name: 'lo',
              status: NetworkInterfaceStatus.running,
              ip4: '127.0.0.1',
              ip6: '',
            ),
            NetworkInterfaceInfo(
              name: 'eth0',
              status: NetworkInterfaceStatus.running,
              ip4: '',
              ip6: '',
            ),
          ],
        ),
      );
      await initialized();
      expect(
        bloc.state,
        const OtaState.ready(info: _readyInfo, otaStartUrl: null),
      );
    },
  );

  test(
    'live status wins against a late snapshot and late network response',
    () async {
      await initialize();
      final installing = _readyInfo.copyWith(
        status: OTAStatus.instaling,
        uploadingPercent: 100,
      );
      final progress = nextState((state) => state is OtaProgressState);
      frontend.infoEvents.add(installing);
      expect((await progress).info, installing);

      frontend.infoResult.complete(_readyInfo);
      frontend.systemResult.complete(otaSystemInfo());
      await initialized();
      expect(bloc.state, OtaState.progress(info: installing));
    },
  );

  test(
    'live ready status gets an address without waiting for a stale snapshot',
    () async {
      await initialize();
      final ready = nextState(
        (state) => state is OtaReadyState && state.otaStartUrl != null,
      );
      frontend.infoEvents.add(_readyInfo);
      frontend.systemResult.complete(otaSystemInfo());
      expect(
        await ready,
        const OtaState.ready(
          info: _readyInfo,
          otaStartUrl: 'http://192.168.50.143:8282/ota_start',
        ),
      );
      frontend.infoResult.completeError(StateError('Late RPC failure'));
      await initialized();
      expect(bloc.state, isA<OtaReadyState>());
    },
  );

  test(
    'initial info failure ends loading without an unhandled error',
    () async {
      await initialize();
      frontend.infoResult.completeError(StateError('OTA unavailable'));
      frontend.systemResult.complete(otaSystemInfo());
      await initialized();

      expect(bloc.state, isA<OtaFailureState>());
      expect(bloc.state.info.status, OTAStatus.issue);
      expect(bloc.state.info.errorText, isNull);
    },
  );

  test(
    'exit wins against late initialization and subsequent live info',
    () async {
      await initialize();
      final exited = nextState((state) => state is OtaExitState);
      frontend.readyEvents.add(false);
      await exited;
      frontend.infoEvents.add(_readyInfo);
      frontend.infoResult.complete(_readyInfo);
      frontend.systemResult.complete(otaSystemInfo());
      await initialized();
      expect(bloc.state, isA<OtaExitState>());
    },
  );

  test(
    'terminal output preserves the installed stream and buffer protocol',
    () async {
      await initialize();
      frontend.infoResult.complete(_readyInfo);
      frontend.systemResult.complete(otaSystemInfo());
      await initialized();
      final written = Completer<void>();
      void onTerminalChange() {
        if (!written.isCompleted) written.complete();
      }

      terminal.addListener(onTerminalChange);
      addTearDown(() => terminal.removeListener(onTerminalChange));

      frontend.outputEvents.add('Installing\nDone');
      await written.future.timeout(const Duration(seconds: 2));
      expect(terminal.buffer.lines[0].getText(), 'Installing');
      expect(terminal.buffer.lines[1].getText(), 'Done');
      expect(bloc.state, isA<OtaReadyState>());
    },
  );

  test(
    'close awaits subscriptions and ignores pending RPC completion',
    () async {
      await initialize();
      frontend.infoCancellation = Completer<void>();
      var closed = false;
      final closing = bloc.close().then((_) => closed = true);

      expect(frontend.infoEvents.hasListener, isFalse);
      expect(frontend.outputEvents.hasListener, isFalse);
      expect(frontend.readyEvents.hasListener, isFalse);
      expect(frontend.buttons.hasListener, isFalse);
      expect(closed, isFalse);

      frontend.infoResult.completeError(StateError('Late RPC error'));
      frontend.systemResult.completeError(StateError('Late network error'));
      await initialized();
      expect(bloc.state, isA<OtaInitialState>());
      frontend.infoCancellation!.complete();
      frontend.infoCancellation = null;
      await closing.timeout(const Duration(seconds: 2));
      expect(bloc.isClosed, isTrue);
    },
  );

  test(
    'close does not wait for pending RPCs and handles their late errors',
    () async {
      await initialize();
      await bloc.close().timeout(const Duration(seconds: 2));
      expect(bloc.isClosed, isTrue);

      frontend.infoResult.completeError(StateError('Late OTA failure'));
      frontend.systemResult.completeError(StateError('Late network failure'));
      await initialized();
      expect(bloc.state, isA<OtaInitialState>());
    },
  );
}
