import 'support/config_harness.dart';

import 'package:dslideshow_flutter/src/route_bloc.dart';

import 'package:dslideshow_flutter/features/config/data/config_access_repository.dart';
import 'package:dslideshow_flutter/features/config/presentation/bloc/config_bloc.dart';
import 'package:dslideshow_flutter/features/config/presentation/bloc/config_event.dart';
import 'package:dslideshow_flutter/features/config/presentation/bloc/config_state.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/config_frontend.dart';
import 'support/ota_frontend.dart';

void main() {
  testWidgets('start awaits the reliable RPC without a local timeout or duplicate request', (tester) async {
    final frontend = ConfigTestFrontend();
    final repository = ConfigAccessRepository(frontend: frontend, port: 8181, alwaysEnabled: false);
    final bloc = ConfigBloc(repository: repository);
    try {
      bloc.add(const ConfigEvent.initialize());
      await tester.pump();
      frontend.systems.single.complete(otaSystemInfo());
      await tester.pump();
      await tester.pump(const Duration(seconds: 30));
      expect(bloc.state.phase, ConfigPhase.preparing);
      expect(bloc.state.failure, isNull);
      expect(bloc.state.canRetry, isFalse);
      bloc.add(const ConfigEvent.retry());
      await tester.pump();
      expect(frontend.starts, hasLength(1));
      frontend.starts.single.complete('12345');
      await tester.pump();
      expect(bloc.state.phase, ConfigPhase.ready);
      expect(frontend.starts, hasLength(1));
      expect(bloc.state.code, '12345');
    } finally {
      frontend.finishPending();
      await closeConfigBloc(tester, bloc);
      await frontend.close();
    }
  });
  configWidgetTest('network request awaits its result and applies it without an extra retry', (tester, h) async {
    await h.mount(tester);
    h.frontend.starts.single.complete('83472');
    await tester.pump();
    await tester.pump(const Duration(seconds: 30));
    expect(h.bloc.state.phase, ConfigPhase.preparingAddress);
    expect(h.bloc.state.failure, isNull);
    expect(h.bloc.state.code, '83472');
    expect(h.bloc.state.address, isNull);
    expect(h.bloc.state.canRetry, isFalse);
    h.frontend.systems.single.complete(otaSystemInfo());
    await tester.pump();
    expect(h.bloc.state.phase, ConfigPhase.ready);
    expect(h.frontend.systems, hasLength(1));
    expect(h.frontend.starts, hasLength(1));
  });
  configWidgetTest('stop awaits its RPC result before returning and ignores duplicate exit', (tester, h) async {
    await h.mount(tester);
    h.frontend.starts.single.complete('83472');
    h.frontend.systems.single.complete(otaSystemInfo());
    await tester.pump();
    h.frontend.holdStop = true;
    h.bloc.add(const ConfigEvent.exit());
    await tester.pump();
    await tester.pump(const Duration(seconds: 30));
    expect(h.bloc.state.phase, ConfigPhase.closing);
    expect(h.bloc.state.canRetry, isFalse);
    h.bloc.add(const ConfigEvent.exit());
    await tester.pump();
    expect(h.bloc.state.phase, ConfigPhase.closing);
    h.frontend.stops.single.complete();
    await tester.pump();
    expect(h.bloc.state.phase, ConfigPhase.exited);
    expect(h.routes.state.current, RoutePage.slideshow);
    expect(h.frontend.stops, hasLength(1));
  });
}
